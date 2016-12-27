local mod	= DBM:NewMod(1789, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(110378)
mod:SetEncounterID(1949)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 219542 219493",
	"SPELL_CAST_SUCCESS 219601",
	"SPELL_AURA_APPLIED 219602",
	"SPELL_AURA_REMOVED 219602"
)

--TODO, verify target scanning on avalanche
--TODO, ice hurl? it has no role assignment in journal so it may just be what he spams on tank
local warnAvalanche				= mod:NewTargetAnnounce(219542, 3)
local warnSnowPlow				= mod:NewTargetAnnounce(219602, 4)

local specWarnAvalanche			= mod:NewSpecialWarningYou(219542, nil, nil, nil, 1, 2)
local yellAvalanche				= mod:NewYell(219542)
local specWarnSnowCrash			= mod:NewSpecialWarningDodge(219493, "Melee", nil, nil, 4, 2)
local specWarnSnowPlow			= mod:NewSpecialWarningRun(219602, nil, nil, nil, 4, 2)
local specWarnSnowPlowOver		= mod:NewSpecialWarningFades(219602, nil, nil, nil, 1, 2)

local timerAvalancheCD			= mod:NewCDTimer(42.6, 219542, nil, nil, nil, 3)--May need larger sample, was quite variable
local timerSnowCrashCD			= mod:NewCDTimer(19.4, 219493, nil, "Melee", nil, 2)--Seems to alternate 19.4 and 23.2 but world bosses can't be this complicated since they are often engaged in progress
local timerSnowPlowCD			= mod:NewCDTimer(47.4, 219602, nil, nil, nil, 3)

local voiceAvalanche			= mod:NewVoice(219542)--runaway
local voiceSnowCrash			= mod:NewVoice(219493)--shockwave
local voiceSnowPlow				= mod:NewVoice(219602)--runaway/keepmove/safenow

mod:AddReadyCheckOption(43448, false)

function mod:AvaTarget(targetname, uId)
	if not targetname then
		warnAvalanche:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		specWarnAvalanche:Show()
		voiceAvalanche:Play("runaway")
		yellAvalanche:Yell()
	else
		warnAvalanche:Show(targetname)
	end
end

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 219542 then
		timerAvalancheCD:Start()
		self:BossTargetScanner(args.sourceGUID, "AvaTarget", 0.2, 9)
	elseif spellId == 219493 then
		specWarnSnowCrash:Show()
		voiceSnowCrash:Play("shockwave")
		timerSnowCrashCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 219601 then
		timerSnowPlowCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 219602 and args:IsDestTypePlayer() then
		if args:IsPlayer() then
			specWarnSnowPlow:Show()
			voiceSnowPlow:Play("runaway")
			voiceSnowPlow:Schedule(1, "keepmove")
		else
			warnSnowPlow:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 219602 and args:IsPlayer() then
		specWarnSnowPlowOver:Show()
		voiceSnowPlow:Play("safenow")
	end
end
