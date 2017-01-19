local mod	= DBM:NewMod(1695, "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(96015)
mod:SetEncounterID(1850)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 201488 200898",
	"SPELL_CAST_SUCCESS 200905 206303",
	"SPELL_AURA_APPLIED 212564",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, voice file "face eye" or "face orb" (212564)
local warnTeleport				= mod:NewSpellAnnounce(200898, 2)

local specWarnSapSoul			= mod:NewSpecialWarningInterrupt(200905, "HasInterrupt", nil, nil, 1, 2)
local specWarnSapSoulHard		= mod:NewSpecialWarningCast(200905, nil, nil, nil, 1, 2)
local specWarnFear				= mod:NewSpecialWarningSpell(201488, nil, nil, nil, 2)
local specWarnStare				= mod:NewSpecialWarningYou(212564, nil, nil, nil, 1)--Disable by default if spammy

local timerSapSoulCD			= mod:NewCDTimer(21.5, 200905, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerTormOrbCD			= mod:NewNextTimer(15, 212567, nil, nil, nil, 1)

local countSapSoul				= mod:NewCountdown(21.5, 200905, true, 2)

local voiceSapSoul				= mod:NewVoice(200905, true, nil, 2)--Kickcast

function mod:OnCombatStart(delay)
	timerSapSoulCD:Start(13-delay)--Might be 10-13?
	countSapSoul:Start(13-delay)
	if not self:IsNormal() then
		timerTormOrbCD:Start(20-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 201488 then
		specWarnFear:Show()
	elseif spellId == 200898 then
		warnTeleport:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args.spellId == 200905 or spellId == 206303 then
		countSapSoul:Cancel()--Just in case
		if self:IsHard() then--Mythic and mythic + only
			specWarnSapSoulHard:Show()
			voiceSapSoul:Play("stopcast")
			timerSapSoulCD:Start(15.4)
			countSapSoul:Start(15.4)
		else--Everything else
			specWarnSapSoul:Show(args.sourceName)
			voiceSapSoul:Play("kickcast")
			timerSapSoulCD:Start()
			countSapSoul:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 212564 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnStare:Show()
	end	
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 214970 then--Summon Tormenting Orb
		timerTormOrbCD:Start()
	end
end
