local mod	= DBM:NewMod(1718, "DBM-Party-Legion", 7, 800)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104215)
mod:SetEncounterID(1868)
mod:SetZone()

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 207261 207815 207806",
	"SPELL_CAST_SUCCCESS 207278"
)

local warnFlask						= mod:NewSpellAnnounce(207815, 2)

local specWarnResonantSlash			= mod:NewSpecialWarningDodge(207261, nil, nil, nil, 2, 2)
local specWarnArcaneLockdown		= mod:NewSpecialWarningJump(207278, nil, nil, nil, 2, 6)
local specWarnBeacon				= mod:NewSpecialWarningSwitch(207806, nil, nil, nil, 2, 2)

local timerResonantSlashCD			= mod:NewCDTimer(12.1, 207261, nil, nil, nil, 3)
local timerArcaneLockdownCD			= mod:NewCDTimer(30, 207278, nil, nil, nil, 3)
local timerSignalBeaconCD			= mod:NewCDTimer(20, 207806, nil, nil, nil, 1)

local voiceResonantSlash			= mod:NewVoice(207261)--watchstep
local voiceArcaneLockdown			= mod:NewVoice(207278)--keepjump
local voiceBeacon					= mod:NewVoice(207806)--mobsoon

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerResonantSlashCD:Start(7-delay)
	timerArcaneLockdownCD:Start(15-delay)
	timerSignalBeaconCD:Start(20-delay)--Iffy
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 207261 then
		specWarnResonantSlash:Show()
		voiceResonantSlash:Play("watchstep")
		if self.vb.phase == 2 then
			timerResonantSlashCD:Start(10)
		else
			timerResonantSlashCD:Start()
		end
	elseif spellId == 207815 then
		self.vb.phase = 2
		warnFlask:Show()
	elseif spellId == 207806 then
		specWarnBeacon:Show()
		voiceBeacon:Play("mobsoon")
	end
end

function mod:SPELL_CAST_SUCCCESS(args)
	local spellId = args.spellId
	if spellId == 207278 then--Success since jumping on cast start too early
		specWarnArcaneLockdown:Show()
		voiceArcaneLockdown:Play("keepjump")
		timerArcaneLockdownCD:Start()
	end
end
