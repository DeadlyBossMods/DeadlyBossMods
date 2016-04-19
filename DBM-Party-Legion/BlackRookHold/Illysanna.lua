local mod	= DBM:NewMod(1653, "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(98696)
mod:SetEncounterID(1833)
mod:SetZone()
mod:SetUsedIcons(3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 197478 197687",
	"SPELL_AURA_REMOVED 197478",
	"SPELL_CAST_START 197418 197546 200261",
	"SPELL_CAST_SUCCESS 197478",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, maybe GTFO for standing in fire left by dark rush and eye beams?
--TODO, Interrupt warning for heroic/mythic/challenge mode arcane spell?
local warnBrutalGlaive				= mod:NewTargetAnnounce(197546, 2)
local warnDarkRush					= mod:NewTargetAnnounce(197478, 3)
local warnEyeBeam					= mod:NewTargetAnnounce(197687, 2)

local specWarnBrutalGlaive			= mod:NewSpecialWarningMoveAway(197546, nil, nil, nil, 1, 2)
local yellBrutalGlaive				= mod:NewYell(197546)
local specWarnVengefulGlaive		= mod:NewSpecialWarningDefensive(197418, "Tank", nil, nil, 3, 2)
local specWarnDarkRush				= mod:NewSpecialWarningYou(197478, nil, nil, nil, 1, 2)
local specWarnEyeBeam				= mod:NewSpecialWarningRun(197687, nil, nil, nil, 4, 2)
local yellEyeBeam					= mod:NewYell(197687)
local specWarnBonebreakingStrike	= mod:NewSpecialWarningDodge(200261, "Tank", nil, nil, 1, 2)

local timerBrutalGlaiveCD			= mod:NewCDTimer(15, 197546, nil, nil, nil, 3)
local timerVengefulGlaiveCD			= mod:NewCDTimer(11, 197418, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--11-16, delayed by dark rush
local timerDarkRushCD				= mod:NewCDTimer(30, 197478, nil, nil, nil, 3)

local voiceBrutalGlaive				= mod:NewVoice(197546)--runout
local voiceVengefulGlaive			= mod:NewVoice(197418, "Tank")--defensive
local voiceDarkRush					= mod:NewVoice(197478)--gathershare
local voiceEyeBeam					= mod:NewVoice(197687)--laserrun
local voiceBonebreakingStrike		= mod:NewVoice(200261, "Tank")--shockwave

mod:AddSetIconOption("SetIconOnDarkRush", 197478, true)
--mod:AddRangeFrameOption(5, 197546)--Range not given for Brutal Glaive

function mod:BrutalGlaiveTarget(targetname, uId)
	if not targetname then
		warnBrutalGlaive:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		specWarnBrutalGlaive:Show()
		voiceBrutalGlaive:Play("runout")
		yellBrutalGlaive:Yell()
	else
		warnBrutalGlaive:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerBrutalGlaiveCD:Start(5.5-delay)
	timerVengefulGlaiveCD:Start(8-delay)
	timerDarkRushCD:Start(13-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 197478 then
		timerDarkRushCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 197478 then
		warnDarkRush:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDarkRush:Show()
			voiceDarkRush:Play("gathershare")
		end
		if self.Options.SetIconOnDarkRush then
			self:SetAlphaIcon(0.5, args.destName, 1, 3)
		end
	elseif spellId == 197687 then
		if args:IsPlayer() then
			specWarnEyeBeam:Show()
			yellEyeBeam:Yell()
			voiceEyeBeam:Play("laserrun")
		else
			warnEyeBeam:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 197478 and self.Options.SetIconOnDarkRush then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 197418 then
		specWarnVengefulGlaive:Show()
		voiceVengefulGlaive:Play("defensive")
		timerVengefulGlaiveCD:Start()
	elseif spellId == 197546 then
		timerBrutalGlaiveCD:Start()
		self:BossTargetScanner(98696, "BrutalGlaiveTarget", 0.1, 20, true)
	elseif spellId == 200261 then
		specWarnBonebreakingStrike:Show()
		voiceBonebreakingStrike:Play("shockwave")
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 153616 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then

	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local _, _, _, _, spellId = strsplit("-", spellGUID)
	if spellId == 197622 then--Phase 2 Jump
		timerBrutalGlaiveCD:Cancel()
		timerVengefulGlaiveCD:Cancel()
		timerDarkRushCD:Cancel()
	elseif spellId == 197394 then--Periodic Energize
		timerBrutalGlaiveCD:Start(6)
		timerDarkRushCD:Start(12)
		timerVengefulGlaiveCD:Start(13)--Sample size
	end
end
