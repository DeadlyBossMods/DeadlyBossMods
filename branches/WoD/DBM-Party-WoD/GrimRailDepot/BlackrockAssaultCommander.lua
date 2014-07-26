local mod	= DBM:NewMod(1163, "DBM-Party-WoD", 3, 536)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79545)
mod:SetEncounterID(1732)
mod:SetZone()

mod:RegisterCombat("combat")
--[[
mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

local warnRavage			= mod:NewTargetAnnounce(119946, 3)--Mu'Shiba's Fixate attack
local warnShockwave			= mod:NewSpellAnnounce(119922, 4)--Kuai's Attack
local warnWhirlingDervish	= mod:NewSpellAnnounce(119981, 3)--Ming's Attack
local warnTraumaticBlow		= mod:NewTargetAnnounce(123655, 3)--Haiyan's Attack
local warnConflag			= mod:NewTargetAnnounce(120201, 3)--Haiyan's Attack
--local warnMeteor			= mod:NewTargetAnnounce(120195, 4)--Haiyan's Attack

local specWarnRavage		= mod:NewSpecialWarningTarget(119946, mod:IsHealer())
local specWarnShockwave		= mod:NewSpecialWarningMove(119922, mod:IsTank())--Not sure if he always faced it toward tank, or did it blackhorn style, if it's blackhorn style this needs to be changed to a targetscan if possible
local specWarnLightningBolt	= mod:NewSpecialWarningInterrupt(123654, false)
local specWarnConflag		= mod:NewSpecialWarningTarget(120201, mod:IsHealer())
--local specWarnMeteor		= mod:NewSpecialWarningTarget(120195, nil, nil, nil, true)

local timerRavage			= mod:NewTargetTimer(11, 119946)
local timerRavageCD			= mod:NewCDTimer(20, 119946)
local timerShockwaveCD		= mod:NewNextTimer(15, 119922)
local timerWhirlingDervishCD= mod:NewCDTimer(22, 119981)
local timerTraumaticBlow	= mod:NewTargetTimer(5, 123655)
local timerTraumaticBlowCD	= mod:NewCDTimer(17, 123655)--17-21sec variation
local timerConflag			= mod:NewTargetTimer(5, 120201)
local timerConflagCD		= mod:NewCDTimer(22, 120201)--Limited data, may not be completely accurate
local timerMeteorCD			= mod:NewNextTimer(55, 120195)--Assumed based on limited data

local shockwaveCD = 15
local kuai = EJ_GetSectionInfo(6015)
local ming = EJ_GetSectionInfo(6019)
local haiyan = EJ_GetSectionInfo(6023)

function mod:OnCombatStart(delay)
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 119946 then
		warnRavage:Show(args.destName)
		specWarnRavage:Show(args.destName)
		timerRavage:Start(args.destName)
		timerRavageCD:Start()
	elseif args.spellId == 123655 then
		warnTraumaticBlow:Show(args.destName)
		timerTraumaticBlow:Start(args.destName)
		timerTraumaticBlowCD:Start()
	elseif args.spellId == 120201 then
		warnConflag:Show(args.destName)
		specWarnConflag:Show(args.destName)
		timerConflag:Start(args.destName)
		timerConflagCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 119946 then
		timerRavage:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 119922 then
		warnShockwave:Show()
		specWarnShockwave:Show()
		timerShockwaveCD:Start(shockwaveCD)
	elseif args.spellId == 119981 then
		warnWhirlingDervish:Show()
		timerWhirlingDervishCD:Start()
	elseif args.spellId == 123654 then
		specWarnLightningBolt:Show(args.sourceName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Kuai or msg:find(L.Kuai) then
		shockwaveCD = 15
		timerWhirlingDervishCD:Cancel()
		timerConflagCD:Cancel()
		timerMeteorCD:Cancel()
		timerTraumaticBlowCD:Cancel()
		timerShockwaveCD:Start(19)--Not confirmed through multiple pulls, just one
		timerRavageCD:Start(26)
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(61442, kuai)
		end
	elseif msg == L.Ming or msg:find(L.Ming) then
		timerShockwaveCD:Cancel()
		timerRavageCD:Cancel()
		timerConflagCD:Cancel()
		timerMeteorCD:Cancel()
		timerTraumaticBlowCD:Cancel()
		timerWhirlingDervishCD:Start(22)--Not confirmed through multiple pulls, just one
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(61444, ming)
		end
	elseif msg == L.Haiyan or msg:find(L.Haiyan) then
		timerWhirlingDervishCD:Cancel()
		timerShockwaveCD:Cancel()
		timerRavageCD:Cancel()
		timerConflagCD:Start()--Not confirmed through multiple pulls, just one
		timerMeteorCD:Start(42)
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(61445, haiyan)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 61453 then
		timerRavageCD:Cancel()
		shockwaveCD = 10--Need more data to confirm this but appears to be case.
	end
end
--]]
