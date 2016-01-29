if DBM:GetTOC() < 70000 then return end
local mod	= DBM:NewMod(1706, "DBM-Suramar", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(101417)
mod:SetEncounterID(1849)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 204275 204372 204316 204471",
	"SPELL_CAST_SUCCESS 204292",
	"SPELL_AURA_APPLIED 204531 204459",
	"SPELL_AURA_REMOVED 204531 204459",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, figure out how stuff works so correct voices can be added to all warnings
local warnBrokenShard				= mod:NewSpellAnnounce(204292, 3)
local warnShockwave					= mod:NewCastAnnounce(204316, 3)
local warnVulnerable				= mod:NewTargetAnnounce(204459, 1)

local specWarnArcanoslash			= mod:NewSpecialWarningSpell(204275, "Tank")
local yellArcaneTether				= mod:NewYell(204531, nil, false)
local specWarnNetherDischarge		= mod:NewSpecialWarningSpell(204471, nil, nil, nil, 2)

local timerArcanoslashCD			= mod:NewAITimer(16, 204275, nil, nil, nil, 5)
local timerCallofScorpidCD			= mod:NewAITimer(16, 204372, nil, nil, nil, 1)
local timerShockwaveCD				= mod:NewAITimer(16, 204316, nil, nil, nil, 3)
local timerNetherDischargeCD		= mod:NewAITimer(16, 204471, nil, nil, nil, 2)

--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)

--local voiceExpelMagicFire			= mod:NewVoice(162185)

mod:AddRangeFrameOption(10, 204531)
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
--mod:AddHudMapOption("HudMapOnMC", 163472)

local debuffFilter
local UnitDebuff = UnitDebuff
local debuffName = GetSpellInfo(204531)
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

function mod:OnCombatStart(delay)
	timerArcanoslashCD:Start(1)
	timerCallofScorpidCD:Start(1)
	timerShockwaveCD:Start(1)
	timerNetherDischargeCD:Start(1)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10, debuffFilter)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.FelArrow then
--		DBM.Arrow:Hide()
--	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 204275 and self:AntiSpam(5, 1) then
		specWarnArcanoslash:Show()
		timerArcanoslashCD:Start()
	elseif spellId == 204372 then
		timerCallofScorpidCD:Start()
	elseif spellId == 204316 then
		warnShockwave:Show()
		timerShockwaveCD:Start()
	elseif spellId == 204471 then
		specWarnNetherDischarge:Show()
		timerNetherDischargeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 204292 then
		warnBrokenShard:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 204531 then
		if args:IsPlayer() then
			yellArcaneTether:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil)
			end
		end
	elseif spellId == 204459 then
		warnVulnerable:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 204531 then
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, debuffFilter)
			end
		end
	elseif spellId == 204459 then
		--Probably timer resets and stuff?
--		timerArcanoslashCD:Start(2)
--		timerCallofScorpidCD:Start(2)
--		timerShockwaveCD:Start(2)
--		timerNetherDischargeCD:Start(2)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
