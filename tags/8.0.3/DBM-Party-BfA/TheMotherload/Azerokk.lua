local mod	= DBM:NewMod(2114, "DBM-Party-BfA", 7, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(129227)
mod:SetEncounterID(2106)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 257582",
	"SPELL_CAST_START 257593 258622 275907",
	"SPELL_CAST_SUCCESS 271698"
)

--TODO, does smash target tank or random player?
local warnRagingGaze				= mod:NewTargetAnnounce(257582, 2)

local specWarnCallEarthRager		= mod:NewSpecialWarningCount(257593, nil, nil, nil, 1, 2)
local specWarnRagingGaze			= mod:NewSpecialWarningRun(257582, nil, nil, nil, 4, 2)
local yellRagingGaze				= mod:NewYell(257582)
local specWarnInfusion				= mod:NewSpecialWarningSwitch(271698, "-Tank", nil, nil, 1, 2)
local specWarnResonantPulse			= mod:NewSpecialWarningDodge(258622, nil, nil, nil, 2, 2)
local specWarnTectonicSmash			= mod:NewSpecialWarningDodge(275907, nil, nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerCallEarthragerCD			= mod:NewAITimer(13, 257593, nil, nil, nil, 1)
local timerInfusionCD				= mod:NewAITimer(13, 271698, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)
local timerResonantPulseCD			= mod:NewAITimer(13, 258622, nil, nil, nil, 2)
local timerTectonicSmashCD			= mod:NewAITimer(13, 275907, nil, nil, nil, 3)

mod:AddInfoFrameOption(257481, true)

mod.vb.addCount = 0

local updateInfoFrame
do
	local ccList = {
		[1] = DBM:GetSpellInfo(257481),--Trap included with fight
		[2] = DBM:GetSpellInfo(6770),--Rogue Sap
		[3] = DBM:GetSpellInfo(9484),--Priest Shackle
		[4] = DBM:GetSpellInfo(20066),--Paladin Repentance
		[5] = DBM:GetSpellInfo(118),--Mage Polymorph
		[6] = DBM:GetSpellInfo(51514),--Shaman Hex
		[7] = DBM:GetSpellInfo(3355),--Hunter Freezing Trap
	}
	local lines = {}
	local floor = math.floor
	updateInfoFrame = function()
		table.wipe(lines)
		for i = 1, 5 do
			local uId = "boss"..i
			if UnitExists(uId) then
				for s = 1, #ccList do
					local spellName = ccList[s]
					local _, _, _, _, _, expires = DBM:UnitDebuff(uId, spellName)
					if expires then
						local debuffTime = expires - GetTime()
						lines[UnitName(uId)] = floor(debuffTime)
						break
					end
				end
			end
		end
		return lines
	end
end

function mod:OnCombatStart(delay)
	self.vb.addCount = 0
	timerCallEarthragerCD:Start(1-delay)--Add 1 to add count later
	timerInfusionCD:Start(1-delay)
	timerResonantPulseCD:Start(1-delay)
	if not self:IsNormal() then
		timerTectonicSmashCD:Start(1-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(227909))
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, true)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 257582 then
		warnRagingGaze:CombinedShow(0.5, args.destName)--In case two adds are up
		if args:IsPlayer() then
			specWarnRagingGaze:Show()
			specWarnRagingGaze:Play("justrun")
			specWarnRagingGaze:ScheduleVoice(1.5, "keepmove")
			yellRagingGaze:Yell()
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 257593 then
		self.vb.addCount = self.vb.addCount + 1
		specWarnCallEarthRager:Show(self.vb.addCount)
		specWarnCallEarthRager:Play("bigmob")
		timerCallEarthragerCD:Start()--add self.vb.addCount+1
	elseif spellId == 258622 then
		specWarnResonantPulse:Show()
		specWarnResonantPulse:Play("watchstep")
		timerResonantPulseCD:Start()
	elseif spellId == 275907 then
		specWarnTectonicSmash:Show()
		specWarnTectonicSmash:Play("shockwave")
		timerTectonicSmashCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 271698 then
		specWarnInfusion:Show()
		specWarnInfusion:Play("killmob")
		timerInfusionCD:Start()
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then
		
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
