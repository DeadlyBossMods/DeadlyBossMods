local mod	= DBM:NewMod(1878, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(120793)
mod:SetEncounterID(2039)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 233155 233206 234817 233963",
	"SPELL_AURA_REMOVED 233206",
	"UNIT_AURA_UNFILTERED",
	"UNIT_SPELLCAST_SUCCEEDED"--All available unitIDs, no bossN for shadows
)

--TODO: Can tank dodge swarm once cast starts?
--TODO, shadowfade ending and initial timers post shadow phase
--TODO, verify if more debuff spellids for Demonic Upheavel than one. determine if best place to do timer
--TODO, shadow of mephistro spawn warnings, probably 234034
--TODO, phases for mephisto
--TODO, announce who grabs shield on mephisto
--TODO, announce circles spawning on ground (watch step) on mephisto
local warnDarkSolitude				= mod:NewSpellAnnounce(234817, 2)--Can't target scan so general announce
local warnShadowFade				= mod:NewSpellAnnounce(233206, 2)
local warnShadowFadeEnded			= mod:NewEndAnnounce(233206, 2)
local warnDemonicUpheaval			= mod:NewTargetAnnounce(233963, 3)
local warnShadowAdd					= mod:NewSpellAnnounce("ej14965", 2, 233206)

local specWarnCarrionSwarm			= mod:NewSpecialWarningSpell(233155, "Tank", nil, nil, 1, 2)
local specWarnDemonicUpheaval		= mod:NewSpecialWarningMoveAway(233963, nil, nil, nil, 1, 2)
local yellDemonicUpheaval			= mod:NewYell(233963)

local timerDarkSolitudeCD			= mod:NewCDTimer(8.5, 234817, nil, nil, nil, 3)
local timerCarrionSwarmCD			= mod:NewCDTimer(18, 233155, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDemonicUpheavalCD		= mod:NewCDTimer(32, 233963, nil, nil, nil, 3)--32-35
local timerShadowFadeCD				= mod:NewCDTimer(40, 233206, nil, nil, nil, 6)

local voiceCarrionSwarm				= mod:NewVoice(233155, "Tank")--shockwave
local voiceDemonicUpheaval			= mod:NewVoice(233963)--runout

mod:AddRangeFrameOption(8, 234817)--5 yards probably too small, next lowest range on crap api is 8
mod:AddInfoFrameOption(234217, true)

local demonicUpheaval = GetSpellInfo(233963)
local demonicUpheavalTable = {}
local addsTable = {}

function mod:OnCombatStart(delay)
	table.wipe(addsTable)
	timerDemonicUpheavalCD:Start(3.2-delay)--Cast Start
	timerDarkSolitudeCD:Start(8.1-delay)
	timerCarrionSwarmCD:Start(15-delay)
	timerShadowFadeCD:Start(40-delay)--Cast Start
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 233155 then
		specWarnCarrionSwarm:Show()
		voiceCarrionSwarm:Play("shockwave")
		timerCarrionSwarmCD:Start()
	elseif spellId == 233206 then--Shadow Fade
		warnShadowFade:Show()
		timerCarrionSwarmCD:Stop()
		timerDarkSolitudeCD:Stop()
		timerDemonicUpheavalCD:Stop()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 234817 then
		warnDarkSolitude:Show()
		timerDarkSolitudeCD:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(234217))
			DBM.InfoFrame:Show(2, "enemypower", 2, ALTERNATE_POWER_INDEX)
		end
	elseif spellId == 233963 then
		timerDemonicUpheavalCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 233206 then--Shadow Fade
		warnShadowFadeEnded:Show()
		timerDemonicUpheavalCD:Start(3)--3 for cast start 6 for cast finish, decide which one want to use still
		timerDarkSolitudeCD:Start(7.5)
		timerCarrionSwarmCD:Start(15)
		--timerShadowFadeCD:Start(40)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end

function mod:UNIT_AURA_UNFILTERED(uId)
	local hasDebuff = UnitDebuff(uId, demonicUpheaval)
	local name = DBM:GetUnitFullName(uId)
	if not hasDebuff and demonicUpheavalTable[name] then
		demonicUpheavalTable[name] = nil
	elseif hasDebuff and not demonicUpheavalTable[name] then
		demonicUpheavalTable[name] = true
		warnDemonicUpheaval:CombinedShow(0.5, name)--Multiple targets in mythic
		if UnitIsUnit(uId, "player") then
			specWarnDemonicUpheaval:Show()
			voiceDemonicUpheaval:Play("runout")
			yellDemonicUpheaval:Yell()
		end
	end
end

--TODO, syncing maybe do to size and spread in room, not all nameplates will be caught by one person
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID, spellId)
	--"<51.81 19:21:30> [UNIT_SPELLCAST_SUCCEEDED] Unknown(??) [[nameplate1:Shadow of Mephistroth Cosmetic::3-3020-1677-21626-234034-00025D92FA:234034]]", -- [308]
	if spellId == 234034 then--Only will trigger if nameplate is in range
		local guid = UnitGUID(uId)
		if not addsTable[guid] then
			addsTable[guid] = true
			warnShadowAdd:Show()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 192800 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 1) then
		specWarnGas:Show()
		voiceGas:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]
