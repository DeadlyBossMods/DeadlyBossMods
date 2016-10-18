local mod	= DBM:NewMod(1662, "DBM-Party-Legion", 5, 767)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91003)
mod:SetEncounterID(1790)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 188169 188114",
	"SPELL_PERIODIC_DAMAGE 192800",
	"SPELL_PERIODIC_MISSED 192800"
)

--TODO, is razorshards 29 seconds now?
local warnShatter					= mod:NewSpellAnnounce(188114, 2)

local specWarnRazorShards			= mod:NewSpecialWarningSpell(188169, "Tank", nil, nil, 1, 2)
local specWarnGas					= mod:NewSpecialWarningMove(192800, nil, nil, nil, 1, 2)

local timerShatterCD				= mod:NewCDTimer(24.2, 188114, nil, nil, nil, 2)
local timerRazorShardsCD			= mod:NewCDTimer(25, 188169, nil, "Tank", nil, 5)--29?

local voiceRazorShards				= mod:NewVoice(188169, "Tank")--shockwave
local voiceGas						= mod:NewVoice(192800)--runaway

function mod:OnCombatStart(delay)
	timerShatterCD:Start(20-delay)
	timerRazorShardsCD:Start(25-delay)--27?
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 188169 then
		specWarnRazorShards:Show()
		voiceRazorShards:Play("shockwave")
		timerRazorShardsCD:Start()
	elseif spellId == 188114 then
		warnShatter:Show()
		timerShatterCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 192800 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 1) then
		specWarnGas:Show()
		voiceGas:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
