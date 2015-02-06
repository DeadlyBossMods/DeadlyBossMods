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
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)

mod:SetBossHealthInfo(36272, 36296, 36565)

local warnChainReaction			= mod:NewCastAnnounce(68821, 3)

local specWarnPerfumeSpill		= mod:NewSpecialWarningMove(68927)
local specWarnCologneSpill		= mod:NewSpecialWarningMove(68934)

local timerHummel				= mod:NewTimer(10.5, "HummelActive", 2457, nil, false)
local timerBaxter				= mod:NewTimer(18.5, "BaxterActive", 2457, nil, false)
local timerFrye					= mod:NewTimer(26.5, "FryeActive", 2457, nil, false)
mod:AddBoolOption("TrioActiveTimer", true, "timer")
local timerChainReaction		= mod:NewCastTimer(3, 68821)

function mod:SPELL_CAST_START(args)
	if args.spellId == 68821 then
		warnChainReaction:Show()
		timerChainReaction:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 68927 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnPerfumeSpill:Show()
	elseif spellId == 68934 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnCologneSpill:Show()
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