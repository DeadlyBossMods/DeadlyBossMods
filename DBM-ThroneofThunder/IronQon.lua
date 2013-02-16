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

local warnImpale						= mod:NewStackAnnounce(134691, 2, nil, mod:IsTank() or mod:IsHealer())
local warnThrowSpear					= mod:NewSpellAnnounce(134926, 3)--TODO, TEST target scanning here. It's probably touchy as shannox SPELL_SUMMON target scanning so will probably use same code
local warnLightningStorm				= mod:NewSpellAnnounce(136192, 3)
local warnDeadZone						= mod:NewAnnounce("warnDeadZone", 3, 137229)

local specWarnImpale					= mod:NewSpecialWarningStack(134691, mod:IsTank(), 4)--Assumed value drycode, won't know until cd is observed
local specWarnImpaleOther				= mod:NewSpecialWarningTarget(134691, mod:IsTank())
local specWarnThrowSpear				= mod:NewSpecialWarningSpell(134926, nil, nil, nil, true)
local specWarnBurningCinders			= mod:NewSpecialWarningMove(137668)
local specWarnMoltenOverload			= mod:NewSpecialWarningSpell(137221, nil, nil, nil, true)
local specWarnWindStorm					= mod:NewSpecialWarningSpell(136577, nil, nil, nil, true)
local specWarnStormCloud				= mod:NewSpecialWarningMove(137669)
local specWarnFrozenBlood				= mod:NewSpecialWarningMove(136520)

local timerImpale						= mod:NewTargetTimer(40, 134691, mod:IsTank() or mod:IsHealer())
--local timerImpaleCD						= mod:NewCDTimer(10, 134691, mod:IsTank() or mod:IsHealer())
local timerThrowSpearCD					= mod:NewCDTimer(30, 134926)--30-36 second variation observed (at last in phase 1)
local timerUnleashedFlameCD				= mod:NewCDTimer(6, 134611)
local timerScorched						= mod:NewBuffFadesTimer(30, 134647)
local timerMoltenOverload				= mod:NewBuffActiveTimer(10, 137221)
local timerLightningStormCD				= mod:NewCDTimer(20, 136192)--Very well may be wrong, super small sample size thanks to horde
local timerWindStormCD					= mod:NewCDTimer(90, 136577)--Actual cd is not known, just know the first one is 50 seconds after phase 1
local timerDeadZoneCD					= mod:NewCDTimer(15, 137229)


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
	if args:IsSpellID(134691) then
		warnImpale:Show(args.destName, args.amount or 1)
--		timerImpaleCD:Start()
		if args:IsPlayer() then
			if (args.amount or 1) >= 4 then
				specWarnImpale:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 3 and not UnitDebuff("player", GetSpellInfo(134691)) and not UnitIsDeadOrGhost("player") then
				specWarnImpaleOther:Show(args.destName)
			end
		end
	elseif args:IsSpellID(134647) then
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
	--Dead zone IDs, each dead zone has two shields and two openings. Each spellid identifies those openings.
	elseif args:IsSpellID(137226) then--Front, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_FRONT, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		--Attack left or Behind (maybe add special warning that says where you can attack, for dps?)
	elseif args:IsSpellID(137227) then--Left, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_LEFT, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		--Attack Front or Behind
	elseif args:IsSpellID(137228) then--Left, Front Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_LEFT, DBM_CORE_FRONT)
		timerDeadZoneCD:Start()
		--Attack Right or Behind
	elseif args:IsSpellID(137229) then--Back, Front Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_FRONT)
		timerDeadZoneCD:Start()
		--Attack left or Right
	elseif args:IsSpellID(137230) then--Back, Left Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_LEFT)
		timerDeadZoneCD:Start()
		--Attack Front or Right
	elseif args:IsSpellID(137231) then--Back, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		--Attack Front or Left
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(134926) then
		warnThrowSpear:Show()
		specWarnThrowSpear:Show()
		timerThrowSpearCD:Start()
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
	elseif spellId == 136520 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 134611 and self:AntiSpam(2, 5) then--Unleashed Flame internal CD. He cannot use more often than every 6 seconds. 137991 is ability activation on pull, before 137991 is cast, he can't use ability at all
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
		timerDeadZoneCD:Cancel()
		phase = 4
	end
end
