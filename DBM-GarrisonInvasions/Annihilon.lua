local mod	= DBM:NewMod("Annihilon", "DBM-GarrisonInvasions")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90802)
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 180950",
	"SPELL_AURA_REMOVED 180950",
	"UNIT_SPELLCAST_START"
)

local warnVoidBomb				= mod:NewTargetAnnounce(180939, 3)
local warnWhirlingVoid			= mod:NewTargetAnnounce(180932, 2)
local warnTwistMind				= mod:NewTargetAnnounce(180950, 4)

local specWarnVoidBomb			= mod:NewSpecialWarningYou(180939, nil, nil, nil, 1, 2)
local yellVoidBomb				= mod:NewYell(180939)
local specWarnTwistMind			= mod:NewSpecialWarningSwitch(180950, "Dps", nil, nil, 1, 2)

local voiceVoidBomb				= mod:NewVoice(180939)--runout
local voiceMC					= mod:NewVoice(163472, "Dps")--findmc

mod:AddHudMapOption("HudMapOnMC", 180950)

function mod:VoidTarget(targetname, uId)
	if not targetname then return end
	warnWhirlingVoid:Show(targetname)
end

function mod:BombTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnVoidBomb:Show()
		yellVoidBomb:Yell()
		voiceVoidBomb:Play("runout")
	else
		warnVoidBomb:Show(targetname)
	end
end

function mod:OnCombatEnd()
	if self.Options.HudMapOnMC then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 180950 then
		warnTwistMind:CombinedShow(0.5, args.destName)--Only saw 1 target in 12 person raid, but maybe scales up in larger raid size? so combined show just in case
		if self:AntiSpam(2, 1) then
			specWarnTwistMind:Show()
			voiceMC:Play("findmc")
		end
		if self.Options.HudMapOnMC then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 30, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 180950 then
		if self.Options.HudMapOnMC then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	end
end


function mod:UNIT_SPELLCAST_START(uId, _, _, _, spellId)
	if spellId == 180939 and self:AntiSpam(3, 1) then
		self:SendSync("VoidBomb", UnitGUID(uId))
	elseif spellId == 180932 and self:AntiSpam(3, 2) then
		self:SendSync("WhirlingVoid", UnitGUID(uId))
	end
end

function mod:OnSync(msg, GUID)
	if GUID and msg == "VoidBomb" then
		self:ScheduleMethod(0.2, "BossTargetScanner", GUID, "BombTarget", 0.05, 16)
	elseif GUID and msg == "WhirlingVoid" then
		self:ScheduleMethod(0.2, "BossTargetScanner", GUID, "VoidTarget", 0.04, 16)
	end
end
