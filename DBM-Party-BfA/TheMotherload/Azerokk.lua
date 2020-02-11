local mod	= DBM:NewMod(2114, "DBM-Party-BfA", 7, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(129227)
mod:SetEncounterID(2106)
mod:DisableESCombatDetection()--ES fires for nearby trash even if boss isn't pulled
mod:SetZone()
mod:SetMinSyncRevision(17732)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 257582",
	"SPELL_CAST_START 257593 258622 275907 258627",
	"SPELL_CAST_SUCCESS 271698"
)

local warnRagingGaze				= mod:NewTargetAnnounce(257582, 2)
local warnPulse						= mod:NewCastAnnounce(258622, 3)

local specWarnCallEarthRager		= mod:NewSpecialWarningCount(257593, nil, nil, nil, 1, 2)
local specWarnRagingGaze			= mod:NewSpecialWarningRun(257582, nil, nil, nil, 4, 2)
local yellRagingGaze				= mod:NewYell(257582)
local specWarnInfusion				= mod:NewSpecialWarningSwitch(271698, "-Tank", nil, nil, 1, 2)
--local specWarnResonantPulse			= mod:NewSpecialWarningDodge(258622, nil, nil, nil, 2, 2)
local specWarnTectonicSmash			= mod:NewSpecialWarningDodge(275907, "Tank", nil, 2, 1, 2)
local specWarnQuake					= mod:NewSpecialWarningDodge(258627, nil, nil, nil, 2, 2)

local timerCallEarthragerCD			= mod:NewNextCountTimer(60.4, 257593, nil, nil, nil, 1)
--local timerInfusionCD				= mod:NewAITimer(13, 271698, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)--Health based?
local timerResonantPulseCD			= mod:NewCDTimer(32.2, 258622, nil, nil, nil, 2)
local timerTectonicSmashCD			= mod:NewCDTimer(23.0, 275907, nil, nil, nil, 3)--23-28

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
	timerCallEarthragerCD:Start(60-delay, 1)
	--timerInfusionCD:Start(1-delay)--19.6
	timerResonantPulseCD:Start(10.6-delay)
	if not self:IsNormal() then
		timerTectonicSmashCD:Start(5-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(227909))
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, true)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 257582 then
		warnRagingGaze:CombinedShow(0.5, args.destName)--In case two adds are up
		if args:IsPlayer() and self:AntiSpam(3.5, 2) then
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
		timerCallEarthragerCD:Start(60, self.vb.addCount+1)--add self.vb.addCount+1
	elseif spellId == 258622 then
		warnPulse:Show()
		timerResonantPulseCD:Start()
	elseif spellId == 275907 then
		specWarnTectonicSmash:Show()
		specWarnTectonicSmash:Play("shockwave")
		timerTectonicSmashCD:Start()
	elseif spellId == 258627 and self:AntiSpam(3.5, 1) then
		specWarnQuake:Show()
		specWarnQuake:Play("watchstep")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 271698 then
		specWarnInfusion:Show()
		specWarnInfusion:Play("killmob")
		--timerInfusionCD:Start()--15.8, 36.4, 64.0
	end
end
