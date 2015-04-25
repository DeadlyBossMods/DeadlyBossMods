local mod	= DBM:NewMod("Annihilon", "DBM-GarrisonInvasions")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90802)
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180939 180932",
	"SPELL_AURA_APPLIED 180950",
	"SPELL_AURA_REMOVED 180950"
)

local warnVoidBomb				= mod:NewTargetAnnounce(180939, 3)
local warnWhirlingVoid			= mod:NewTargetAnnounce(180932, 2)
local warnTwistMind				= mod:NewTargetAnnounce(180950, 4)

local specWarnVoidBomb			= mod:NewSpecialWarningYou(180939)
local yellVoidBomb				= mod:NewYell(180939)
local specWarnTwistMind			= mod:NewSpecialWarningSwitch(180950, "Dps")

local timerWhirlingVoidCD		= mod:NewCDTimer(14, 180932)
local timerTwistMindCD			= mod:NewCDTimer(28, 180950)

mod:AddHudMapOption("HudMapOnMC", 180950)

mod.vb.MCCount = 0

function mod:VoidTarget(targetname, uId)
	if not targetname then return end
	warnWhirlingVoid:Show(targetname)
end

function mod:BombTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnVoidBomb:Show()
		yellVoidBomb:Yell()
	else
		warnVoidBomb:Show(targetname)
	end
end

function mod:OnCombatStart(delay, summonTriggered)
	self.vb.MCCount = 0
	if summonTriggered then
		timerWhirlingVoidCD:Start(7.5)--Only one pull, small sample
		timerTwistMindCD:Start(34)--Only one pull, small sample	
	end
end

function mod:OnCombatEnd()
	if self.Options.HudMapOnMC then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180939 then
		self:BossTargetScanner(90802, "BombTarget", 0.05, 25)
	elseif spellId == 180932 then
		self:BossTargetScanner(90802, "VoidTarget", 0.05, 25)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 180950 then
		self.vb.MCCount = self.vb.MCCount + 1
		warnTwistMind:CombinedShow(0.5, args.destName)--Only saw 1 target in 12 person raid, but maybe scales up in larger raid size? so combined show just in case
		if self:AntiSpam(2, 1) then
			specWarnTwistMind:Show()
			timerTwistMindCD:Start()
		end
		if self.Options.HudMapOnMC then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 30, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 180950 then
		self.vb.MCCount = self.vb.MCCount - 1
		if self.Options.HudMapOnMC then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		if self.vb.MCCount == 0 then
			specWarnTwistMind:Show()
			timerTwistMindCD:Start()
		end
	end
end
