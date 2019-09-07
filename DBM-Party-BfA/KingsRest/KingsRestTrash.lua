local mod	= DBM:NewMod("KingsRestTrash", "DBM-Party-BfA", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 270003 269973 270923 270889 270901 270084 270872 270293 270284 270492 270482 270514 270507",
	"SPELL_AURA_APPLIED 269976 270927 270920 270865 271640 271561 269936",
	"SPELL_AURA_REMOVED 271640",
	"SPELL_CAST_SUCCESS 270500 270497 270930",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--TODO, target scan Deadeye Shot?
--TODO, target scan Poison Barrage?
local warnAxeBarrage				= mod:NewCastAnnounce(270084, 4)
local warnAxeShadowWhirl			= mod:NewCastAnnounce(270872, 3)
local warnBloodedLeap				= mod:NewCastAnnounce(270482, 3)
local warnEntomb					= mod:NewTargetNoFilterAnnounce(267702, 3)
local warnPoisonBarrage				= mod:NewTargetAnnounce(270507, 4)
local warnPoolofDarkness			= mod:NewSpellAnnounce(272014, 3)

local specWarnWailofMourning		= mod:NewSpecialWarningSpell(271561, "Healer", nil, nil, 2, 2)
local specWarnSupressionSlam		= mod:NewSpecialWarningDodge(270003, nil, nil, 2, 2, 2)
local specWarnPurificationStrike	= mod:NewSpecialWarningDodge(270293, "Melee", nil, nil, 1, 2)
local specWarnPurificationBeam		= mod:NewSpecialWarningDodge(270284, nil, nil, nil, 2, 8)
local specWarnGroundCrush			= mod:NewSpecialWarningDodge(270514, nil, nil, nil, 2, 2)
local specWarnDarkShot				= mod:NewSpecialWarningDodge(270930, nil, nil, nil, 2, 2)
local specWarnDeathlyChill			= mod:NewSpecialWarningInterrupt(269973, "HasInterrupt", nil, nil, 1, 2)
local specWarnShadowBolt			= mod:NewSpecialWarningInterrupt(270923, "HasInterrupt", nil, nil, 1, 2)
local specWarnInduceRegeneration	= mod:NewSpecialWarningInterrupt(270901, "HasInterrupt", nil, nil, 1, 2)
local specWarnHex					= mod:NewSpecialWarningInterrupt(270492, "HasInterrupt", nil, nil, 1, 2)
local specWarnBladestorm			= mod:NewSpecialWarningRun(270927, nil, nil, nil, 4, 2)
local specWarnChannelLighting		= mod:NewSpecialWarningRun(270889, nil, nil, nil, 4, 2)
local specWarnSeduction				= mod:NewSpecialWarningDispel(270920, "Healer", nil, nil, 1, 2)
local specWarnAncestralFury			= mod:NewSpecialWarningDispel(269976, "RemoveEnrage", nil, 2, 1, 2)
local specWarnHiddenBladeDispel		= mod:NewSpecialWarningDispel(270865, "RemovePoison", nil, nil, 1, 2)
local specWarnHuntingLeap			= mod:NewSpecialWarningYou(270500, nil, nil, nil, 1, 2)
local yellHuntingLeap				= mod:NewYell(270500)
local specWarnEntomb				= mod:NewSpecialWarningYou(267702, nil, nil, nil, 1, 2)
local yellEntomb					= mod:NewYell(267702)
local specWarnDarkRevelation		= mod:NewSpecialWarningMoveAway(271640, nil, nil, nil, 1, 2)
local yellDarkRevelation			= mod:NewYell(271640)
local yellDarkRevelationFades		= mod:NewShortFadesYell(271640)
local specWarnPoisonBarrage			= mod:NewSpecialWarningMoveAway(270507, nil, nil, nil, 1, 2)
local yellPoisonBarrage				= mod:NewYell(270507)
local yellPoisonBarrageFades		= mod:NewShortFadesYell(270507)
local specWarnFixate				= mod:NewSpecialWarningRun(269936, nil, nil, nil, 4, 2)
local yellFixate					= mod:NewYell(269936, nil, false)
local specWarnHiddenBlade			= mod:NewSpecialWarningMoveAway(270865, nil, nil, nil, 1, 2)
local specWarnHealingTideTotem		= mod:NewSpecialWarningSwitch(143474, "-Healer", nil, nil, 1, 2)

function mod:BarrageTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") and self:AntiSpam(4, 8) then
		specWarnPoisonBarrage:Show()
		specWarnPoisonBarrage:Play("runout")
		yellPoisonBarrage:Yell()
		yellPoisonBarrageFades:Countdown(4)
	else
		warnPoisonBarrage:Show(targetname)
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 270003 and self:AntiSpam(3, 1) then
		specWarnSupressionSlam:Show()
		specWarnSupressionSlam:Play("shockwave")
	elseif spellId == 269973 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDeathlyChill:Show(args.sourceName)
		specWarnDeathlyChill:Play("kickcast")
	elseif spellId == 270923 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnShadowBolt:Show(args.sourceName)
		specWarnShadowBolt:Play("kickcast")
	elseif spellId == 270901 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnInduceRegeneration:Show(args.sourceName)
		specWarnInduceRegeneration:Play("kickcast")
	elseif spellId == 270492 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHex:Show(args.sourceName)
		specWarnHex:Play("kickcast")
	elseif spellId == 270889  and self:AntiSpam(3, 6) then
		specWarnChannelLighting:Show()
		specWarnChannelLighting:Play("justrun")
	elseif spellId == 270084 and self:AntiSpam(4, 2) then
		warnAxeBarrage:Show()
	elseif spellId == 270872 and self:AntiSpam(4, 3) then
		warnAxeShadowWhirl:Show()
	elseif spellId == 270482 and self:AntiSpam(4, 4) then
		warnBloodedLeap:Show()
	elseif spellId == 270293 and self:AntiSpam(3, 5) then
		specWarnPurificationStrike:Show()
		specWarnPurificationStrike:Play("watchstep")
	elseif spellId == 270930 and self:AntiSpam(3, 5) then
		specWarnDarkShot:Show()
		specWarnDarkShot:Play("watchstep")
	elseif spellId == 270284 then
		specWarnPurificationBeam:Show()
		specWarnPurificationBeam:Play("behindmob")
	elseif spellId == 270514 and self:AntiSpam(3, 5) then
		specWarnGroundCrush:Show()
		specWarnGroundCrush:Play("watchstep")
	elseif spellId == 271561 and self:AntiSpam(4, 7) then
		specWarnWailofMourning:Show()
		specWarnWailofMourning:Play("aesoon")
	elseif spellId == 270507 then
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "BarrageTarget", 0.1, 8)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 269976 then
		specWarnAncestralFury:Show(args.destName)
		specWarnAncestralFury:Play("helpdispel")
	elseif spellId == 270927 and self:AntiSpam(3, 6) then
		specWarnBladestorm:Show()
		specWarnBladestorm:Play("justrun")
	elseif spellId == 270920 and self:CheckDispelFilter() then
		specWarnSeduction:Show(args.destName)
		specWarnSeduction:Play("helpdispel")
	elseif spellId == 270865 and args:IsDestTypePlayer() and self:AntiSpam(3, args.destName) then
		if args:IsPlayer() then
			specWarnHiddenBlade:Show()
			specWarnHiddenBlade:Play("runout")
		elseif self:CheckDispelFilter() then
			specWarnHiddenBladeDispel:Show(args.destName)
			specWarnHiddenBladeDispel:Play("helpdispel")
		end
	elseif spellId == 271640 and args:IsPlayer() then
		specWarnDarkRevelation:Show()
		specWarnDarkRevelation:Play("runout")
		yellDarkRevelation:Yell()
		yellDarkRevelationFades:Countdown(10)
	elseif spellId == 269936 and args:IsPlayer() and self:AntiSpam(3, 9) then
		specWarnFixate:Show()
		specWarnFixate:Play("justrun")
		yellFixate:Yell()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 271640 and args:IsPlayer() then
		yellDarkRevelationFades:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 270500 and args:IsPlayer() then
		specWarnHuntingLeap:Show()
		specWarnHuntingLeap:Play("runaway")
		yellHuntingLeap:Yell()
	elseif spellId == 270497 then
		specWarnHealingTideTotem:Show()
		specWarnHealingTideTotem:Play("attacktotem")
	end
end

--Same time as SPELL_CAST_START but has target information
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetname)
	if msg:find("spell:267702") then
		if targetname and self:AntiSpam(5, targetname) then
			if targetname == UnitName("player") then
				specWarnEntomb:Show()
				specWarnEntomb:Play("targetyou")
				yellEntomb:Yell()
			else
				warnEntomb:Show(targetname)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 272014 then
		self:SendSync("Pool")
	end
end

function mod:OnSync(msg)
	if msg == "Pool" and self:AntiSpam(4, 5) then
		warnPoolofDarkness:Show()
	end
end
