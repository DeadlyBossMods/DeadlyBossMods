local mod	= DBM:NewMod("AmirdrassilTrash", "DBM-Raids-Dragonflight", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 425062 425149 425995",
	"SPELL_AURA_APPLIED 428765 425300 425388 425381",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 428765 425300",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, kick blazing pulse
--TODO, inferno heart spread
local warnShadowflameBomb					= mod:NewTargetAnnounce(425300, 3)
local warnInfernoHeart						= mod:NewTargetAnnounce(425388, 3)
local warnShadowchargedSlam					= mod:NewCastAnnounce(425062, 3, nil, nil, "Melee")

local specWarnShadowflameBomb				= mod:NewSpecialWarningMoveAway(425300, nil, nil, nil, 1, 2)
local yellShadowflameBomb					= mod:NewYell(425300)
local yellShadowflameBombFades				= mod:NewShortFadesYell(425300)
local specWarnInfernoHeart					= mod:NewSpecialWarningMoveAway(425388, nil, nil, nil, 1, 2)
local yellInfernoHeart						= mod:NewYell(425388)
local yellInfernoHeartFades					= mod:NewShortFadesYell(425388)
local specWarnChargedStomp					= mod:NewSpecialWarningDodge(425149, "Melee", nil, nil, 4, 2)
local specWarnFeatherBomb					= mod:NewSpecialWarningDodge(428765, nil, nil, nil, 2, 2)
local specWarnTranquility					= mod:NewSpecialWarningInterrupt(425995, "HasInterrupt", nil, nil, 1, 2)
local specWarnBlazingPulse					= mod:NewSpecialWarningInterrupt(425381, "HasInterrupt", nil, nil, 1, 2)

local timerFeatherBombCD					= mod:NewNextTimer(22.9, 428765, nil, nil, nil, 3)--CD for it starting after RP starts
local timerFeatherBomb						= mod:NewBuffActiveTimer(6, 428765, nil, nil, nil, 5)--How long it's active and when not to come up

--local playerName = UnitName("player")

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 425062 and self:AntiSpam(5, 6) then
		warnShadowchargedSlam:Show()
	elseif spellId == 425995 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnTranquility:Show(args.sourceName)
		specWarnTranquility:Play("kickcast")
	elseif spellId == 425149 and self:AntiSpam(5, 2) then
		specWarnChargedStomp:Show()
		specWarnChargedStomp:Play("justrun")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 428765 then
		specWarnFeatherBomb:Show()
		specWarnFeatherBomb:Play("watchstep")
		timerFeatherBomb:Start()
	elseif spellId == 425300 then
		warnShadowflameBomb:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnShadowflameBomb:Show()
			specWarnShadowflameBomb:Play("runout")
			yellShadowflameBomb:Yell()
			yellShadowflameBombFades:Countdown(spellId)
		end
	elseif spellId == 425388 then
		warnInfernoHeart:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnInfernoHeart:Show()
			specWarnInfernoHeart:Play("runout")
			yellInfernoHeart:Yell()
			yellInfernoHeartFades:Countdown(spellId)
		end
	elseif spellId == 425381 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBlazingPulse:Show(args.destName)
		specWarnBlazingPulse:Play("kickcast")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 428765 then
		timerFeatherBomb:Stop()
	elseif spellId == 425300 then
		if args:IsPlayer() then
			yellShadowflameBombFades:Cancel()
		end
	elseif spellId == 425388 then
		if args:IsPlayer() then
			yellInfernoHeartFades:Cancel()
		end
	end
end

--"<36.78 22:58:03> [CHAT_MSG_MONSTER_YELL] You again. A pity I do not have time to eradicate you myself.#Fyrakk###Omegal##0#0##0#3575#nil#0#false#false#false#false", -- [13]
--"<59.69 22:58:26> [CLEU] SPELL_CAST_SUCCESS#Creature-0-3781-2549-28739-209090-000004F6AC#Tindral Sageswift(100.0%-0.0%)##nil#428765#Feather Bomb#nil#nil", -- [35]
--"<59.69 22:58:26> [CLEU] SPELL_AURA_APPLIED#Creature-0-3781-2549-28739-209090-000004F6AC#Tindral Sageswift#Creature-0-3781-2549-28739-209090-000004F6AC#Tindral Sageswift#428765#Feather Bomb#BUFF#nil", -- [33]
--"<65.75 22:58:32> [CLEU] SPELL_AURA_REMOVED#Creature-0-3781-2549-28739-209090-000004F6AC#Tindral Sageswift#Creature-0-3781-2549-28739-209090-000004F6AC#Tindral Sageswift#428765#Feather Bomb#BUFF#nil", -- [44]
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.FyrakkRP or msg:find(L.FyrakkRP)) then
		self:SendSync("DontDie")
	end
end

function mod:OnSync(event, arg)
	if event == "DontDie" then
		timerFeatherBombCD:Start(22.9)
	end
end
