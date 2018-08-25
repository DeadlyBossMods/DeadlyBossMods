local mod	= DBM:NewMod("KingsRestTrash", "DBM-Party-BfA", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 270003 269973 270923 270889 270901 270084 270872 270293 270284 270492 270482 270514",
	"SPELL_AURA_APPLIED 269976 270927 270920 270865 271640",
	"SPELL_AURA_REMOVED 271640",
	"SPELL_CAST_SUCCESS 270500 270497",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--TODO, target scan Deadeye Shot?
--TODO, target scan Poison Barrage?
local warnAxeBarrage				= mod:NewCastAnnounce(270084, 4)
local warnAxeShadowWhirl			= mod:NewCastAnnounce(270872, 3)
local warnBloodedLeap				= mod:NewCastAnnounce(270482, 3)
local warnEntomb					= mod:NewTargetNoFilterAnnounce(267702, 3)
local warnPoolofDarkness			= mod:NewSpellAnnounce(272014, 3)

local specWarnSupressionSlam		= mod:NewSpecialWarningDodge(270003, "Tank", nil, nil, 1, 2)
local specWarnPurificationStrike	= mod:NewSpecialWarningDodge(270293, "Melee", nil, nil, 1, 2)
local specWarnPurificationBeam		= mod:NewSpecialWarningDodge(270284, nil, nil, nil, 2, 8)
local specWarnGroundCrush			= mod:NewSpecialWarningDodge(270514, nil, nil, nil, 2, 2)
local specWarnDeathlyChill			= mod:NewSpecialWarningInterrupt(269973, "HasInterrupt", nil, nil, 1, 2)
local specWarnShadowBolt			= mod:NewSpecialWarningInterrupt(270923, "HasInterrupt", nil, nil, 1, 2)
local specWarnInduceRegeneration	= mod:NewSpecialWarningInterrupt(270901, "HasInterrupt", nil, nil, 1, 2)
local specWarnHex					= mod:NewSpecialWarningInterrupt(270492, "HasInterrupt", nil, nil, 1, 2)
local specWarnBladestorm			= mod:NewSpecialWarningRun(270927, nil, nil, nil, 4, 2)
local specWarnChannelLighting		= mod:NewSpecialWarningRun(270889, nil, nil, nil, 4, 2)
local specWarnSeduction				= mod:NewSpecialWarningDispel(270920, "Healer", nil, nil, 1, 2)
local specWarnAncestralFury			= mod:NewSpecialWarningDispel(269976, "RemoveEnrage", nil, nil, 1, 2)
local specWarnHiddenBladeDispel		= mod:NewSpecialWarningDispel(270865, "RemovePoison", nil, nil, 1, 2)
local specWarnHuntingLeap			= mod:NewSpecialWarningYou(270500, nil, nil, nil, 1, 2)
local yellHuntingLeap				= mod:NewYell(270500)
local specWarnEntomb				= mod:NewSpecialWarningYou(267702, nil, nil, nil, 1, 2)
local yellEntomb					= mod:NewYell(267702)
local specWarnDarkRevelation		= mod:NewSpecialWarningMoveAway(271640, nil, nil, nil, 1, 2)
local yellDarkRevelation			= mod:NewYell(271640)
local yellDarkRevelationFades		= mod:NewShortFadesYell(271640)
local specWarnHiddenBlade			= mod:NewSpecialWarningMoveAway(270865, nil, nil, nil, 1, 2)
local specWarnHealingTideTotem		= mod:NewSpecialWarningSwitch(270497, "-Healer", nil, nil, 1, 2)

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
	elseif spellId == 270889 then
		specWarnChannelLighting:Show()
		specWarnChannelLighting:Play("justrun")
	elseif spellId == 270084 and self:AntiSpam(4, 2) then
		warnAxeBarrage:Show()
	elseif spellId == 270872 and self:AntiSpam(4, 3) then
		warnAxeShadowWhirl:Show()
	elseif spellId == 270482 and self:AntiSpam(4, 4) then
		warnBloodedLeap:Show()
	elseif spellId == 270293 then
		specWarnPurificationStrike:Show()
		specWarnPurificationStrike:Play("watchstep")
	elseif spellId == 270284 then
		specWarnPurificationBeam:Show()
		specWarnPurificationBeam:Play("getbehind")
	elseif spellId == 270514 then
		specWarnGroundCrush:Show()
		specWarnGroundCrush:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 269976 then
		specWarnAncestralFury:Show(args.destName)
		specWarnAncestralFury:Show("helpdispel")
	elseif spellId == 270927 then
		specWarnBladestorm:Show()
		specWarnBladestorm:Play("justrun")
	elseif spellId == 270920 then
		specWarnSeduction:Show(args.destName)
		specWarnSeduction:Show("helpdispel")
	elseif spellId == 270865 then
		if args:IsPlayer() then
			specWarnHiddenBlade:Show()
			specWarnHiddenBlade:Show("runout")
		else
			specWarnHiddenBladeDispel:Show(args.destName)
			specWarnHiddenBladeDispel:Play("helpdispel")
		end
	elseif spellId == 271640 and args:IsPlayer() then
		specWarnDarkRevelation:Show()
		specWarnDarkRevelation:Play("runout")
		yellDarkRevelation:Yell()
		yellDarkRevelationFades:Countdown(10)
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
