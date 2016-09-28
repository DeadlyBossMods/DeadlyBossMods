local mod	= DBM:NewMod(1756, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(106981, 106982, 106984)--Captain Hring, Reaver Jdorn, Soultrapper Mevra
mod:SetEncounterID(1879)
mod:SetReCombatTime(20)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 213420 213522 213532 213665 213625 213606",
	"SPELL_AURA_APPLIED 213584",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_INTERRUPTED target focus",
	"UNIT_DIED"
)

--TODO, review warnings and promote/demote as needed. Especially MaraudingMists
--TODO, do these get boss unit IDs? if so fix UNIT_SPELLCAST_INTERRUPTED
--TODO, see how scuttle works exactly and get some hud charge lines in there.
--Captain Hring 
local warnTentacleBash				= mod:NewCastAnnounce(213420, 2)
local warnShatterCrew				= mod:NewCastAnnounce(213532, 3)
--Reaver Jdorn
local warnMaraudingMists			= mod:NewCastAnnounce(213665, 3)
--Soultrapper Mevra

--Captain Hring 
local specWarnCursedCrew			= mod:NewSpecialWarningSwitch(213522, "-Healer", nil, nil, 1, 2)
--Reaver Jdorn
local specWarnScuttle				= mod:NewSpecialWarningYou(213584, nil, nil, nil, 1, 2)
local yellScuttle					= mod:NewYell(213584)
local specWarnExpelSoul				= mod:NewSpecialWarningInterrupt(213665, "HasInterrupt", nil, nil, 1, 2)
--Soultrapper Mevra
local specWarnSoulRend				= mod:NewSpecialWarningDodge(213606, nil, nil, nil, 2, 2)

--Captain Hring 
local timerTentacleBashCD			= mod:NewAITimer(51, 213420, nil, nil, nil, 3)
local timerCursedCrewCD				= mod:NewAITimer(51, 213522, nil, nil, nil, 1)
local timerShatterCrew				= mod:NewCastTimer(51, 213532, nil, nil, nil, 2)
--Reaver Jdorn
local timerMaraudingMistsCD			= mod:NewAITimer(51, 213665, nil, nil, nil, 2)
--Soultrapper Mevra
local timerExpelSoulCD				= mod:NewAITimer(51, 213665, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerSoulRendCD				= mod:NewAITimer(51, 213606, nil, nil, nil, 3)

--Captain Hring 
local voiceCursedCrew				= mod:NewVoice(213522, "-Healer")--killmob
--Reaver Jdorn
--Soultrapper Mevra
local voiceExpelSoul				= mod:NewVoice(213665, "HasInterrupt")--kickcast
local voiceSoulRend					= mod:NewVoice(213606)--watchstep

--mod:AddReadyCheckOption(37462, false)--Unknown quest flag
--mod:AddRangeFrameOption(8, 187668)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 213420 then
		warnTentacleBash:Show()
		timerTentacleBashCD:Start()
	elseif spellId == 213522 then
		specWarnCursedCrew:Show()
		voiceCursedCrew:Play("killmob")
		timerCursedCrewCD:Start()
	elseif spellId == 213532 then
		warnShatterCrew:Show()
		timerShatterCrew:Start()
	elseif spellId == 213665 then
		warnMaraudingMists:Show()
	elseif spellId == 213625 then
		timerExpelSoulCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnExpelSoul:Show(args.sourceName)
			voiceExpelSoul:Play("kickcast")
		end
	elseif spellId == 213606 then
		specWarnSoulRend:Show()
		voiceSoulRend:Play("watchstep")
		timerSoulRendCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 213584 then
		if args:IsPlayer() then
			specWarnScuttle:Show()
			yellScuttle:Yell()
		end
	end
end

function mod:UNIT_SPELLCAST_INTERRUPTED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 213532 then
		timerShatterCrew:Stop()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 106981 then--Captain Hring
		timerTentacleBashCD:Stop()
		timerCursedCrewCD:Stop()
		timerShatterCrew:Stop()
	elseif cid == 106982 then--Reaver Jdorn
		timerMaraudingMistsCD:Stop()
	elseif cid == 106984 then--Soultrapper Mevra
		timerExpelSoulCD:Stop()
		timerSoulRendCD:Stop()
	end
end
