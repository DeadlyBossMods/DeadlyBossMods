local mod	= DBM:NewMod("ApothecaryTrio", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36272, 36296, 36565)
mod:SetModelID(16176)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_SAY"
)

local warnChainReaction			= mod:NewCastAnnounce(68821, 3)

local specWarnPerfumeSpill		= mod:NewSpecialWarningMove(68927)
local specWarnCologneSpill		= mod:NewSpecialWarningMove(68934)

local timerHummel				= mod:NewTimer(10.5, "HummelActive", 2457, nil, false)
local timerBaxter				= mod:NewTimer(18.5, "BaxterActive", 2457, nil, false)
local timerFrye					= mod:NewTimer(26.5, "FryeActive", 2457, nil, false)
mod:AddBoolOption("TrioActiveTimer", true, "timer")
local timerChainReaction		= mod:NewCastTimer(3, 68821)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68821) then
		warnChainReaction:Show()
		timerChainReaction:Start()
	end
end

do 
	local lastspill = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(68927) and args:IsPlayer() and GetTime() - lastspill > 2 then
			specWarnPerfumeSpill:Show()
			lastspill = GetTime()
		elseif args:IsSpellID(68934) and args:IsPlayer() and GetTime() - lastspill > 2 then
			specWarnCologneSpill:Show()
			lastspill = GetTime()
		end
	end
end

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