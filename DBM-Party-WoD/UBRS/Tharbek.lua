local mod	= DBM:NewMod(1228, "DBM-Party-WoD", 8, 559)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79912, 80098)--80098 is mount(Ironbarb Skyreaver), 79912 is boss
mod:SetEncounterID(1759)
mod:SetZone()
mod:SetBossHPInfoToHighest(false)

mod:RegisterCombat("combat")

mod:SetBossHealthInfo(80098)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 162090",
	"SPELL_AURA_APPLIED 161833",
	"SPELL_PERIODIC_DAMAGE 161989",
	"SPELL_ABSORBED 161989",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_TARGETABLE_CHANGED",
	"UNIT_DIED"
)

--Chi blast warns very spammy. and not useful.
local warnTharbek			= mod:NewSpellAnnounce("ej10276", 3, "Interface\\ICONS\\INV_Misc_Head_Orc_01.blp")
local warnIronReaver		= mod:NewTargetAnnounce(161989, 3)
local warnImbuedIronAxe		= mod:NewTargetAnnounce(162090, 4)

local specWarnImbuedIronAxe	= mod:NewSpecialWarningYou(162090)
local yellImbuedIronAxe		= mod:NewYell(162090)
local specWarnNoxiousSpit	= mod:NewSpecialWarningMove(161833, nil, nil, nil, 1, 2)

local timerIronReaverCD		= mod:NewCDTimer(20.5, 161989, nil, nil, nil, 3)--Not enough data to really verify this
local timerImbuedIronAxeCD	= mod:NewCDTimer(29, 162090, nil, nil, nil, 3)--29-37sec variation

local voiceWarnNoxiousSpit	= mod:NewVoice(161833)

function mod:IronReaverTarget(targetname, uId)
	if not targetname then return end
	warnIronReaver:Show(targetname)
end

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
		voiceWarnNoxiousSpit:Play("runaway")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 161833 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then--Goriona's Void zones
		specWarnNoxiousSpit:Show()
		voiceWarnNoxiousSpit:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 161989 then
		self:BossTargetScanner(79912, "IronReaverTarget", 0.05, 10)
		timerIronReaverCD:Start()
	end
end

function mod:UNIT_TARGETABLE_CHANGED()
	if UnitExists("boss1") then
		warnTharbek:Show()
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(79912)
		end
	end
end

function mod:UNIT_DIED(args)
	if not DBM.BossHealth:IsShown() then return end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 80098 then
		DBM.BossHealth:RemoveBoss(80098)
	end
end
