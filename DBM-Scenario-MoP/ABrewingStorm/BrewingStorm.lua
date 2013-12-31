local mod	= DBM:NewMod("d517", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 1005)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_SAY",
	"UNIT_DIED"
)

--Borokhula the Destroyer
local warnSwampSmash			= mod:NewSpellAnnounce(115013, 3)--TODO, see if target scanning works and change to target warning and target special warning instead
local warnEarthShattering		= mod:NewSpellAnnounce(122142, 3)

--Borokhula the Destroyer
local specWarnSwampSmash		= mod:NewSpecialWarningSpell(115013, nil, nil, nil, 2)

--Borokhula the Destroyer
local timerSwampSmashCD			= mod:NewCDTimer(8, 115013)
local timerEarthShatteringCD	= mod:NewCDTimer(18, 122142)--Limited sample size, may be shorter

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if args.spellId == 115013 then
		warnSwampSmash:Show()
		specWarnSwampSmash:Show()
		timerSwampSmashCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 122142 then
		warnEarthShattering:Show()
		timerEarthShatteringCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.BorokhulaPull or msg:find(L.BorokhulaPull) then
		self:SendSync("BorokhulaPulled")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 58739 then--Borokhula the Destroyer
		timerSwampSmashCD:Cancel()
		timerEarthShatteringCD:Cancel()
	end
end

function mod:OnSync(msg)
	if msg == "BorokhulaPulled" then
		timerSwampSmashCD:Start()
		timerEarthShatteringCD:Start()
	end
end
