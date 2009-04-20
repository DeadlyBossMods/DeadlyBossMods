local mod = DBM:NewMod("YoggSaron", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID() --??
mod:SetZone()

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED_DOSE",
	"UNIT_HEALTH"
)


local warnWellSpawned = mod:NewAnnounce("WarningWellSpawned", 1, 64170)
local warnGuardianSpawned = mod:NewAnnounce("WarningGuardianSpawned", 3, 62979)
local warnP2 = mod:NewAnnounce("WarningP2", 2)
local warnSanity = mod:NewAnnounce("WarningSanity", 3)
local specWarnGuardianLow = mod:NewSpecialWarning("SpecWarnGuardianLow", false)
local warnBrainLink = mod:NewAnnounce("WarningBrainLink", 2)
local specWarnBrainLink = mod:NewSpecialWarning("SpecWarnBrainLink")
local specWarnSanity = mod:NewSpecialWarning("SpecWarnSanity")

mod:AddBoolOption("ShowSaraHealth")
mod:AddBoolOption("WhisperBrainLink", false)

local targetWarningsShown = {}
function mod:OnCombatStart(delay)
	if self.Options.ShowSaraHealth and not self.Options.HealthFrame then
		DBM.BossHealth:Show(L.name)
	end
	if self.Options.ShowSaraHealth then
		DBM.BossHealth:AddBoss(33134, L.Sara)
	end
	table.wipe(targetWarningsShown)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 64170 then
		warnWellSpawned:Show()
	end
end


function mod:CHAT_MSG_MONSTER_YELL(msg, sender)
	if msg == L.YellPhase2 then
		self:SendSync("Phase2")
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 62979 then
		warnGuardianSpawned:Show()
	end
end

local brainLink1
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 63802 then
		if not brainLink1 then
			self:SetIcon(args.destName, 8, 30)
			brainLink1 = args.destName
		else
			self:SetIcon(args.destName, 7, 30)
			warnBrainLink:Show(brainLink1, args.destName)
			self:AnnounceBrainLink(brainLink1, args.destName)
			self:AnnounceBrainLink(args.destName, brainLink1)
		end
	end
end

function mod:AnnounceBrainLink(player, other)
	if player == UnitName("player") then
		specWarnBrainLink:Show(other)
	end
	if DBM:GetRaidRank() >= 1 and self.Options.WhisperBrainLink then
		self:SendWhisper(L.WhisperBrainLink:format(other), player)
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	if args.spellId == 63050 then
		if args.amount == 50 then
			warnSanity:Show(args.amount)
		elseif args.amount == 25 or args.amount == 15 or args.amount == 5 then
			warnSanity:Show(args.amount)
			specWarnSanity:Show(args.amount)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if uId == "target" and self:GetUnitCreatureId(uId) == 33136 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.3 and not targetWarningsShown[UnitGUID(uId)] then
		targetWarningsShown[UnitGUID(uId)] = true
		specWarnGuardianLow:Show()
	end
end

function mod:OnSync(event, args)
	if event == "Phase2" then
		warnP2:Show()
		if self.Options.ShowSaraHealth and self:GetCIDFromGUID(args.destGUID) == 33134 then
			DBM.BossHealth:RemoveBoss(33134)
			if not self.Options.HealthFrame then
				DBM.BossHealth:Hide()
			end
		end
	end
end
