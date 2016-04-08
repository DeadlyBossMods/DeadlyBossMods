local mod	= DBM:NewMod(1744, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(106087)
mod:SetEncounterID(1876)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 212707 210948 210864 215443 210547 215288",
	"SPELL_CAST_SUCCESS 212364",
	"SPELL_AURA_APPLIED 212514 218831 215449",
	"SPELL_AURA_APPLIED_DOSE 212512",
--	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE 213124",
	"SPELL_PERIODIC_MISSED 213124",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: Because forms could not be datamined, this mod will be near useless.
--TODO: Does web of pain actually need to annouce target.
--TODO: Does raking talons need anything?
--TODO: eye of storm info frame?
--TODO: See if target scanning faster for necrotic Venom
--TODO, Target scan razor wing and add HUD to it. If it's not tank only
--Spider Form
--local warnSpiderForm				= mod:NewTargetAnnounce("ej13259", 2, 200666)
local warnFeedingTime				= mod:NewSpellAnnounce(212364, 3)
local warnWebWrap					= mod:NewTargetAnnounce(212514, 4)
local warnNecroticVenom				= mod:NewTargetAnnounce(218831, 3)
--Roc Form
--local warnRocForm					= mod:NewTargetAnnounce("ej13263", 2, 196768)
local warnTwistedShadows			= mod:NewTargetAnnounce(210864, 3)

--Spider Form
local specWarnVenomousPool			= mod:NewSpecialWarningMove(213124, nil, nil, nil, 1, 2)
local specWarnWebWrap				= mod:NewSpecialWarningStack(212512, nil, 5)
local specWarnNecroticVenom			= mod:NewSpecialWarningYou(218831)
local specWarnWebOfPain				= mod:NewSpecialWarningDefensive(215288, nil, nil, nil, 1, 2)
local specWarnWebOfPainOther		= mod:NewSpecialWarningTaunt(215288, nil, nil, nil, 1, 2)
--Roc Form
local specWarnGatheringClouds		= mod:NewSpecialWarningSpell(212707, nil, nil, nil, 1, 2)
local specWarnDarkStorm				= mod:NewSpecialWarningMoveTo(210948, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(210948), nil, 1, 2)
local specWarnTwistedShadows		= mod:NewSpecialWarningMove(210864)
local yellTwistedShadows			= mod:NewYell(210864)
local specWarnRazorWing				= mod:NewSpecialWarningDodge(210547, nil, nil, nil, 3, 2)

--Spider Form
--local timerSpiderFormCD			= mod:NewCDTimer(16, "ej13259", nil, nil, nil, 6, 200666)
local timerFeedingTimeCD			= mod:NewAITimer(16, 212364, nil, nil, nil, 1)
local timerNecroticVenomCD			= mod:NewAITimer(16, 215443, nil, nil, nil, 3)
--local timerSkitteringSpiderlingCD	= mod:NewAITimer(16, 215505, nil, nil, nil, 1, 79591)--TODO, find EJ entry for useful destriction and shorter text
--Roc Form
--local timerRocFormCD				= mod:NewCDTimer(16, "ej13263", nil, nil, nil, 6, 196768)
local timerGatheringCloudsCD		= mod:NewAITimer(16, 212707, nil, nil, nil, 2)
local timerDarkStormCD				= mod:NewAITimer(16, 210948, nil, nil, nil, 2)
local timerTwistedShadowsCD			= mod:NewAITimer(16, 210864, nil, nil, nil, 3)
local timerRazorWingCD				= mod:NewAITimer(16, 210547, nil, nil, nil, 3)

--Spider Form
--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)
--Roc Form

--Spider Form
local voiceVenomousPool				= mod:NewVoice(213124)--runaway
local voiceWebOfPain				= mod:NewVoice(215288)--defensive/tauntboss
--Roc Form
local voiceGatheringClouds			= mod:NewVoice(212707)--aesoon
local voiceDarkStorm				= mod:NewVoice(212707)--findshelter
local voiceRazorWing				= mod:NewVoice(210547)--carefly

--mod:AddRangeFrameOption("5")
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
--mod:AddHudMapOption("HudMapOnMC", 163472)

local eyeOfStorm = GetSpellInfo(211127)

function mod:TwistingShadowsTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnTwistedShadows:Show()
		yellTwistedShadows:Yell()
	else
		warnTwistedShadows:Show(targetname)
	end
end

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.FelArrow then
--		DBM.Arrow:Hide()
--	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 212707 then
		specWarnGatheringClouds:Show()
		voiceGatheringClouds:Play("aesoon")
		timerGatheringCloudsCD:Start()
	elseif spellId == 210948 then
		specWarnDarkStorm:Show(eyeOfStorm)
		voiceDarkStorm:Play("findshelter")
		timerDarkStormCD:Start()
	elseif spellId == 210864 then
		timerTwistedShadowsCD:Start()
		self:BossTargetScanner(args.sourceGUID, "TwistingShadowsTarget", 0.1, 12, true, nil, nil, nil, true)
	elseif spellId == 215443 then
		timerNecroticVenomCD:Start()
	elseif spellId == 210547 then
		specWarnRazorWing:Show()
		voiceRazorWing:Play("carefly")
		timerRazorWingCD:Start()
	elseif spellId == 215288 then
		local targetName, uId, bossuid = self:GetBossTarget(106087, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnWebOfPain:Show()
			voiceWebOfPain:Play("defensive")
		else
			specWarnWebOfPainOther:Schedule(1.4, targetName)
			voiceWebOfPain:Schedule(1.4, "tauntboss")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 212364 then--Probably hidden and need unit event
		warnFeedingTime:Show()
		timerFeedingTimeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 212514 then
		warnWebWrap:Show(args.destName)
	elseif spellId == 218831 or spellId == 215449 then
		warnNecroticVenom:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnNecroticVenom:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 212512 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 5 then
			specWarnWebWrap:Show(amount)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 162186 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 213124 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnVenomousPool:Show()
		voiceVenomousPool:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 200666 then--Spider Form
		DBM:Debug("Spider Form Detected")
	elseif spellId == 218073 then--Venomous Spiderling Summoned Spider Spawn

	elseif spellId == 215505 then--Summon Skittering Spiderling
		--Likely primary scrip tand best one to use for announce
		--timerSkitteringSpiderlingCD:Start()
	elseif spellId == 215507 then--Summon Skittering Spiderling
		--Spawns actual mob
	elseif spellId == 215508 then--Summon Skittering Spiderling
		--Trigger missle triggered by 215505
	end
end

--[[
function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
