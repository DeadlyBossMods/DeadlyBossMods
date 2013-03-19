local mod	= DBM:NewMod(829, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68905, 68904)--Lu'lin 68905, Suen 68904
mod:SetModelID(46975)--Lu'lin, 46974 Suen

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local Lulin = EJ_GetSectionInfo(7629)
local Suen = EJ_GetSectionInfo(7642)

mod:SetBossHealthInfo(
	68905, Lulin,
	68904, Suen
)

--Darkness
local warnNight							= mod:NewAnnounce("warnNight", 1, 108558)
local warnCosmicBarrage					= mod:NewSpellAnnounce(136752, 2)
local warnTearsOfSun					= mod:NewSpellAnnounce(137404, 3)
local warnBeastOfNightmares				= mod:NewTargetAnnounce(137375, 3, nil, mod:IsTank() or mod:IsHealer())
--Light
local warnDay							= mod:NewAnnounce("warnDay", 1, 122789)
local warnLightOfDay					= mod:NewSpellAnnounce(137403, 2, nil, false)--Spammy, but leave it as an option at least
local warnFanOfFlames					= mod:NewStackAnnounce(137408, 2, nil, mod:IsTank() or mod:IsHealer())
local warnFlamesOfPassion				= mod:NewSpellAnnounce(137414, 3)--Todo, check target scanning
local warnIceComet						= mod:NewSpellAnnounce(137419, 2)
local warnNuclearInferno				= mod:NewCastAnnounce(137491, 4)--Heroic
--Dusk
local warnDusk							= mod:NewAnnounce("warnDusk", 1, "Interface\\Icons\\achievement_zone_easternplaguelands")--"achievement_zone_easternplaguelands" (best Dusk icon i could find)
local warnTidalForce					= mod:NewCastAnnounce(137531, 3)

--Darkness
local specWarnCosmicBarrage				= mod:NewSpecialWarningSpell(136752, false, nil, nil, 2)
local specWarnTearsOfSun				= mod:NewSpecialWarningSpell(137404, nil, nil, nil, 2)
local specWarnBeastOfNightmares			= mod:NewSpecialWarningSpell(137375, mod:IsTank())
--Light
local specWarnFanOfFlames				= mod:NewSpecialWarningStack(137408, mod:IsTank(), 2)
local specWarnFanOfFlamesOther			= mod:NewSpecialWarningTarget(137408, mod:IsTank())
local specWarnIceComet					= mod:NewSpecialWarningSpell(137419, false)
local specWarnNuclearInferno			= mod:NewSpecialWarningSpell(137491, nil, nil, nil, 2)--Heroic
--Dusk
local specWarnTidalForce				= mod:NewSpecialWarningSpell(137531, nil, nil, nil, 2)--Maybe switch to a stop dps warning, or a switch to Suen?

--Darkness
--Light of Day (137403) has a HIGHLY variable cd variation, every 6-14 seconds. Not to mention it requires using SPELL_DAMAGE and SPELL_MISSED. for now i'm excluding it on purpose
local timerDayCD						= mod:NewTimer(183, "timerDayCD", 122789) -- timer is 183 or 190 (confirmed in 10 man. variable)
local timerCosmicBarrageCD				= mod:NewCDTimer(23, 136752)
local timerTearsOfTheSunCD				= mod:NewCDTimer(40, 137404)
local timerBeastOfNightmaresCD			= mod:NewCDTimer(50, 137375)
--Light
local timerDuskCD						= mod:NewTimer(360, "timerDuskCD", "Interface\\Icons\\achievement_zone_easternplaguelands")--it seems always 360s after combat entered. (day timer is variables, so not reliable to day phase)
local timerLightOfDayCD					= mod:NewCDTimer(6, 137403, nil, false)--Trackable in day phase using UNIT event since boss1 can be used in this phase. Might be useful for heroic to not run behind in shadows too early preparing for a special
local timerFanOfFlamesCD				= mod:NewNextTimer(12, 137408, nil, mod:IsTank() or mod:IsHealer())
local timerFanOfFlames					= mod:NewTargetTimer(30, 137408, nil, mod:IsTank())
local timerFlamesOfPassionCD			= mod:NewCDTimer(30, 137414)
local timerIceCometCD					= mod:NewCDTimer(19, 137419)--Every 19-25 seconds on normal. On heroic it's every 15 seconds almost precisely (i suspect heroic gets them more often to ensure RNG doesn't wipe you to Nuclear Inferno)
local timerNuclearInfernoCD				= mod:NewCDTimer(55.5, 137491)
--Dusk
local timerTidalForce					= mod:NewBuffActiveTimer(18 ,137531)
local timerTidalForceCD					= mod:NewCDTimer(74, 137531)

local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddBoolOption("RangeFrame")--For various abilities that target even melee. UPDATE, cosmic barrage (worst of the 3 abilities) no longer target melee. However, light of day and tears of teh sun still do. melee want to split into 2-3 groups (depending on how many) but no longer have to stupidly spread about all crazy and out of range of boss during cosmic barrage to avoid dying. On that note, MAYBE change this to ranged default instead of all.

local phase3started = false

function mod:OnCombatStart(delay)
	local phase3started = false
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(137491) then
		self:SendSync("Inferno")
	elseif args:IsSpellID(137531) then
		self:SendSync("TidalForce")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(136752) then
		self:SendSync("CosmicBarrage")
	elseif args:IsSpellID(137404) then
		warnTearsOfSun:Show()
		specWarnTearsOfSun:Show()
		if timerDayCD:GetTime() < 145 then
			timerTearsOfTheSunCD:Start()
		end
	elseif args:IsSpellID(137375) then
		warnBeastOfNightmares:Show(args.destName)
		specWarnBeastOfNightmares:Show()
		if timerDayCD:GetTime() < 135 then
			timerBeastOfNightmaresCD:Start()
		end
	elseif args:IsSpellID(137408) then
		warnFanOfFlames:Show(args.destName, args.amount or 1)
		timerFanOfFlames:Start(args.destName)
		timerFanOfFlamesCD:Start()
		if args:IsPlayer() then
			if (args.amount or 1) >= 2 then
				specWarnFanOfFlames:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 1 and not UnitDebuff("player", GetSpellInfo(137408)) and not UnitIsDeadOrGhost("player") then
				specWarnFanOfFlamesOther:Show(args.destName)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(137408) then
		timerFanOfFlames:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(137414) then
		warnFlamesOfPassion:Show()
		timerFlamesOfPassionCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(137419) then
		warnIceComet:Show()
		specWarnIceComet:Show()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerIceCometCD:Start(15)
		else
			timerIceCometCD:Start()
		end
	end
end

--If this turns out unreliable, we can switch to yell, which is why I want it localized for now, in case it IS needed
--If we do switch to yell, we'll still want to delay it by 6 seconds since timers don't actually cancel until port in (ie she may cast another fan of flames for example
--"<333.5 18:37:56> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Lu'lin! Lend me your strength!#Suen#####0#0##0#247#nil#0#false#false", -- [71265]
--"<339.3 18:38:02> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Suen#0xF1310D2800005863#worldboss#410952978#nil#1#Unknown#0xF1310D2900005864#worldboss#310232488
function mod:CHAT_MSG_MONSTER_YELL(msg) -- Switch to yell. INSTANCE_ENCOUNTER_ENGAGE_UNIT fires too late. also yell ranage covers all rooms. Not need sync.
	if (msg == L.DuskPhase or msg:find(L.DuskPhase)) then
		self:SendSync("Phase3Yell")
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event) -- still remains backup trigger for phase3.
	if UnitExists("boss2") and tonumber(UnitGUID("boss2"):sub(6, 10), 16) == 68905 then--Make sure we don't trigger it off another engage such as wipe engage event
		self:SendSync("Phase3")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68905 then--Lu'lin
		timerCosmicBarrageCD:Cancel()
		timerTidalForceCD:Cancel()
		timerLightOfDayCD:Start()
		timerFanOfFlamesCD:Start(19)
		--She also does Flames of passion, but this is done 3 seconds after Lu'lin dies, is a 3 second timer worth it?
	elseif cid == 68904 then--Suen
		timerFlamesOfPassionCD:Cancel()
--		timerBeastOfNightmaresCD:Start()--My group kills Lu'lin first. Need log of Suen being killed first to get first beast timer value
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 137105 and self:AntiSpam(2, 1) then--Suen Ports away (Night Phase)
		timerLightOfDayCD:Cancel()
		timerFanOfFlamesCD:Cancel()
		timerFlamesOfPassionCD:Cancel()
		warnNight:Show()
		timerDayCD:Start()
		timerDuskCD:Start()
		timerCosmicBarrageCD:Start(17)
		timerTearsOfTheSunCD:Start(23)
		timerBeastOfNightmaresCD:Start()
	elseif spellId == 137187 and self:AntiSpam(2, 2) then--Lu'lin Ports away (Day Phase)
		self:SendSync("Phase2")
	elseif spellId == 138823 and self:AntiSpam(2, 3) then
		warnLightOfDay:Show()
		timerLightOfDayCD:Start()
	end
end

function mod:OnSync(msg)
	if msg == "Phase2" then
		timerCosmicBarrageCD:Cancel()
		timerTearsOfTheSunCD:Cancel()
		timerBeastOfNightmaresCD:Cancel()
		warnDay:Show()
		timerLightOfDayCD:Start()
		timerFanOfFlamesCD:Start()
		timerFlamesOfPassionCD:Start(12.5)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerIceCometCD:Start(15)
			timerNuclearInfernoCD:Start(52)
		else
			timerIceCometCD:Start()
		end
		self:RegisterShortTermEvents(
			"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
		)
	elseif msg == "Phase3Yell" and not phase3Started then -- Split from phase3 sync to prevent who running older version not to show bad timers.
		phase3Started = true
		self:UnregisterShortTermEvents()
		warnDusk:Show()
		timerFanOfFlamesCD:Cancel()
		timerIceCometCD:Start(17)--This seems to reset, despite what last CD was (this can be a bad thing if it was do any second)
		timerTidalForceCD:Start(26)
		timerCosmicBarrageCD:Start(54)
	elseif msg == "Phase3" and not phase3Started then
		phase3Started = true
		self:UnregisterShortTermEvents()
		warnDusk:Show()
		timerFanOfFlamesCD:Cancel()
		timerIceCometCD:Start(11)--This seems to reset, despite what last CD was (this can be a bad thing if it was do any second)
		timerTidalForceCD:Start(20)
		timerCosmicBarrageCD:Start(48)
	elseif msg == "TidalForce" then
		warnTidalForce:Show()
		specWarnTidalForce:Show()
		timerTidalForce:Start()
		timerTidalForceCD:Start()
	elseif msg == "CosmicBarrage" then
		warnCosmicBarrage:Show()
		specWarnCosmicBarrage:Show()
		if timerDayCD:GetTime() < 165 then
			timerCosmicBarrageCD:Start()
		end
	elseif msg == "Inferno" then
		warnNuclearInferno:Show()
		specWarnNuclearInferno:Show()
		timerNuclearInfernoCD:Start()
	end
end
