local mod	= DBM:NewMod(1228, "DBM-Party-WoD", 8, 559)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79912, 80098)--80098 is mount(Ironbarb Skyreaver), 79912 is boss
mod:SetEncounterID(1759)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 162090",
	"SPELL_AURA_APPLIED 161833",
	"SPELL_PERIODIC_DAMAGE 161989",
	"SPELL_PERIODIC_MISSED 161989",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--Chi blast warns very spammy. and not useful.
local warnIronReaver		= mod:NewSpellAnnounce(161989, 3)
local warnImbuedIronAxe		= mod:NewTargetAnnounce(162090, 4)

local specWarnImbuedIronAxe	= mod:NewSpecialWarningYou(162090)
local yellImbuedIronAxe		= mod:NewYell(162090)
local specWarnNoxiousSpit	= mod:NewSpecialWarningMove(161833)

local timerIronReaverCD		= mod:NewCDTimer(20.5, 161989)--Not enough data to really verify this
local timerImbuedIronAxeCD	= mod:NewCDTimer(29, 162090)--29-37sec variation

function mod:OnCombatStart(delay)
--	timerIronReaverCD:Start(-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 162090 then
		warnImbuedIronAxe:Show(args.destName)
		timerImbuedIronAxeCD:Start()
		if args:IsPlayer() then
			specWarnImbuedIronAxe:Show()
			yellImbuedIronAxe:Yell()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 161833 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnNoxiousSpit:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 161833 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then--Goriona's Void zones
		specWarnNoxiousSpit:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--TODO, watch for blizzard to fix IEEU on this fight so we can use "boss1" instead
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	--"<46.8 00:38:13> Commander Tharbek [[target:Iron Reaver::0:161989]]", -- [11]
	--This has combatlog event (Both SUCCESS & DAMAGE) but only if it HITS someone, otherwise there is no CLEU event, this s why we use UNIT_ event.
	if spellId == 161989 and self:AntiSpam(3, 2) then
		self:SendSync("IronReaver")--Syncing because IEEU is broken on fight and so there is no "boss1"
	end
end

function mod:OnSync(event, arg)
	if event == "IronReaver" then
		warnIronReaver:Show()
		timerIronReaverCD:Start()
	end
end
