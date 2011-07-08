local mod	= DBM:NewMod(194, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52530)
mod:SetModelID(38446)
mod:SetZone()
mod:SetUsedIcons()
mod:SetModelSound("Sound\\Creature\\ALYSRAZOR\\VO_FL_ALYSRAZOR_AGGRO.wav", "Sound\\Creature\\ALYSRAZOR\\VO_FL_ALYSRAZOR_TRANSITION_02.wav")
--Long: I serve a new master now, mortals!
--Short: Reborn in Flame!

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_POWER"
)

local warnMolting		= mod:NewSpellAnnounce(99464, 3)
local warnFirestorm		= mod:NewSpellAnnounce(100744, 3)
local warnCataclysm		= mod:NewCastAnnounce(102111, 4)
local warnPhase			= mod:NewAnnounce("WarnPhase", 3)
local warnNewInitiate	= mod:NewAnnounce("WarnNewInitiate", 3)

local specWarnFieroblast		= mod:NewSpecialWarningInterrupt(101223)
local specWarnGushingWoundSelf	= mod:NewSpecialWarningYou(99308, false)
local specWarnTantrum			= mod:NewSpecialWarningSpell(99362, mod:IsTank())
local specWarnGushingWoundOther	= mod:NewSpecialWarningTarget(99308, false)

local timerMoltingCD		= mod:NewNextTimer(60, 99464)
local timerCataclysm		= mod:NewCastTimer(5, 102111)
local timerPhaseChange		= mod:NewTimer(30, "TimerPhaseChange", 99816)
local timerHatchEggs		= mod:NewTimer(50, "TimerHatchEggs", 42471)
local timerNextInitiate		= mod:NewTimer(32, "timerNextInitiate", 61131)

mod:AddBoolOption("InfoFrame", false)--Why is this useful?

local phase = 1
local initiatesSpawned = 0

function mod:OnCombatStart(delay)
	timerMoltingCD:Start(10-delay)
	timerHatchEggs:Start(50-delay)
	timerNextInitiate:Start(27-delay)
	phase = 1
	initiatesSpawned = 0
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.PowerLevel)
		DBM.InfoFrame:Show(5, "playerpower", 10, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99362) and (args.sourceGUID == UnitGUID("target") and mod:IsTank()) or not mod:IsTank() then--Only give tantrum warning if it's mob you're targeting and you're a tank, else, always give tantrum warning regardless of target
		specWarnTantrum:Show()
	elseif args:IsSpellID(99308) then--Gushing Wound
		specWarnGushingWoundOther:Show(args.destName)
		if args:IsPlayer() then
			specWarnGushingWoundSelf:Show()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(101223, 101294, 101295, 101296) then
		if args.sourceGUID == UnitGUID("target") then
			specWarnFieroblast:Show()
		end
	elseif args:IsSpellID(102111, 100761) then
		warnCataclysm:Show()
		timerCataclysm:Start()
	elseif args:IsSpellID(100744) then
		warnFirestorm:Show()
--[[
wowhead says: 10sec duration
Cast start 	21:36:02.777
aura applied	21:36:07.778
aura removed	21:36:11.321
--]]
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99464, 100698, 100836, 100837) then	--99464, 100698 confirmed
		warnMolting:Show()
		timerMoltingCD:Start()
		if phase ~= 1 then
			phase = 1
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		warnPhase:Show(2)
		timerMoltingCD:Cancel()
		timerPhaseChange:Start(30, 3)
		phase = 2
		initiatesSpawned = 0
	--Yes it's ugly, but least prone to failure. May make something more complex using spell_cast_start from CID with unique GUID's, but that'd still be 0.1 seconds slower since they yell before they cast their first spell.
	elseif msg == L.YellInitiate1 or msg:find(L.YellInitiate1) or msg == L.YellInitiate2 or msg:find(L.YellInitiate2) or msg == L.YellInitiate3 or msg:find(L.YellInitiate3) or msg == L.YellInitiate4 or msg:find(L.YellInitiate4) then
		initiatesSpawned = initiatesSpawned + 1
		warnNewInitiate:Show(initiatesSpawned)
		if initiatesSpawned == 6 then return end--All 6 are spawned, lets not create any timers.
		if initiatesSpawned < 3 then
			timerNextInitiate:Start(32)--Might tune this slightly to be for when you see them fly in, since the yell happens when they land and are attackable
		else
			timerNextInitiate:Start(20)--Might tune this slightly to be for when you see them fly in, since the yell happens when they land and are attackable
		end
	end
end

function mod:UNIT_POWER(uId)
	if uId == "boss1" then
		local p = UnitPower(uId, ALTERNATE_POWER_INDEX) / UnitPowerMax(uId, ALTERNATE_POWER_INDEX) * 100
		if p == 0 then		-- Seems to drop instantly from 100 -> 0
			warnPhase:Show(3)
			phase = 3
		elseif phase == 3 and p >= 50 then
			warnPhase:Show(4)
			phase = 4
		elseif phase == 4 and p == 100 then
			timerHatchEggs:Start(38)
			warnPhase:Show(1)
			phase = 1
		end
	end
end