local mod	= DBM:NewMod("d616", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 1095)

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_SAY",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)
mod.onlyNormal = true

--Darkhatched Lizard-Lord
local warnWaterJets			= mod:NewCastAnnounce(133121, 2, 3)
--Broodmaster Noshi
local warnDeathNova			= mod:NewCastAnnounce(133804, 4, 20)
--Rak'gor Bloodrazor
local warnFixate			= mod:NewSpellAnnounce(132984, 3)

--Darkhatched Lizard-Lord
local specWarnWaterJets		= mod:NewSpecialWarningSpell(133121, false)--For achievement primarily
--Broodmaster Noshi
local specWarnDeathNova		= mod:NewSpecialWarningSpell(133804, nil, nil, nil, 2)
--Rak'gor Bloodrazor
local specWarnGasBomb		= mod:NewSpecialWarningMove(133001)

--Darkhatched Lizard-Lord
local timerAddsCD			= mod:NewTimer(60, "timerAddsCD", 2457)
--Broodmaster Noshi
local timerDeathNova		= mod:NewCastTimer(20, 133804)
--Rak'gor Bloodrazor
local timerFixateCD			= mod:NewNextTimer(20, 132984)


mod:RemoveOption("HealthFrame")

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.LizardLord or msg:find(L.LizardLord) then
		self:SendSync("LizardPulled")
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 133121 then
		warnWaterJets:Show()
		specWarnWaterJets:Show()
	elseif args.spellId == 133804 then
		warnDeathNova:Show()
		specWarnDeathNova:Show()
		timerDeathNova:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 132984 then
		warnFixate:Show()
		timerFixateCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 133001 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnGasBomb:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 67263 then--Darkhatched Lizard-Lord
		timerAddsCD:Cancel()
	elseif cid == 67264 then--Broodmaster Noshi
		timerDeathNova:Cancel()
	elseif cid == 67266 then--Rak'gor Bloodrazor
		timerFixateCD:Cancel()
	end
end

--"<78.3 22:22:54> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#The Darkhatched Lizard-Lord calls for help!#Darkhatched Lizard-Lord#####0#0##0#987#nil#0#false#false"]
--"<78.3 22:22:54> [UNIT_SPELLCAST_SUCCEEDED] Darkhatched Lizard-Lord [[target:Summon Adds Dummy::0:133091]]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 133091 and self:AntiSpam() then
		self:SendSync("LizardAdds")
	end
end

function mod:OnSync(msg)
	if msg == "LizardPulled" then
		timerAddsCD:Start(5)
	elseif msg == "LizardAdds" then
		timerAddsCD:Start()
	end
end
