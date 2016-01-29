local mod	= DBM:NewMod(1703, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(102672)
mod:SetEncounterID(1853)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 203552 202977",
	"SPELL_CAST_SUCCESS 204463",
	"SPELL_AURA_APPLIED 204463 203096",
	"SPELL_AURA_REMOVED 204463 203096",
	"SPELL_PERIODIC_DAMAGE 203045",
	"SPELL_PERIODIC_MISSED 203045",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, figure out how stuff works so correct voices can be added to all warnings
local warnBreath					= mod:NewSpellAnnounce(202977, 3, nil, "Tank")--Tank only?
local warnVolatileRot				= mod:NewTargetAnnounce(204463, 4)
local warnRot						= mod:NewTargetAnnounce(203096, 3)
local warnHeartofSwarm				= mod:NewSpellAnnounce(203552, 2)

local specWarnVolatileRot			= mod:NewSpecialWarningRun(204463)
local specWarnVolatileRotSwap		= mod:NewSpecialWarningTaunt(204463)
local yellVolatileRot				= mod:NewFadesYell(204463)
local specWarnRot					= mod:NewSpecialWarningRun(203096)
local yellRot						= mod:NewFadesYell(203096)
local specWarnInfestedGround		= mod:NewSpecialWarningMove(203045, nil, nil, nil, 1, 2)

local timerBreathCD					= mod:NewAITimer(16, 202977, nil, nil, nil, 3)--Targeted or tank only?
local timerVolatileRotCD			= mod:NewAITimer(16, 204463, nil, nil, nil, 3)
local timerRotCD					= mod:NewAITimer(16, 203096, nil, nil, nil, 3)

--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)

local voiceInfestedGround			= mod:NewVoice(203045)

--mod:AddRangeFrameOption("5")
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
--mod:AddHudMapOption("HudMapOnMC", 163472)

function mod:OnCombatStart(delay)
	timerBreathCD:Start(1)
	timerVolatileRotCD:Start(1)
	timerRotCD:Start(1)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.FelArrow then
--		DBM.Arrow:Hide()
--	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 203552 then
		warnHeartofSwarm:Show()
	elseif spellId == 202977 then
		warnBreath:Show()
		timerBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 204463 then
		timerVolatileRotCD:Start()
	elseif spellId == 203096 then
		timerRotCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 204463 then
		if args:IsPlayer() then
			specWarnVolatileRot:Show()
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local remaining = expires-GetTime()
				yellVolatileRot:Schedule(remaining-1, 1)
				yellVolatileRot:Schedule(remaining-2, 2)
				yellVolatileRot:Schedule(remaining-3, 3)
			end
		else
			specWarnVolatileRotSwap:Show(args.destName)
		end
	elseif spellId == 203096 then
		warnRot:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnRot:Show()
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local remaining = expires-GetTime()
				yellVolatileRot:Schedule(remaining-1, 1)
				yellVolatileRot:Schedule(remaining-2, 2)
				yellVolatileRot:Schedule(remaining-3, 3)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 204463 then
	
	elseif spellId == 203096 then

	end
end


function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 203045 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnInfestedGround:Show()
		voiceInfestedGround:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
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
