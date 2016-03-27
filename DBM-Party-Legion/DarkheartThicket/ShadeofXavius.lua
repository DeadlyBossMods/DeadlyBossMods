local mod	= DBM:NewMod(1657, "DBM-Party-Legion", 2, 762)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(99192)
mod:SetEncounterID(1839)
mod:SetZone()
mod:SetUsedIcons(2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 200182 200243 200289",
	"SPELL_AURA_REFRESH 200243",
	"SPELL_AURA_REMOVED 200243",
	"SPELL_CAST_SUCCESS 200359 199837 200182",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TOOD, maybe play gathershare for ALL (except tank) for nightmare target.
--TODO, maybe add an arrow group up hud for nightmare target depending on number of players it takes to clear it.
--TODO, feed on the weak have any significance?
local warnNightmare					= mod:NewTargetAnnounce(200243, 3)
local warnParanoia					= mod:NewTargetAnnounce(200289, 3)

local specWarnFesteringRip			= mod:NewSpecialWarningDispel(200182, "RemoveDisease")--No disease dispeller in group? have fun wiping
local specWarnNightmare				= mod:NewSpecialWarningYou(200243)
local yellNightmare					= mod:NewYell(200243)
local specWarnParanoia				= mod:NewSpecialWarningMoveAway(200289)
local yellParanoia					= mod:NewYell(200289)

local timerFesteringRipCD			= mod:NewCDTimer(17, 200182, nil, "Tank|Healer|RemoveDisease", nil, 5, nil, DBM_CORE_DISEASE_ICON)--17-21
local timerNightmareCD				= mod:NewCDTimer(17, 200243, nil, nil, nil, 3)--17-23
local timerParanoiaCD				= mod:NewCDTimer(18, 200359, nil, nil, nil, 3)--18-28

local voiceNightmare				= mod:NewVoice(200243)--Gathershare
local voiceParanoia					= mod:NewVoice(200243)--scatter

mod:AddSetIconOption("SetIconOnNightmare", 200243)

mod.vb.nightmareIcon = 1
mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.nightmareIcon = 1
	self.vb.phase = 1
	timerFesteringRipCD:Start(3.7-delay)
	timerNightmareCD:Start(6-delay)
	--Feed on weak, 15
	timerParanoiaCD:Start(19-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 200359 then
		timerParanoiaCD:Start()
	elseif spellId == 199837 then--Phase 2
		self.vb.phase = 2
		timerParanoiaCD:Stop()
		timerNightmareCD:Stop()
		timerFesteringRipCD:Stop()
		--Pretty much all after 40 seconds. what order cast in is variable. MIght need adjust
		--Feed on weak, 37
		timerParanoiaCD:Start(39)
		timerNightmareCD:Start(40)
		timerFesteringRipCD:Start(41)
	elseif spellId == 200182 then
		timerFesteringRipCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 200182 then
		specWarnFesteringRip:Show(args.destName)
	elseif spellId == 200243 then
		if args:IsPlayer() then
			specWarnNightmare:Show()
			voiceNightmare:Play("gathershare")
			yellNightmare:Yell()
		else
			warnNightmare:Show(args.destName)
		end
		if self.Options.SetIconOnNightmare then
			self:SetIcon(args.destName, self.vb.nightmareIcon)
		end
		--Alternate Icons
		if self.vb.nightmareIcon == 1 then
			self.vb.nightmareIcon = 2
		else
			self.vb.nightmareIcon = 1
		end
	elseif spellId == 200289 then
		if args:IsPlayer() then
			specWarnParanoia:Show()
			voiceParanoia:Play("scatter")
			yellParanoia:Yell()
		else
			warnParanoia:Show(args.destName)
		end		
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 200243 then
		if self.Options.SetIconOnNightmare then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 204808 then--Because cast is hidden from combat log, and debuff may miss (AMS or the like)
		timerNightmareCD:Start()
	end
end
