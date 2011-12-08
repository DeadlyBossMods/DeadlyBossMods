local mod	= DBM:NewMod(311, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(55265)
mod:SetModelID(39094)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_SUMMON",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

local warnCrushArmor	= mod:NewStackAnnounce(103687, 3, nil, mod:IsTank() or mod:IsHealer())
local warnCrystal		= mod:NewSpellAnnounce(103639, 3)
local warnStomp			= mod:NewSpellAnnounce(108571, 3)
local warnVortex		= mod:NewSpellAnnounce(110047, 3)
local warnBlood			= mod:NewSpellAnnounce(103851, 4)
local warnFurious		= mod:NewSpellAnnounce(103846, 3)
local KohcromWarning	= mod:NewAnnounce("KohcromWarning", 3, 55342)--Mirror image icon.

local specwarnCrushArmor	= mod:NewSpecialWarningStack(103687, mod:IsTank(), 3)
local specwarnVortex		= mod:NewSpecialWarningSpell(110047, nil, nil, nil, true)
local specwarnBlood			= mod:NewSpecialWarningMove(108570)
local specwarnCrystal		= mod:NewSpecialWarningSpell(103639, false)

local timerCrushArmor	= mod:NewTargetTimer(20, 103687, nil, mod:IsTank())
local timerCrystal		= mod:NewCDTimer(12, 103640)	-- 12-14sec variation (is also time till 'detonate')
local timerStomp 		= mod:NewCDTimer(12, 108571)	-- 12-14sec variation
local timerVortexNext	= mod:NewNextTimer(71, 110047)--97 sec after last vortex, but only 71 after last blood ended. More efficent this way.
local timerBlood		= mod:NewBuffActiveTimer(17, 103851)
local timerKohcromCD	= mod:NewTimer(5, "KohcromCD", 55342)--Enable when we have actual timing for any of his abilies, timer value here will be useless placeholder.
--Basically any time morchok casts, we'll start an echo timer for when it will be mimiced by his twin Kohcrom. 
--We will not start timers using Kohcrom's casts, it'll waste WAY too much space.
--EJ is pretty clear, they are cast shortly after morchok, always. So echo timer is perfect and clean solution.

local berserkTimer		= mod:NewBerserkTimer(420)

mod:AddBoolOption("RangeFrame", false)--For achievement

local spamBlood = 0
local crystalCount = 0--3 crystals between each vortex cast by Morchok, we ignore his twins.

function mod:OnCombatStart(delay)
	spamBlood = 0
	crystalCount = 1--only 2 before first aoe so we fake set it to 1 on pull.
	if self:IsDifficulty("heroic10", "heroic25") then
		berserkTimer:Start(-delay)--7 min berserk based on a video, so may not be 100%
	end
	timerStomp:Start(-delay)
	timerCrystal:Start(19-delay)
	timerVortexNext:Start(54-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(103687) then
		warnCrushArmor:Show(args.destName, args.amount or 1)
		timerCrushArmor:Start(args.destName)
		if (args.amount or 1) > 3 then
			specwarnCrushArmor:Show(args.amount or 1)
		end
	elseif args:IsSpellID(103846) then
		warnFurious:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(103851) then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if args:GetSrcCreatureID() == 55265 then--Filter out Kohcrom here. his echo timers should handle themselves all on their own, but we don't want Kohcrom cast messing up Morchok's timers.
			timerStomp:Start(19)
			timerCrystal:Start(26)
			timerVortexNext:Start()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(103414, 108571, 109033, 109034) then
		if args:GetSrcCreatureID() == 55265 then
			warnStomp:Show()
			if crystalCount < 3 then
				timerStomp:Start()
				if UnitExists("boss2") then
					timerKohcromCD:Start(5, args.spellName)--Based on video only, seemed to always stomp 5 second after morchok
				end
			end
		else
			KohcromWarning:Show(args.sourceName, args.spellName)
		end
	elseif args:IsSpellID(103851) then
		if args:GetSrcCreatureID() == 55265 then
			warnBlood:Show()
			timerBlood:Start()
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(103639) then
		specwarnCrystal:Show()
		if args:GetSrcCreatureID() == 55265 then
			crystalCount = crystalCount + 1
			warnCrystal:Show()
			if crystalCount < 3 then	
				timerCrystal:Start()
				if UnitExists("boss2") and crystalCount > 1 then	-- only mimics 2nd+3rd Crystals?
					timerKohcromCD:Start(5, args.spellName)
				end
			end
		else
			KohcromWarning:Show(args.sourceName, args.spellName)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(103821, 110045, 110046, 110047) then
		specwarnVortex:Show()--No reason to split the special warning into 2, it's just an attention getter and doesn't stay on screen like normal messages.
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
		if args:GetSrcCreatureID() == 55265 then--Morchok casting it. Seems they cast this at same time, so no reason to announce twin doing it.
			crystalCount = 0
			warnVortex:Show()
		end
--	elseif args:IsSpellID(109017) then--Summon Kohcrom

	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(103785, 108570, 110287, 110288) and args:IsPlayer() and GetTime() - spamBlood > 3 then
		specwarnBlood:Show()
		spamBlood = GetTime()
	end
end
