local mod	= DBM:NewMod("Conclave", "DBM-ThroneFourWinds", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(45870, 45871, 45872)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_POWER",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnNurture			= mod:NewSpellAnnounce(85422, 3)
local warnSoothingBreeze	= mod:NewSpellAnnounce(86207, 3)	-- using a spellID here with a better description of the spell
local warnSummonTornados	= mod:NewSpellAnnounce(86192, 3)
local warnWindBlast			= mod:NewSpellAnnounce(86193, 3)
local warnStormShield		= mod:NewSpellAnnounce(95865, 3)
local warnPoisonToxic	 	= mod:NewSpellAnnounce(86281, 3)
local warnGatherStrength	= mod:NewTargetAnnounce(86307, 4)
local warnSpecial			= mod:NewAnnounce("warnSpecial", 3, "Interface\\Icons\\INV_Enchant_EssenceMagicLarge")--Hurricane/Sleet Storm/Zephyr in single announce

local specWarnSpecial		= mod:NewSpecialWarning("specWarnSpecial")
local specWarnShield		= mod:NewSpecialWarningSpell(95865)
local specWarnIcePatch      = mod:NewSpecialWarningMove(93131)

local timerNurture			= mod:NewCDTimer(114, 85422)--This does NOT cast at same time as hurricane/sleet storm/Zephyr
local timerWindChill		= mod:NewNextTimer(10.5, 84645)
local timerSlicingGale		= mod:NewBuffActiveTimer(45, 93058)
local timerWindBlast		= mod:NewBuffActiveTimer(10, 86193)
local timerWindBlastCD		= mod:NewCDTimer(60, 86193)-- Cooldown: 1st->2nd = 22sec || 2nd->3rd = 60sec || 3rd->4th = 60sec ?
local timerStormShieldCD	= mod:NewCDTimer(113, 95865)--Heroic ability that Lines up with Nuture it seems.
local timerGatherStrength	= mod:NewTargetTimer(60, 86307)
local timerPoisonToxic		= mod:NewBuffActiveTimer(5, 86281)
local timerPoisonToxicCD	= mod:NewCDTimer(21, 86281)
local timerSpecial			= mod:NewTimer(114, "timerSpecial", "Interface\\Icons\\INV_Enchant_EssenceMagicLarge")--hurricane/Sleet storm/Zephyr share CD
local timerSpecialActive	= mod:NewTimer(16, "timerSpecialActive", "Interface\\Icons\\INV_Enchant_EssenceMagicLarge")

local enrageTimer			= mod:NewBerserkTimer(480) -- Both normal and heroic mode

local windBlastCounter = 0
local specialSpam = 0
local poisonCounter = 0
local poisonSpam = 0
local iceSpam = 0

function mod:OnCombatStart(delay)
	windBlastCounter = 0
	specialSpam = 0
	iceSpam = 0
	timerWindBlastCD:Start(30-delay)
	timerNurture:Start(30-delay)
	timerSpecial:Start(90-delay)--hurricane/Sleet storm share CD
	enrageTimer:Start(-delay)
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		timerStormShieldCD:Start(30-delay)
		timerPoisonToxicCD:Start(51-delay)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93057, 93058) then
		if args:IsPlayer() then
			timerSlicingGale:Start()
		end
	elseif args:IsSpellID(86111, 93129, 93130, 93131) and args:IsPlayer() and GetTime() - iceSpam >= 3 then
		iceSpam = GetTime()
		specWarnIcePatch:Show()
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(86205) then
		warnSoothingBreeze:Show()
	elseif args:IsSpellID(96192) then
		warnSummonTornados:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(85422) then
		warnNurture:Show()
		timerNurture:Start()
	elseif (args:IsSpellID(84644, 93135, 93136, 93137) or args:IsSpellID(84638, 93119, 93118, 93117) or args:IsSpellID(84643)) and GetTime() - specialSpam > 3 then
		warnSpecial:Show()
		specWarnSpecial:Show()
		timerSpecial:Start()
		specialSpam = GetTime()--Trigger it off any of 3 spells, but only once.
		poisonCounter = 0
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerPoisonToxicCD:Start(72)
		end
	elseif args:IsSpellID(93059, 95865) then-- Storm Shield Warning (Heroic mode skill)
		warnStormShield:Show()
		timerStormShieldCD:Start()
		if self:GetUnitCreatureId("target") == 45872 then--only people actually on Rohash
			specWarnShield:Show()
		end
	elseif args:IsSpellID(86281) and GetTime() - poisonSpam > 3 then-- Poison Toxic Warning (at Heroic, Poison Toxic damage is too high, so warning needed)
		poisonSpam = GetTime()
		warnPoisonToxic:Show()
		timerPoisonToxic:Show()
		timerPoisonToxicCD:Start()
		if poisonCounter < 1 then
			poisonCounter = 1
		end
	elseif args:IsSpellID(84645, 93124) then
		timerWindChill:Start()
	elseif args:IsSpellID(86193) then
		windBlastCounter = windBlastCounter + 1
		warnWindBlast:Show()
		timerWindBlast:Start()
		if windBlastCounter == 1 then
			timerWindBlastCD:Start(82)
		else
			timerWindBlastCD:Start()
		end
	end
end

-- Posion Toxic can do casts during stun, so if Poison Toxic cancelled, Next Poision Toxic timer known by boss`s power.
function mod:UNIT_POWER(uId)
	if self:GetUnitCreatureId(uId) == 45870 and UnitPower(uId) == 62 and poisonCounter == 0 and (mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25")) then
		timerPoisonToxicCD:Start(10)
	elseif self:GetUnitCreatureId(uId) == 45870 and UnitPower(uId) == 79 and (mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25")) then
		timerPoisonToxicCD:Cancel()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, boss)
	if (msg == L.gatherstrength or msg:find(L.gatherstrength)) and mod:LatencyCheck() then
		self:SendSync("GatherStrength", boss)
	end
end

function mod:OnSync(msg, boss)
	if msg == "GatherStrength" and self:IsInCombat() then
		warnGatherStrength:Show(boss)
		timerGatherStrength:Start(boss)
	end
end