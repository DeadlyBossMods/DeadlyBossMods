local mod	= DBM:NewMod(2446, "DBM-SantumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(164406)
mod:SetEncounterID(2436)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20201222000000)
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 352589 352538 350732 352833 352660 350496",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 352385 352394 350734 350496",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 352385 352394 350496",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
	"RAID_BOSS_WHISPER"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, are meltdowns just a wipe or a mechanic to deal with?
--TODO, verify target scanning
local warnThreatNeutralization					= mod:NewTargetNoFilterAnnounce(350496, 2)

--Cores
local specWarnRadiantEnergy						= mod:NewSpecialWarningMoveTo(350455, nil, nil, nil, 1, 2)
local specWarnMeltdown							= mod:NewSpecialWarningRun(352589, nil, nil, nil, 4, 2)--Change to appropriate text and priority
--Guardian
local specWarnPurgingProtocol					= mod:NewSpecialWarningSpell(352538, nil, nil, nil, 2, 2)
local specWarnShatter							= mod:NewSpecialWarningDefensive(350732, nil, nil, nil, 1, 2)
local specWarnObliterate						= mod:NewSpecialWarningTaunt(350734, nil, nil, nil, 1, 2)
local specWarnDisintegration					= mod:NewSpecialWarningDodge(352833, nil, nil, nil, 2, 2)
local yellDisintegration						= mod:NewYell(352833)
local specWarnFormSentry						= mod:NewSpecialWarningSwitch(352660, "Dps", nil, nil, 1, 2)
local specWarnThreatNeutralization				= mod:NewSpecialWarningMoveAway(350496, nil, nil, nil, 1, 2)
local yellThreatNeutralization					= mod:NewYell(350496)
local yellThreatNeutralizationFades				= mod:NewShortFadesYell(350496)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerEliminationPatternCD					= mod:NewAITimer(17.8, 350735, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerDisintegrationCD						= mod:NewAITimer(23, 352833, nil, nil, nil, 3)
local timerFormSentryCD							= mod:NewAITimer(23, 352660, nil, nil, nil, 1)
local timerThreatNeutralizationCD				= mod:NewAITimer(23, 350496, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(352394, true)
--mod:AddSetIconOption("SetIconOnEcholocation", 342077, true, false, {1, 2, 3})

local radiantEnergy = DBM:GetSpellInfo(352394)
local playerSafe = false
local playersSafe = {}
mod.vb.coreActive = false

local updateInfoFrame
do
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Boss Power
		local currentPower, maxPower = UnitPower("boss1"), UnitPowerMax("boss1")
		if maxPower and maxPower ~= 0 then
			if currentPower / maxPower * 100 >= 1 then
				addLine(UnitName("boss1"), currentPower)
			end
		end
		--Player safety status
		if mod.vb.coreActive then
			addLine(radiantEnergy, DBM_CORE_L.NOTSAFE))
			for uId in DBM:GetGroupMembers() do
				local unitName = DBM:GetUnitFullName(uId)
				if not playersSafe[unitName] then
					addLine(unitName, "")
				end
			end
		end
		return lines, sortedLines
	end
end

function mod:DisintegrationTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
--		specWarnDisintegration:Show()
--		specWarnDisintegration:Play("runout")
		yellDisintegration:Yell()
--	else
--		warnEyeBeam:Show(self.vb.eyeCount, targetname)
	end
--	if self.Options.SetIconOnEyeBeam then
--		self:SetIcon(targetname, 1, 5)
--	end
end

function mod:OnCombatStart(delay)
	playerSafe = false
	timerEliminationPatternCD:Start(1-delay)
	timerDisintegrationCD:Start(1-delay)
	timerFormSentryCD:Start(1-delay)
	timerThreatNeutralizationCD:Start(1-delay)
	--Infoframe setup
	for uId in DBM:GetGroupMembers() do
		if DBM:UnitDebuff(uId, 352394) then
			local unitName = DBM:GetUnitFullName(uId)
			playersSafe[unitName] = true
		end
	end
	if DBM:UnitAura("boss1", 352385) then
		self.vb.coreActive = true
	else
		self.vb.coreActive = false
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(radiantEnergy)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:OnTimerRecovery()
	if DBM:UnitDebuff("player", 352394) then
		playerSafe = true
	end
	for uId in DBM:GetGroupMembers() do
		if DBM:UnitDebuff(uId, 352394) then
			local unitName = DBM:GetUnitFullName(uId)
			playersSafe[unitName] = true
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 352589 then
		specWarnMeltdown:Show()
		specWarnMeltdown:Play("justrun")
	elseif spellId == 352538 then
		specWarnPurgingProtocol:Show()
		specWarnPurgingProtocol:Play("aesoon")
	elseif spellId == 350732 then
		timerEliminationPatternCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnShatter:Show()
			specWarnShatter:Play("defensive")
		end
	elseif spellId == 352833 then
		specWarnDisintegration:Show()
		specWarnDisintegration:Play("laserrun")
		timerDisintegrationCD:Start()
		self:BossTargetScanner(args.sourceGUID, "DisintegrationTarget", 0.1, 12, true, nil, nil, nil, true)
	elseif spellId == 352660 then
		specWarnFormSentry:Show()
		specWarnFormSentry:Play("killmob")
		timerFormSentryCD:Start()
	elseif spellId == 350496 then
		timerThreatNeutralizationCD:start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 328857 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 352385 then--Energizing Link
		self.vb.coreActive = true
		if not playerSafe then
			specWarnRadiantEnergy:Show(radiantEnergy)
			specWarnRadiantEnergy:Play("findshelter")
		end
		--TODO, timer stuff here?
	elseif spellId == 352394 then
		if args:IsPlayer() then
			playerSafe = true
		end
	elseif spellId == 350734 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			specWarnObliterate:Show(args.destName)
			specWarnObliterate:Play("tauntboss")
		end
	elseif spellId == 350496 then
		warnThreatNeutralization:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnThreatNeutralization:Show()
			specWarnThreatNeutralization:Play("runout")
			yellThreatNeutralization:Yell()
			yellThreatNeutralizationFades:Countdown(spellId)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 352385 then--Energizing Link
		self.vb.coreActive = false
	elseif spellId == 352394 then
		if args:IsPlayer() then
			playerSafe = false
		end
	elseif spellId == 350496 then
		if args:IsPlayer() then
			yellThreatNeutralizationFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 342074 then

	end
end
--]]
