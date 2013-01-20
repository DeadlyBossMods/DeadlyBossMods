if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(817, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68079, 68080, 68081, 68078)--Ro'shak 68079, Quet'zal 68080, Dam'ren 68081, Iron Qon 68078
mod:SetModelID(46627) -- Iron Qon, 46628 Ro'shak, 46629 Quet'zal, 46630 Dam'ren

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_DIED"
)

local warnThrowSpear					= mod:NewSpellAnnounce(134926, 3)--TODO, TEST target scanning here. It's probably touchy as shannox SPELL_SUMMON target scanning so will probably use same code
local warnLightningStorm				= mod:NewSpellAnnounce(136192, 3)

local specWarnThrowSpear				= mod:NewSpecialWarningSpell(134926, nil, nil, nil, true)
local specWarnBurningCinders			= mod:NewSpecialWarningMove(137668)
local specWarnMoltenOverload			= mod:NewSpecialWarningSpell(137221, nil, nil, nil, true)
local specWarnWindStorm					= mod:NewSpecialWarningSpell(136577, nil, nil, nil, true)
local specWarnStormCloud				= mod:NewSpecialWarningMove(137669)

local timerThrowSpearCD					= mod:NewCDTimer(30, 134926)--30-36 second variation observed (at last in phase 1)
local timerUnleashedFlameCD				= mod:NewCDTimer(6, 134611)
local timerScorched						= mod:NewBuffFadesTimer(30, 134647)
local timerMoltenOverload				= mod:NewBuffActiveTimer(10, 137221)
local timerLightningStormCD				= mod:NewCDTimer(20, 136192)--Very well may be wrong, super small sample size thanks to horde
local timerWindStormCD					= mod:NewCDTimer(50, 136577)--Actual cd is not known, just know the first one is 50 seconds after phase 1

mod:AddBoolOption("RangeFrame", true)--One tooltip says 8 yards, other says 10. Confirmed it's 10 during testing though. Ignore the 8 on spellid 134611

local phase = 1--Not sure this is useful yet, coding it in, in case spear cd is different in different phases

function mod:OnCombatStart(delay)
	phase = 1
	timerThrowSpearCD:Start(13-delay)
	if self:IsDifficulty("normal10", "heroic10") then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10, nil, nil, 2)--You can have 1 person in range safely. Frame goes red at 2
		end
	else
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10, nil, nil, 4)--You can have 3 others near you, frame goes red at 4
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end


function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(134647) then
		--Once more strats are formed, maybe insert some rotation stuff here
		if args:IsPlayer() then
			timerScorched:Start()
		end
	elseif args:IsSpellID(137221) then
		specWarnMoltenOverload:Show()
		timerMoltenOverload:Start()
	--"<255.6 20:41:32> [CLEU] SPELL_AURA_APPLIED#true##nil#2632#0#0x0100000000003591#Shiramune#1298#0#136577#Wind Storm#8#DEBUFF", -- [18923]
	elseif args:IsSpellID(136577) and self:AntiSpam(30, 1) then--No idea what cd is, when we find out, will need to adjust anti spam to prevent it from activating from players walking into old one
		specWarnWindStorm:Show()
--		timerWindStormCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(134647) and args:IsPlayer() then
		timerScorched:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(136192) then
		warnLightningStorm:Show()
		timerLightningStormCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(134926) then
		warnThrowSpear:Show()
		specWarnThrowSpear:Show()
	end
end

--[[
--One of these is standing in fire and you need to move,other is dot you can't do anything about cause you stood in it too long. I'm not sure which is which so mod may be backwards, if it is, swap the damage events
"<54.8 20:15:39> [CLEU] SPELL_PERIODIC_DAMAGE#true##nil#1297#2#0x0100000000001E03#Omegal#1297#2#137668#Burning Cinders#4#15972#-1#4#nil#nil#nil#nil#nil#nil#nil", -- [3846]
"<55.4 20:15:39> [CLEU] SPELL_DAMAGE#true##nil#1298#8#0x01000000000036C3#Ixila#1298#8#137668#Burning Cinders#4#8896#-1#4#nil#nil#17562#nil#nil#nil#nil", -- [3905]
--]]
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 137668 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnBurningCinders:Show()
	elseif spellId == 137669 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnStormCloud:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 134611 and self:AntiSpam(2, 4) then--Unleashed Flame internal CD. He cannot use more often than every 6 seconds. 137991 is ability activation on pull, before 137991 is cast, he can't use ability at all
		timerUnleashedFlameCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68079 then--Ro'shak
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10, nil, nil, 1)--Switch range frame back to 1. Range is assumed 10, no spell info
		end
		--Only one log, but i looks like spear cd from phase 1 remains intact
		phase = 2
		timerUnleashedFlameCD:Cancel()
		timerMoltenOverload:Cancel()
		timerLightningStormCD:Start(17)
		timerWindStormCD:Start(49.5)
		print("Mod beyond phase 1 incomplete. You can thank horde grieving instance portal for that")
	elseif cid == 68080 then--Quet'zal
		phase = 3
		timerLightningStormCD:Cancel()
		timerWindStormCD:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif cid == 68081 then--Dam'ren
		phase = 4
	end
end
