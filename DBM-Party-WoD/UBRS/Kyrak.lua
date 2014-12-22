local mod	= DBM:NewMod(1227, "DBM-Party-WoD", 8, 559)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76021)
mod:SetEncounterID(1758)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 161203 162600",
	"SPELL_CAST_START 161199 161203 155037",
	"SPELL_PERIODIC_DAMAGE 161288",
	"SPELL_PERIODIC_MISSED 161288",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnDebilitatingFixation		= mod:NewSpellAnnounce(161199, 4, nil, mod:IsTank())
local warnEruption					= mod:NewSpellAnnounce(155037, 4, nil, mod:IsTank())
local warnRejuvSerumCast			= mod:NewCastAnnounce(161203, 3)
local warnRejuvSerum				= mod:NewTargetAnnounce(161203, 4, nil, mod:IsMagicDispeller())
local warnToxicFumes				= mod:NewTargetAnnounce(162600, 3, nil, mod:IsHealer())
local warnVilebloodSerum			= mod:NewSpellAnnounce(161209, 3)--Some may think this is spammy but the puddles tick literally instantly giving not much time to move before 2nd tick which may kill you.

local specWarnDebilitatingFixation	= mod:NewSpecialWarningInterrupt("OptionVersion2", 161199, not mod:IsHealer(), nil, nil, 3)
local specWarnEruption				= mod:NewSpecialWarningMove(155037, mod:IsTank())
local specWarnRejuvSerum			= mod:NewSpecialWarningDispel(161203, mod:IsMagicDispeller())
local specWarnToxicFumes			= mod:NewSpecialWarningDispel(162600, mod:IsHealer())
local specWarnVilebloodSerum		= mod:NewSpecialWarningMove(161288)

local timerDebilitatingCD			= mod:NewNextTimer(20, 161199)--Every 20 seconds exactly, at least in challenge mode.
local timerEruptionCD				= mod:NewCDTimer(10, 155037, nil, false)--10-15 sec variation. May be distracting or spammy since two of them
--local timerRejuvSerumCD			= mod:NewCDTimer(33, 161203, nil, mod:IsMagicDispeller())--33-40sec variation. Could also be health based so disabled for now.
local timerVilebloodSerumCD			= mod:NewCDTimer(9.5, 161209)--every 9-10 seconds

local countdownDebilitating			= mod:NewCountdown(20, 161199, mod:IsTank())

local voiceRejuvSerum				= mod:NewVoice(161203, mod:IsMagicDispeller())
local voiceToxicFumes				= mod:NewVoice(162600, mod:IsHealer())
local voiceDebilitating				= mod:NewVoice(161199, not mod:IsHealer())
local voiceVilebloodSerum			= mod:NewVoice(161288)

function mod:OnCombatStart(delay)
--	timerRejuvSerumCD:Start(22.5-delay)--Insufficent sample size
	timerDebilitatingCD:Start(12-delay)--Insufficent sample size
	countdownDebilitating:Start(12-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 161203 and not args:IsDestTypePlayer() then
		warnRejuvSerum:Show(args.destName)
		specWarnRejuvSerum:Show(args.destName)
--		timerRejuvSerumCD:Start()
		voiceRejuvSerum:Play("dispelboss")
	elseif spellId == 162600 then
		warnToxicFumes:Show(args.destName)
		specWarnToxicFumes:Show(args.destName)
		voiceToxicFumes:Play("dispelnow")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 161199 then
		warnDebilitatingFixation:Show()
		specWarnDebilitatingFixation:Show(args.sourceName)
		timerDebilitatingCD:Start()
		countdownDebilitating:Start()
		if self:IsTank() then
			voiceDebilitating:Play("kickcast")
		else
			voiceDebilitating:Play("helpkick")
		end
	elseif spellId == 161203 then
		warnRejuvSerumCast:Show()
	elseif spellId == 155037 and self:IsInCombat() then
		warnEruption:Show()
		specWarnEruption:Show()
		timerEruptionCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 161288 and destGUID == UnitGUID("player") then
		if self:AntiSpam(2, 1) then
			specWarnVilebloodSerum:Show()
			voiceVilebloodSerum:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 82556 then
		timerEruptionCD:Cancel(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
--	"<58.9 23:54:07> [UNIT_SPELLCAST_SUCCEEDED] Drakonid Monstrosity [[target:Vileblood Serum::0:161209]]", -- [1996]
	if spellId == 161209 and self:AntiSpam(3, 2) then
		warnVilebloodSerum:Show()
		timerVilebloodSerumCD:Start()
		if self:AntiSpam(2, 1) then
			specWarnVilebloodSerum:Show()--Always dropped on all players when cast, so moving during cast gets 0 ticks.
			voiceVilebloodSerum:Play("runaway")
		end
	end
end
