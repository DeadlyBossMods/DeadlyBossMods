local mod	= DBM:NewMod(1662, "DBM-Party-Legion", 5, 767)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91003)
mod:SetEncounterID(1790)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 188961",
	"SPELL_PERIODIC_DAMAGE 192800",
	"SPELL_PERIODIC_MISSED 192800",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, get more logs because I lost my logs of this and can only do so much
local specWarnRazorShards			= mod:NewSpecialWarningSpell(188961, "Tank", nil, nil, 1, 2)
local specWarnGas					= mod:NewSpecialWarningMove(192800, "Tank", nil, nil, 1, 2)

local timerRazorShardsCD			= mod:NewCDTimer(25, 188961, nil, "Tank", nil, 5)

local voiceRazorShards				= mod:NewVoice(188961)--shockwave
local voiceGas						= mod:NewVoice(192800)--runaway

function mod:OnCombatStart(delay)
	timerRazorShardsCD:Start(25-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 188961 then
		specWarnRazorShards:Show()
		voiceRazorShards:Play("shockwave")
		timerRazorShardsCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 192800 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 1) then
		specWarnGas:Show()
		voiceGas:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 153500 then

	end
end
--]]