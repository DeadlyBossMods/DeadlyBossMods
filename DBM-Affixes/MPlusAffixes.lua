local mod	= DBM:NewMod("MPlusAffixes", "DBM-Affixes")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone(2516, 2526, 2515, 2521, 1477, 1571, 1176, 960)--All of the S1 DF M+ Dungeons

mod.isTrashMod = true
mod.isTrashModBossFightAllowed = true

mod:RegisterEvents(
	"SPELL_CAST_START 240446",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 240447 226512 350209 396369 396364",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 396369 396364",
	"SPELL_DAMAGE 209862",
	"SPELL_MISSED 209862"
--	"UNIT_DIED"
)

--TODO, fine tune tank stacks/throttle?
--[[
(ability.id = 240446) and type = "begincast"
--]]
local warnExplosion							= mod:NewCastAnnounce(240446, 4)
local warnThunderingFades					= mod:NewFadesAnnounce(396363, 1)

local specWarnQuake							= mod:NewSpecialWarningMoveAway(240447, nil, nil, nil, 1, 2)
local specWarnSpitefulFixate				= mod:NewSpecialWarningYou(350209, nil, nil, nil, 1, 2)
local specWarnPositiveCharge				= mod:NewSpecialWarningYou(396369, nil, 391990, nil, 1, 13)--Short name is using Positive Charge instead of Mark of Lightning
local specWarnNegativeCharge				= mod:NewSpecialWarningYou(396364, nil, 391991, nil, 1, 13)--Short name is using Netative Charge instead of Mark of Winds
local yellThundering						= mod:NewIconRepeatYell(396363, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell)--15-5
local yellThunderingFades					= mod:NewIconFadesYell(396363, nil, nil, nil, "YELL")--5 too 0
local specWarnGTFO							= mod:NewSpecialWarningGTFO(209862, nil, nil, nil, 1, 8)--Volcanic and Sanguine

local timerPositiveCharge					= mod:NewBuffFadesTimer(15, 396369, 391990, nil, 2, 5, nil, nil, nil, 1, 4)
local timerNegativeCharge					= mod:NewBuffFadesTimer(15, 396364, 391991, nil, 2, 5, nil, nil, nil, 1, 4)
mod:GroupSpells(396363, 396369, 396364)--Thundering with the two charge spells

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc, 7 gtfo, 8 personal aggregated alert

local thunderingTotal = 0

local function yellRepeater(self, text, total)
	total = total + 1
	if total < 7 then
		yellThundering:Yell(text)
		self:Schedule(1.5, yellRepeater, self, text, total)
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 240446 and self:AntiSpam(3, 6) then
		warnExplosion:Show()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 373370 then
		timerNightmareCloudCD:Start(30.5, args.sourceGUID)
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 240447 then
		if args:IsPlayer() then
			specWarnQuake:Show()
			specWarnQuake:Play("range5")
		end
	elseif spellId == 226512 and args:IsPlayer() and self:AntiSpam(3, 7) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 350209 and args:IsPlayer() and self:AntiSpam(3, 8) then
		specWarnSpitefulFixate:Show()
		specWarnSpitefulFixate:Play("targetyou")
	elseif spellId == 396369 then
		if self:AntiSpam(30, 1) then
			thunderingTotal = 0
		end
		thunderingTotal = thunderingTotal + 1
		if args:IsPlayer() then
			specWarnPositiveCharge:Show()
			specWarnPositiveCharge:Play("positive")
			timerPositiveCharge:Start()
			self:Unschedule(yellRepeater)
			local formatedIcon = DBM_CORE_L.AUTO_YELL_CUSTOM_POSITION:format(6, "")
			yellRepeater(self, formatedIcon, 0)
			yellThunderingFades:Yell(15, 5, 6)--Start icon spam with count at 5 remaining
		end
	elseif spellId == 396364 then
		if self:AntiSpam(30, 1) then
			thunderingTotal = 0
		end
		thunderingTotal = thunderingTotal + 1
		if args:IsPlayer() then
			specWarnNegativeCharge:Show()
			specWarnNegativeCharge:Play("negative")
			timerNegativeCharge:Start()
			self:Unschedule(yellRepeater)
			local formatedIcon = DBM_CORE_L.AUTO_YELL_CUSTOM_POSITION:format(7, "")
			yellRepeater(self, formatedIcon, 0)
			yellThunderingFades:Yell(15, 5, 7)--Start icon spam with count at 5 remaining
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 396369 or spellId == 396364 then
		thunderingTotal = thunderingTotal - 1
		if args:IsPlayer() or thunderingTotal <= 1 then
			warnThunderingFades:Show()
			timerPositiveCharge:Stop()
			timerNegativeCharge:Stop()
			self:Unschedule(yellRepeater)
			yellThunderingFades:Cancel()
			yellThundering:Yell(DBM_COMMON_L.CLEAR)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 209862 and destGUID == UnitGUID("player") and self:AntiSpam(3, 7) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 190128 then

	elseif cid == 189878 then

	end
end
--]]
