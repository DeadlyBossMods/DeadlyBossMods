local mod	= DBM:NewMod(2170, "DBM-Party-BfA", 3, 1041)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(135475, 135470, 135472)
mod:SetEncounterID(2140)
mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 267256",
	"SPELL_CAST_START 266206 266951 266237 267273 267060",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--TODO, accurate detection of who starts fight, and bosses swapping in and out
--TODO, figure out what to do with Severing Axe
--TODO, fix events, especially barrel Through, with logs
local warnBarrelThrough				= mod:NewTargetNoFilterAnnounce(266951, 2)

--Kula the Butcher
local specWarnWhirlingAxes			= mod:NewSpecialWarningDodge(266206, nil, nil, nil, 2, 1)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Aka'ali the Conqueror
local specWarnBarrelThrough			= mod:NewSpecialWarningYou(266951, nil, nil, nil, 1, 1)
local yellBarrelThrough				= mod:NewYell(266951)
--local yellBarrelThroughFades		= mod:NewShortFadesYell(266951)
local specWarnDebilitatingBackhand	= mod:NewSpecialWarningYou(266237, nil, nil, nil, 1, 1)
--Zanazal the Wise
local specWarnPoisonNova			= mod:NewSpecialWarningInterrupt(267273, "HasInterrupt", nil, nil, 1, 2)
local specWarnTotems				= mod:NewSpecialWarningSwitch(267060, nil, nil, nil, 1, 1)
local specWarnEarthwall				= mod:NewSpecialWarningDispel(267256, "MagicDispeller", nil, nil, 1, 2)

--Kula the Butcher
local timerWhirlingAxesCD			= mod:NewAITimer(13, 266206, nil, nil, nil, 3)
--Aka'ali the Conqueror
local timerBarrelThroughCD			= mod:NewAITimer(13, 266951, nil, nil, nil, 3)
local timerDebilitatingBackhandCD	= mod:NewAITimer(13, 266237, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON)
--Zanazal the Wise
local timerPoisonNovaCD				= mod:NewAITimer(13, 267273, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerTotemsCD					= mod:NewAITimer(13, 267060, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

--mod:AddRangeFrameOption(5, 194966)
mod:AddSetIconOption("SetIconOnBarrel", 266951, true)

local function whoDat(self)
	for i = 1, 3 do--Might actually only need to check boss 1
		local bossUID = "boss"..i
		if UnitExists(bossUID) then--if they are in Urn they won't exist.
			local cid = self:GetUnitCreatureId(bossUID)
			if cid == 135475 then -- Kula the Butcher
				timerWhirlingAxesCD:Start(1-delay)
			elseif cid == 135470 then -- Aka'ali the Conqueror
				timerBarrelThroughCD:Start(1-delay)
				timerDebilitatingBackhandCD:Start(1-delay)
			elseif cid == 135472 then -- Zanazal the Wise
				timerPoisonNovaCD:Start(1-delay)
				timerTotemsCD:Start(1-delay)
			end
		end
	end
end

function mod:OnCombatStart(delay)
	self:Schedule(2, whoDat, self)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 267256 then
		specWarnEarthwall:Show(args.destName)
		specWarnEarthwall:Play("dispelboss")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 266206 then
		specWarnWhirlingAxes:Show()
		specWarnWhirlingAxes:Play("watchstep")
		timerWhirlingAxesCD:Start()
	elseif spellId == 266951 then
		timerBarrelThroughCD:Start()
	elseif spellId == 266237 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnDebilitatingBackhand:Show()
			specWarnDebilitatingBackhand:Play("carefly")
		end
		timerDebilitatingBackhandCD:Start()
	elseif spellId == 267273 then
		timerPoisonNovaCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnPoisonNova:Show(args.sourceName)
			specWarnPoisonNova:Play("kickcast")
		end
	elseif spellId == 267060 then
		specWarnTotems:Show()
		specWarnTotems:Play("changetarget")
		timerTotemsCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 267618 then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 135475 then -- Kula the Butcher
		timerWhirlingAxesCD:Stop()
	elseif cid == 135470 then -- Aka'ali the Conqueror
		timerBarrelThroughCD:Stop()
		timerDebilitatingBackhandCD:Stop()
	elseif cid == 135472 then -- Zanazal the Wise
		timerPoisonNovaCD:Stop()
		timerTotemsCD:Stop()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:266951") then
		local targetname = DBM:GetUnitFullName(target)
		if targetname then
			if targetname == UnitName("player") then
				specWarnBarrelThrough:Show()
				specWarnBarrelThrough:Play("targetyou")
				yellBarrelThrough:Yell()
				--yellBarrelThroughFades:Countdown(8)
			else
				warnBarrelThrough:Show(targetname)
			end
			if self.Options.SetIconOnBarrel then
				self:SetIcon(targetname, 1, 8)
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
