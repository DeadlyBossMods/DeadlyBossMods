local mod	= DBM:NewMod(1492, "DBM-Party-Legion", 3, 716)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(96028)
mod:SetEncounterID(1814)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 192706",
	"SPELL_AURA_REMOVED 192706",
	"SPELL_CAST_START 192617 192985",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnMythicTornado				= mod:NewSpellAnnounce(192680, 3)--target scanning not available
local warnArcaneBomb				= mod:NewTargetAnnounce(192706, 4)

local specWarnMassiveDeluge			= mod:NewSpecialWarningDodge(192617, "Tank", nil, nil, 3, 2)
local specWarnArcaneBomb			= mod:NewSpecialWarningMoveAway(192706, nil, nil, nil, 3, 2)
local yellArcaneBomb				= mod:NewYell(192706)

local timerMythicTornadoCD			= mod:NewCDTimer(25, 192680, nil, nil, nil, 3)
local timerMassiveDelugeCD			= mod:NewCDTimer(50, 192617, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerArcaneBomb				= mod:NewTargetTimer(15, 192706, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)--Magic dispel for healer to dispel at correct time
local timerArcaneBombCD				= mod:NewCDTimer(23, 192706, nil, nil, nil, 3)--23-37

local voiceMassiveDeluge			= mod:NewVoice(192617, "Tank")--shockwave
local voiceArcaneBomb				= mod:NewVoice(192706)--runout

mod:AddRangeFrameOption(10, 192706)

mod.vb.phase = 1
local serpMod = DBM:GetModByName(1479)

function mod:CheckPhase2()
	return 
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerMythicTornadoCD:Start(8.5-delay)
	timerMassiveDelugeCD:Start(12-delay)
	timerArcaneBombCD:Start(23-delay)
end

function mod:OnCombatEnd()
	self.vb.phase = 1
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 192706 then
		timerArcaneBombCD:Start(args.destName)
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 192706 then
		timerArcaneBombCD:Cancel(args.destName)
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 192985 then
		self.vb.phase = 2
		if not serpMod then serpMod = DBM:GetModByName(1479) end
		serpMod:UpdateWinds()--At present it may not actually reset here. Just in case though
	elseif spellId == 192617 then
		specWarnMassiveDeluge:Show()
		voiceMassiveDeluge:Play("shockwave")
		if self.vb.phase == 2 then
			timerMassiveDelugeCD:Start(35)
		else
			timerMassiveDelugeCD:Start()
		end
	end
end

--2 seconds faster than combat log
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetname)
	if msg:find("spell:192708") then
		timerArcaneBombCD:Start()
		if targetname == UnitName("player") then
			specWarnArcaneBomb:Show()
			voiceArcaneBomb:Play("runout")
			yellArcaneBomb:Yell()
		else
			warnArcaneBomb:Show(targetname)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local _, _, _, _, spellId = strsplit("-", spellGUID)
	if spellId == 192680 then--Mythic Tornado
		warnMythicTornado:Show()
		timerMythicTornadoCD:Start()
	end
end
