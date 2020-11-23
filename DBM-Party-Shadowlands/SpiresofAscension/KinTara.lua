local mod	= DBM:NewMod(2399, "DBM-Party-Shadowlands", 5, 1186)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162059, 163077)--162059 Kin-Tara, 163077 Azules
mod:SetEncounterID(2357)
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 320966 327481 317623",
	"SPELL_CAST_SUCCESS 323636",
	"SPELL_AURA_APPLIED 323828",
	"SPELL_PERIODIC_DAMAGE 317626",
	"SPELL_PERIODIC_MISSED 317626",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE"
--	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, Verify new and improved flight detection
--TODO, the entire enrage mechanic seems to be gone? All logs havev bosses die together and none of enraged abilities ever used
--[[
(ability.id = 321009 or ability.id = 320966 or ability.id = 317623) and type = "begincast"
 or ability.id = 323636 and type = "cast"
 or ability.id = 323828 or ability.id = 331249
 or (target.id = 162059 or target.id = 163077 or target.id = 174212) and type = "death"
 or (ability.id = 324368 or ability.id = 317661) and type = "begincast"
--]]
--Kin-Tara
local warnChargedSpear				= mod:NewTargetNoFilterAnnounce(321009, 4)

--Kin-Tara
local specWarnOverheadSlash			= mod:NewSpecialWarningSoak(320866, "Tank", nil, nil, 1, 2)
local specWarnDarkLance				= mod:NewSpecialWarningInterrupt(327481, "HasInterrupt", nil, nil, 1, 2)
local specWarnChargedSpear			= mod:NewSpecialWarningMoveAway(321009, nil, nil, nil, 1, 2)
local yellChargedSpear				= mod:NewYell(321009)
local specWarnChargedSpearNear		= mod:NewSpecialWarningClose(321009, nil, nil, nil, 1, 2)
--Azules
local specWarnGTFO					= mod:NewSpecialWarningGTFO(317626, nil, nil, nil, 1, 8)

--Kin-Tara
local KinTara = DBM:EJ_GetSectionInfo(21637)
mod:AddTimerLine(KinTara)
local timerOverheadSlashCD			= mod:NewCDTimer(8.5, 320866, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)--8.5-11
local timerFlightCD					= mod:NewCDTimer(145, 313606, nil, nil, nil, 6)
local timerChargedSpearCD			= mod:NewCDTimer(15.8, 321009, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
--Azules
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21639))
local timerInsidiousVenomCD			= mod:NewCDTimer(11.4, 317661, nil, nil, nil, 2)
local timerMawTouchedVenomCD		= mod:NewCDTimer(15.8, 317655, nil, nil, nil, 3)

mod.vb.Enraged = false
mod.vb.flightActive = false
mod.vb.spearCount = 0

function mod:OnCombatStart(delay)
	self.vb.Enraged = false
	self.vb.spearCount = 0
	self.vb.flightActive = false
	--Kin-Tara
	timerOverheadSlashCD:Start(8.5-delay)
	timerFlightCD:Start(30.5-delay)
	DBM:AddMsg("Note, Kin-Tara flight detection on this is using experimental code, report if phase change detection doesn't look functional")
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320966 then
		if self.vb.flightActive then
			self.vb.flightActive = false
			self:UnregisterShortTermEvents()
		end
		specWarnOverheadSlash:Show()--Will be moved to fire earlier with timers
		specWarnOverheadSlash:Play("gathershare")
		timerOverheadSlashCD:Start()
	elseif spellId == 327481 then
		if self.vb.flightActive then
			self.vb.flightActive = false
			self:UnregisterShortTermEvents()
		end
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDarkLance:Show(args.sourceName)
			specWarnDarkLance:Play("kickcast")
		end
--	elseif spellId == 317623 then
--		timerMawTouchedVenomCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 323636 then
		timerInsidiousVenomCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 323828 and not self.vb.Enraged then
		self.vb.Enraged = true--Enraged will fire again when 2nd one dies, even though it's a win, don't want to fire alerts/timers on combat end
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 163077 or cid == 174212 then--Azules/Azoras
			timerInsidiousVenomCD:Start(3)
			timerMawTouchedVenomCD:Start(8.4)
		elseif cid == 162059 then--Kin-Tara
			self.vb.spearCount = 0
			timerChargedSpearCD:Stop()
			timerOverheadSlashCD:Stop()
			timerOverheadSlashCD:Start(4.5)
			timerChargedSpearCD:Start(8, 1)
		end
	end
end

--Yell possibly using bosses name possible, or yell using string, and on mythic and above deep connection can be used foor flight detection
--"<246.11 02:57:42> [CHAT_MSG_MONSTER_YELL] Your doom takes flight!#Kin-Tara###Kin-Tara##0#0##0#251#nil#0#false#false#false#false", -- [2110]
--"<227.02 19:43:08> [CLEU] SPELL_AURA_REMOVED#Creature-0-2085-2285-7016-163077-000026CDCA#Azules#Creature-0-2085-2285-7016-162059-000026CDCA#Kin-Tara#331249#Deep Connection#DEBUFF#nil", -- [2470]
--"<227.24 19:43:08> [CHAT_MSG_MONSTER_YELL] Fear the skies!#Kin-Tara###Kin-Tara##0#0##0#67#nil#0#false#false#false#false", -- [2475]
function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, targetname)
	if targetname == KinTara then--I believe only time she target herself in a yell is flight yell
--	if msg == L.Flight or msg:find(L.Flight) or msg == L.Flight2 or msg:find(L.Flight2) then--Backup solution ready to apply if more data reveals she can yell at herself other times
--		self:SendSync("Flight")
		self.vb.flightActive = true
		self.vb.spearCount = 0
		timerOverheadSlashCD:Stop()
		timerChargedSpearCD:Stop()
		timerChargedSpearCD:Start(3.6, 1)
		--Only reliable way to detect air phase ending on non mythic
		--Mythic can use Deep Connection but this mod has to encompass normal/heroic as well
		self:RegisterShortTermEvents(
			"UNIT_POWER_UPDATE boss1"
		)
	end
end

--[[
function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "Flight" then
		self.vb.flightActive = true
		self.vb.spearCount = 0
		timerOverheadSlashCD:Stop()
		timerChargedSpearCD:Stop()
		timerChargedSpearCD:Start(3.6, 1)
		--Only reliable way to detect air phase ending on non mythic
		--Mythic can use Deep Connection but this mod has to encompass normal/heroic as well
		self:RegisterShortTermEvents(
			"UNIT_POWER_UPDATE boss1"
		)
	end
end
--]]

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetname)
	if msg:find("spell:321009") then
		self.vb.spearCount = self.vb.spearCount + 1
		if self.vb.flightActive then
			if self.vb.spearCount == 1 then
				timerChargedSpearCD:Start(11, 2)
			elseif self.vb.Enraged then--Boss will still cast it when landing
				timerChargedSpearCD:Start(46.1, 1)
			end
		else--Casting it when on ground because enraged
			timerChargedSpearCD:Start(23.1, self.vb.spearCount+1)
		end
		if targetname == UnitName("player") then
			specWarnChargedSpear:Show()
			specWarnChargedSpear:Play("runout")
			yellChargedSpear:Yell()
		elseif self:CheckNearby(5, targetname) then
			specWarnChargedSpearNear:Show(targetname)
			specWarnChargedSpearNear:Play("runaway")
		else
			warnChargedSpear:Show(targetname)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 317626 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 163077 or cid == 174212 then--Azules/Azoras
		timerInsidiousVenomCD:Stop()
		timerMawTouchedVenomCD:Stop()
	elseif cid == 162059 then--Kin-Tara
		timerOverheadSlashCD:Stop()
		timerFlightCD:Stop()
		timerChargedSpearCD:Stop()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 321088 then--Charged Spear
--		timerChargedSpearCD:Start()
	end
end
--]]

function mod:UNIT_POWER_UPDATE()
	local bossPower = UnitPower("boss1")--Get Boss Power
	if self.vb.flightActive and bossPower == 0 then--Boss does a hard energy reset to 0 when she lands (flight phase ends)
		self.vb.flightActive = false
		self:UnregisterShortTermEvents()
		timerOverheadSlashCD:Start(8.4-delay)
		timerFlightCD:Start(30.4-delay)
	end
end
