local mod	= DBM:NewMod(1664, "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(98949)
mod:SetEncounterID(1834)
mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 198079",
	"SPELL_AURA_APPLIED 198079",
	"SPELL_AURA_REMOVED 198079",
	"SPELL_CAST_START 198073 198245",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_POWER_FREQUENT boss1"
)

--TODO, maye GTFO for fire on ground (and timers and other stuff for it too maybe, seems all over place though).
local warnHatefulGaze				= mod:NewTargetAnnounce(198079, 4)

local specWarnStomp					= mod:NewSpecialWarningSpell(198073, nil, nil, nil, 2, 2)
local specWarnHatefulGaze			= mod:NewSpecialWarningDefensive(198079, nil, nil, nil, 1, 2)
local yellHatefulGaze				= mod:NewYell(198079)
local specWarnBrutalHaymakerSoon	= mod:NewSpecialWarningSoon(198245, "Tank|Healer", nil, nil, 1, 2)--Face fuck soon
local specWarnBrutalHaymaker		= mod:NewSpecialWarningDefensive(198245, "Tank", nil, nil, 3, 2)--Incoming face fuck

local timerStompCD					= mod:NewCDTimer(17, 198073, nil, nil, nil, 2)--Next timers but delayed by other casts
local timerHatefulGazeCD			= mod:NewCDTimer(25.5, 198079, nil, nil, nil, 3)--Next timers but delayed by other casts

local voiceStomp					= mod:NewVoice(198073)--carefly
local voiceBrutalHeymaker			= mod:NewVoice(198073, "Tank|Healer")--defensive/tankheal
local voiceHatefulGaze				= mod:NewVoice(198079)--targetyou

mod:AddInfoFrameOption(198080)
mod:AddSetIconOption("SetIconOnHatefulGaze", 198079, true)

local superWarned = false

function mod:OnCombatStart(delay)
	if not self:IsNormal() then
		timerHatefulGazeCD:Start(5-delay)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(198080))
			DBM.InfoFrame:Show(5, "reverseplayerbaddebuff", 198080)
		end
	end
	timerStompCD:Start(12-delay)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 198079 then
		timerHatefulGazeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 198079 then
		if args:IsPlayer() then
			specWarnHatefulGaze:Show()
			yellHatefulGaze:Yell()
			voiceHatefulGaze:Play("targetyou")
		else
			warnHatefulGaze:Show(args.destName)
		end
		if self.Options.SetIconOnHatefulGaze then
			self:SetIcon(args.destName, 1)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 198079 and self.Options.SetIconOnHatefulGaze then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198073 then
		specWarnStomp:Show()
		timerStompCD:Start()
		voiceStomp:Play("carefly")
	elseif spellId == 198245 and not superWarned then--fallback, only 0.7 seconds warning vs 1.2 if power 100 works, but better than naught.
		superWarned = true
		specWarnBrutalHaymaker:Show()
		if self:IsTank() then
			voiceBrutalHeymaker:Play("defensive")
		else
			voiceBrutalHeymaker:Play("tankheal")
		end
	end
end

do
	local warnedSoon = false
	local UnitPower = UnitPower
	function mod:UNIT_POWER_FREQUENT(uId)
		local power = UnitPower(uId)
		if power >= 85 and not warnedSoon then
			warnedSoon = true
			specWarnBrutalHaymakerSoon:Show()
			voiceBrutalHeymaker:Play("energyhigh")
		elseif power < 50 and warnedSoon then
			warnedSoon = false
			superWarned = false
		elseif power == 100 and not superWarned then--Doing here is about 0.5 seconds faster than SPELL_CAST_START, when it works.
			superWarned = true
			specWarnBrutalHaymaker:Show()
			if self:IsTank() then
				voiceBrutalHeymaker:Play("defensive")
			else
				voiceBrutalHeymaker:Play("tankheal")
			end
		end
	end
end
