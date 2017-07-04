local mod	= DBM:NewMod(1653, "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(98696)
mod:SetEncounterID(1833)
mod:SetZone()
mod:SetUsedIcons(3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 197478",
	"SPELL_AURA_REMOVED 197478",
	"SPELL_CAST_START 197418 197546 197974",
	"SPELL_CAST_SUCCESS 197478 197687",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
"<3.42 23:50:12> [ENCOUNTER_START] ENCOUNTER_START#1833#Ilysanna Ravencrest#23#5", -- [7]
"<50.59 23:50:59> [UNIT_SPELLCAST_SUCCEEDED] Illysanna Ravencrest(??) boss1:Phase 2 Jump::3-3020-1501-31352-197622-00004A48A3:197622",
"<119.67 23:52:08> [UNIT_SPELLCAST_SUCCEEDED] Illysanna Ravencrest(??) boss1:Periodic Energize::3-3020-1501-31352-197394-0000CA48E8:197394",
"<213.28 23:53:41> [UNIT_SPELLCAST_SUCCEEDED] Illysanna Ravencrest(??) boss1:Phase 2 Jump::3-3020-1501-31352-197622-0003CA4945:197622",
--]]
--TODO, maybe GTFO for standing in fire left by dark rush and eye beams?
--TODO, Interrupt warning for heroic/mythic/challenge mode arcane spell?
local warnBrutalGlaive				= mod:NewTargetAnnounce(197546, 2)
local warnDarkRush					= mod:NewTargetAnnounce(197478, 3)
local warnEyeBeam					= mod:NewTargetAnnounce(197687, 2)

local specWarnBrutalGlaive			= mod:NewSpecialWarningMoveAway(197546, nil, nil, nil, 1, 2)
local yellBrutalGlaive				= mod:NewYell(197546)
local specWarnVengefulShear			= mod:NewSpecialWarningDefensive(197418, "Tank", nil, nil, 3, 2)
local specWarnDarkRush				= mod:NewSpecialWarningYou(197478, nil, nil, nil, 1, 2)
local specWarnEyeBeam				= mod:NewSpecialWarningRun(197687, nil, nil, nil, 4, 2)
local yellEyeBeam					= mod:NewYell(197687)
local specWarnBonebreakingStrike	= mod:NewSpecialWarningDodge(197974, "Tank", nil, nil, 1, 2)

local timerBrutalGlaiveCD			= mod:NewCDTimer(15, 197546, nil, nil, nil, 3)
local timerVengefulShearCD			= mod:NewCDTimer(11, 197418, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--11-16, delayed by dark rush
local timerDarkRushCD				= mod:NewCDTimer(30, 197478, nil, nil, nil, 3)
local timerEyeBeamCD				= mod:NewNextTimer(15.5, 197687, nil, nil, nil, 3)

local voiceBrutalGlaive				= mod:NewVoice(197546)--runout
local voiceVengefulShear			= mod:NewVoice(197418, "Tank")--defensive
local voiceDarkRush					= mod:NewVoice(197478)--targetyou (changed from gather, because that may not be everyones strat)
local voiceEyeBeam					= mod:NewVoice(197687)--laserrun
local voiceBonebreakingStrike		= mod:NewVoice(197974, "Tank")--shockwave

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
	timerVengefulShearCD:Start(8-delay)
	timerDarkRushCD:Start(12.1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 197478 then
		timerDarkRushCD:Start()
	elseif spellId == 197687 then--No longer fires applied event, so success has to be used, even if it misses or gets dropped off target by some kind of feign
		timerEyeBeamCD:Start()
		if args:IsPlayer() then
			specWarnEyeBeam:Show()
			yellEyeBeam:Yell()
			voiceEyeBeam:Play("laserrun")
		else
			warnEyeBeam:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 197478 then
		warnDarkRush:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDarkRush:Show()
			voiceDarkRush:Play("targetyou")
		end
		if self.Options.SetIconOnDarkRush then
			self:SetAlphaIcon(0.5, args.destName, 3)
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
		specWarnVengefulShear:Show()
		voiceVengefulShear:Play("defensive")
		timerVengefulShearCD:Start()
	elseif spellId == 197546 then
		timerBrutalGlaiveCD:Start()
		self:BossTargetScanner(98696, "BrutalGlaiveTarget", 0.1, 10, true)
	elseif spellId == 197974 then
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
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 197622 then--Phase 2 Jump
		timerBrutalGlaiveCD:Stop()
		timerVengefulShearCD:Stop()
		timerDarkRushCD:Stop()
		timerEyeBeamCD:Start(4)
	elseif spellId == 197394 then--Periodic Energize
		timerEyeBeamCD:Stop()
		timerBrutalGlaiveCD:Start(6)
		timerDarkRushCD:Start(12)
		timerVengefulShearCD:Start(13)
	end
end
