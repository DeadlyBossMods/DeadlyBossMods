local mod	= DBM:NewMod("d649", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 1131)

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_DIED"
)

--Dark Shaman Xorenth
local warnGlacialFreezeTotem		= mod:NewSpellAnnounce(142320, 2)
local warnRuinedEarth				= mod:NewSpellAnnounce(142306, 3)
--Overseer Elaglo
local warnShatteringStomp			= mod:NewSpellAnnounce(142771, 3)--The cds on these abilities were HIGHLY variable
local warnShatteringCharge			= mod:NewTargetAnnounce(142773, 3)--So timers probably not useful, I localized pull just in case though

--Dark Shaman Xorenth
local specWarnGlacialFreezeTotem	= mod:NewSpecialWarningSwitch(142320)
local specWarnRuinedEarth			= mod:NewSpecialWarningSpell(142306, nil, nil, nil, 2)
local specWarnRuinedEarthMove		= mod:NewSpecialWarningMove(142311)
--Overseer Elaglo
local specWarnShatteredEarth		= mod:NewSpecialWarningMove(142768)

--Dark Shaman Xorenth
local timerGlacialFreezeTotemCD		= mod:NewCDTimer(25, 142320)--Only got cast twice in my log, so cd may be variable, need more data.
local timerRuinedEarth				= mod:NewBuffActiveTimer(15, 142306)
local timerRuinedEarthCD			= mod:NewCDTimer(19.5, 142306)--Timer started when last ended, but actual CD is 34.5ish

mod:RemoveOption("HealthFrame")

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.XorenthPull or msg:find(L.XorenthPull) then
		self:SendSync("XorenthPulled")
--	elseif msg == L.ElagloPull or msg:find(L.ElagloPull) then
--		self:SendSync("ElagloPulled")
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 142771 then
		warnShatteringStomp:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 142320 then
		warnGlacialFreezeTotem:Show()
		timerGlacialFreezeTotemCD:Start()
	elseif args.spellId == 142306 then
		warnRuinedEarth:Show()
		specWarnRuinedEarthMove:Show()
		timerRuinedEarth:Start()
		timerRuinedEarthCD:Schedule(15)--Start CD when current one ends
	elseif args.spellId == 142773 then
		warnShatteringCharge:Show(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 142311 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnRuinedEarthMove:Show()
	elseif spellId == 142768 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnShatteredEarth:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 70683 then--Dark Shaman Xorenth
		timerGlacialFreezeTotemCD:Cancel()
		timerRuinedEarth:Cancel()
		timerRuinedEarthCD:Cancel()
--	elseif cid == 71030 then--Overseer Elaglo
	end
end

function mod:OnSync(msg)
	if msg == "XorenthPulled" then
		timerGlacialFreezeTotemCD:Start(10)
		timerRuinedEarthCD:Start()--Also 19.5
--	elseif msg == "ElagloPulled" then
	end
end
