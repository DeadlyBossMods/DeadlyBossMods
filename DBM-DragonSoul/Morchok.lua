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
local warnKohcrom		= mod:NewSpellAnnounce(109017, 4)
local KohcromWarning	= mod:NewAnnounce("KohcromWarning", 2, 55342)--Mirror image icon. use different color for easlier distingush.

local specwarnCrushArmor	= mod:NewSpecialWarningStack(103687, mod:IsTank(), 3)
local specwarnVortex		= mod:NewSpecialWarningSpell(110047, nil, nil, nil, true)
local specwarnBlood			= mod:NewSpecialWarningMove(108570)
local specwarnCrystal		= mod:NewSpecialWarningSpell(103639, false)

local timerCrushArmor	= mod:NewTargetTimer(20, 103687, nil, mod:IsTank())
local timerCrystal		= mod:NewCDTimer(12, 103640)	-- 12-14sec variation (is also time till 'detonate')
local timerStomp 		= mod:NewCDTimer(12, 108571)	-- 12-14sec variation
local timerVortexNext	= mod:NewNextTimer(71, 110047)--97 sec after last vortex, but only 71 after last blood ended. More efficent this way.
local timerBlood		= mod:NewBuffActiveTimer(17, 103851)
local timerKohcromCD	= mod:NewTimer(6, "KohcromCD", 55342)--Enable when we have actual timing for any of his abilies, timer value here will be useless placeholder.
--Basically any time morchok casts, we'll start an echo timer for when it will be mimiced by his twin Kohcrom. 
--We will not start timers using Kohcrom's casts, it'll waste WAY too much space.
--EJ is pretty clear, they are cast shortly after morchok, always. So echo timer is perfect and clean solution.

local berserkTimer		= mod:NewBerserkTimer(420)

mod:AddBoolOption("RangeFrame", false)--For achievement

local spamBlood = 0
local crystalCount = 0--3 crystals between each vortex cast by Morchok, we ignore his twins.
local firstCrystalSummoned = false

function mod:OnCombatStart(delay)
	spamBlood = 0
	crystalCount = 1--only 2 before first aoe so we fake set it to 1 on pull.
	firstCrystalSummoned = false
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
--[[				"<31.7> [CLEU] SPELL_CAST_START#false#0xF130D7E10000D438#Morchok#133704#0#0x0000000000000000#nil#-2147483648#-2147483648#109034#Stomp#1", -- [7458]
					"<36.9> [CLEU] SPELL_CAST_START#false#0xF130E1AD0000D7D6#Kohcrom#68168#0#0x0000000000000000#nil#-2147483648#-2147483648#109034#Stomp#1", -- [8962]
					"<46.1> [CLEU] SPELL_CAST_START#false#0xF130D7E10000D438#Morchok#133704#0#0x0000000000000000#nil#-2147483648#-2147483648#109034#Stomp#1", -- [11548]
					"<51.4> [CLEU] SPELL_CAST_START#false#0xF130E1AD0000D7D6#Kohcrom#68168#0#0x0000000000000000#nil#-2147483648#-2147483648#109034#Stomp#1", -- [12939]
					"<104.0> [CLEU] SPELL_CAST_START#false#0xF130D7E10000D438#Morchok#133704#0#0x0000000000000000#nil#-2147483648#-2147483648#109034#Stomp#1", -- [22492]
					"<109.2> [CLEU] SPELL_CAST_START#false#0xF130E1AD0000D7D6#Kohcrom#68168#0#0x0000000000000000#nil#-2147483648#-2147483648#109034#Stomp#1", -- [23731]
					-- transcriptor log not valid timestamp, may be (GetTime() issue?)
					-- for wow CLEU stomp cooldown is always 6 sec. and actually fights.
					12/13 02:48:11.850  SPELL_CAST_START,0xF130D7E10000006D,"Morchok",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,109033,"Stomp",0x1
					12/13 02:48:17.865  SPELL_CAST_START,0xF130E1AD00000755,"Kohcrom",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,109033,"Stomp",0x1
					12/13 02:48:26.307  SPELL_CAST_START,0xF130D7E10000006D,"Morchok",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,109033,"Stomp",0x1
					12/13 02:48:32.330  SPELL_CAST_START,0xF130E1AD00000755,"Kohcrom",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,109033,"Stomp",0x1
					12/13 02:52:37.114  SPELL_CAST_START,0xF130D7E1000007C2,"Morchok",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,109033,"Stomp",0x1
					12/13 02:52:43.105  SPELL_CAST_START,0xF130E1AD000008A7,"Kohcrom",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,109033,"Stomp",0x1
					12/13 03:29:04.315  SPELL_CAST_START,0xF130D7E100001298,"Morchok",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,109033,"Stomp",0x1
					12/13 03:29:10.318  SPELL_CAST_START,0xF130E1AD000012D5,"Kohcrom",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,109033,"Stomp",0x1
					12/13 03:29:18.740  SPELL_CAST_START,0xF130D7E100001298,"Morchok",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,109033,"Stomp",0x1
					12/13 03:29:24.767  SPELL_CAST_START,0xF130E1AD000012D5,"Kohcrom",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,109033,"Stomp",0x1
]]
					timerKohcromCD:Start(6, args.spellName)
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
				if UnitExists("boss2") and firstCrystalSummoned and crystalCount > 1 then	-- only mimics 2nd+3rd Crystals. on first encounter, he mimicks only 3rd (2nd) crystals.
					timerKohcromCD:Start(6, args.spellName)
				end
				if UnitExists("boss2") and not firstCrystalSummoned then
					firstCrystalSummoned = true
				end
			end
		else
			KohcromWarning:Show(args.sourceName, args.spellName)
		end
	elseif args:IsSpeellID(109017) then
		warnKohcrom:Show()
		-- once Kohcrom summoned, stomp and Crystal timer restarts. For my encounter, always show Kohcrom before first crystal summons. so confirmed only one way.
		if not firstCrystalSummoned then
			timerCrystal:Cancel()
			timerStomp:Cancel()
			timerCrystal:Start(5.5) -- 5.5~6.8 sec
			timerStomp:Start(12)
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
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(103785, 108570, 110287, 110288) and args:IsPlayer() and GetTime() - spamBlood > 3 then
		specwarnBlood:Show()
		spamBlood = GetTime()
	end
end
