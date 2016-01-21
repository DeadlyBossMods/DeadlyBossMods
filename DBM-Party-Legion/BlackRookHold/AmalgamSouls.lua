local mod	= DBM:NewMod(1518, "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(98542)
mod:SetEncounterID(1832)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 194966",
	"SPELL_CAST_START 195254 194966 194956",
	"CHAT_MSG_MONSTER_YELL"
)

local warnSwirlingScythe			= mod:NewTargetAnnounce(195254, 2)
local warnSoulEchoes				= mod:NewTargetAnnounce(194966, 2)

local specWarnReapSoul				= mod:NewSpecialWarningDodge(194956, "Tank", nil, nil, 3)
local specWarnSoulEchos				= mod:NewSpecialWarningRun(194966, nil, nil, nil, 1, 2)
local specWarnSwirlingScythe		= mod:NewSpecialWarningDodge(195254, nil, nil, nil, 1, 2)
local yellSwirlingScythe			= mod:NewYell(195254)

local timerSwirlingScytheCD			= mod:NewCDTimer(20.5, 195254, nil, nil, nil, 3)--20-27
local timerSoulEchoesCD				= mod:NewNextTimer(27.5, 194966, nil, nil, nil, 3)
local timerReapSoulCD				= mod:NewNextTimer(13, 194956, nil, nil, nil, 5)

local voiceSwirlingScythe			= mod:NewVoice(195254)
local voiceSoulEchos				= mod:NewVoice(194966)

--mod:AddRangeFrameOption(5, 194966)

function mod:ScytheTarget(targetname, uId)
	if not targetname then
		warnSwirlingScythe:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		specWarnSwirlingScythe:Show()
		voiceSwirlingScythe:Play("runaway")
		yellSwirlingScythe:Yell()
	else
		warnSwirlingScythe:Show(targetname)
	end
end

function mod:SoulTarget(targetname, uId)
	if not targetname then
		warnSoulEchoes:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		specWarnSoulEchos:Show()
		voiceSoulEchos:Play("runaway")
		voiceSoulEchos:Schedule(1, "keepmove")
	else
		warnSoulEchoes:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerSwirlingScytheCD:Start(8-delay)
	timerSoulEchoesCD:Start(16-delay)
	timerReapSoulCD:Start(20-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 and self:AntiSpam(3, 1) then--Secondary Soul echos warning that's 2 seconds slower than yell trickory
		warnSoulEchoes:Show(args.destName)
		if args:IsPlayer() then
			specWarnSoulEchos:Show()
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 195254 then
		timerSwirlingScytheCD:Start()
		self:BossTargetScanner(98542, "ScytheTarget", 0.1, 20, true, nil, nil, nil, true)
	elseif spellId == 194966 then
		timerSoulEchoesCD:Start()
		self:BossTargetScanner(98542, "SoulTarget", 0.1, 20, true, nil, nil, nil, true)
	elseif spellId == 194956 then
		specWarnReapSoul:Show()
		timerReapSoulCD:Start()
	end
end
