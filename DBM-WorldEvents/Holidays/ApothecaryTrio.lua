local mod	= DBM:NewMod("d288", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36272, 36296, 36565)
mod:SetModelID(16176)
mod:SetZone()

mod:SetReCombatTime(10)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_SAY"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 68821",
	"SPELL_DAMAGE 68927 68934",
	"SPELL_MISSED 68927 68934"
)

local warnChainReaction			= mod:NewCastAnnounce(68821, 3, nil, nil, "Melee", 2)

local specWarnGTFO				= mod:NewSpecialWarningGTFO(68927, nil, nil, nil, 1, 2)

local timerHummel				= mod:NewTimer(10.5, "HummelActive", "Interface\\Icons\\ability_warrior_offensivestance", nil, false, "TrioActiveTimer")
local timerBaxter				= mod:NewTimer(18.5, "BaxterActive", "Interface\\Icons\\ability_warrior_offensivestance", nil, false, "TrioActiveTimer")
local timerFrye					= mod:NewTimer(26.5, "FryeActive", "Interface\\Icons\\ability_warrior_offensivestance", nil, false, "TrioActiveTimer")
mod:AddBoolOption("TrioActiveTimer", true, "timer", nil, 1)
local timerChainReaction		= mod:NewCastTimer(3, 68821, nil, "Melee")

function mod:SPELL_CAST_START(args)
	if args.spellId == 68821 then
		warnChainReaction:Show()
		timerChainReaction:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 68927 or spellId == 68934) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.SayCombatStart or msg:find(L.SayCombatStart) then
		self:SendSync("TrioPulled")
	end
end

function mod:OnSync(msg)
	if msg == "TrioPulled" then
		if self.Options.TrioActiveTimer then
			timerHummel:Start()
			timerBaxter:Start()
			timerFrye:Start()
		end
	end
end