local mod	= DBM:NewMod("ApothecaryTrio", "DBM-Party-WotLK", 17)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(36272, 36296, 36565)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_SAY"
)

local warnChainReaction			= mod:NewCastAnnounce(68821)

local specWarnPerfumeSpill		= mod:NewSpecialWarningMove(68927)
local specWarnCologneSpill		= mod:NewSpecialWarningMove(68934)

local timerHummel				= mod:NewTimer(11, "HummelActive", nil, nil, false)
local timerBaxter				= mod:NewTimer(19, "BaxterActive", nil, nil, false)
local timerFrye					= mod:NewTimer(27, "FryeActive", nil, nil, false)
mod:AddBoolOption("TrioActiveTimer", true, "timer")
local timerChainReaction		= mod:NewCastTimer(3, 68821)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68821) then
		warnChainReaction:Show()
		timerChainReaction:Start()
	end
end

do 
	local lastPerfspill = 0
	local lastColnspill = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(68927) and args:IsPlayer() and time() - lastPerfspill > 2 then
			specWarnPerfumeSpill:Show()
			lastPerfspill = time()
		elseif args:IsSpellID(68934) and args:IsPlayer() and time() - lastColnspill > 2 then
			specWarnCologneSpill:Show()
			lastColnspill = time()
		end
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.SayCombatStart or msg:find(L.SayCombatStart) then
		self:SendSync("CombatStart")
	end
end

function mod:OnSync(msg, arg)
	if msg == "CombatStart" then
		if self.Options.TrioActiveTimer then
			timerHummel:Start()
			timerBaxter:Start()
			timerFrye:Start()
		end
	end
end