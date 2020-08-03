local mod	= DBM:NewMod(2429, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(165066)
mod:SetEncounterID(2418)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20200730000000)--2020, 7, 30
mod:SetMinSyncRevision(20200730000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 335114 334404 334971 334797 334757 334852",
	"SPELL_CAST_SUCCESS 334945 334797",
	"SPELL_AURA_APPLIED 334971 334860 334945 334852 335111 335112 335113",
	"SPELL_AURA_APPLIED_DOSE 334971 334860",
	"SPELL_AURA_REMOVED 334945 334860 334852 335111 335112 335113",
	"SPELL_AURA_REMOVED_DOSE 334860",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"RAID_BOSS_WHISPER"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, handling of mythic Sinseeker buffs by detecting which hound buffs it currently has (by using phase probably)
--TODO, energy tracker on nameplates for https://shadowlands.wowhead.com/spell=335303/unyielding
--TODO, watch for final behavior of timers. in first test pulls boss timers changed/reset on dog deaths, on second half of testing, they didn't.
--[[
(ability.id = 335114 or ability.id = 334404 or ability.id = 334971 or ability.id = 334797 or ability.id = 334757 or ability.id = 334852) and type = "begincast"
 or ability.id = 334945 and type = "cast"
 or (target.id = 165067 or target.id = 169457 or target.id = 169458) and type = "death"
--]]
--Huntsman Altimor
local warnSinseeker								= mod:NewTargetNoFilterAnnounce(335114, 4)
local warnSpreadshot							= mod:NewSpellAnnounce(334404, 3)
--Hunting Gargon
----Margore
local warnJaggedClaws							= mod:NewStackAnnounce(334971, 2, nil, "Tank|Healer")
local warnBloodyThrash							= mod:NewTargetNoFilterAnnounce(334945, 3)
----Bargast
local warnCrushingStone							= mod:NewStackAnnounce(334860, 2, nil, "Tank|Healer")
local warnPetrifyingHowl						= mod:NewTargetAnnounce(334852, 3)
----Hecutis

--Huntsman Altimor
local specWarnSinseeker							= mod:NewSpecialWarningYouPos(335114, nil, nil, nil, 3, 2)
local yellSinseeker								= mod:NewPosYell(335114)
local yellSinseekerFades						= mod:NewIconFadesYell(335114)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)
--Hunting Gargon
----Margore
local specWarnJaggedClaws						= mod:NewSpecialWarningStack(334971, nil, 5, nil, nil, 1, 6)
local specWarnJaggedClawsTaunt					= mod:NewSpecialWarningTaunt(334971, nil, nil, nil, 1, 2)
local specWarnBloodThrash						= mod:NewSpecialWarningYou(334945, nil, nil, nil, 3, 2)
local yellBloodThrash							= mod:NewYell(334945, nil, nil, nil, "YELL")
local yellBloodThrashFades						= mod:NewFadesYell(334945, nil, nil, nil, "YELL")
----Bargast
local specWarnRipSoul							= mod:NewSpecialWarningDefensive(334797, nil, nil, nil, 1, 2)
local specWarnRipSoulHealer						= mod:NewSpecialWarningSwitch(334797, "Healer", nil, nil, 1, 2)
local specWarnShadesofBargast					= mod:NewSpecialWarningSwitch(334757, "Dps", nil, nil, 1, 2)
----Hecutis
local specWarnPetrifyingHowl					= mod:NewSpecialWarningMoveAway(334852, nil, nil, nil, 1, 2)
local yellPetrifyingHowl						= mod:NewYell(334852)
local yellPetrifyingHowlFades					= mod:NewFadesYell(334852)

--Huntsman Altimor
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22309))
local timerSinseekerCD							= mod:NewCDCountTimer(49, 335114, nil, nil, nil, 3)
local timerSpreadshotCD							= mod:NewCDTimer(12, 334404, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON)
--Hunting Gargon
----Margore
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22312))
local timerJaggedClawsCD						= mod:NewCDTimer(11, 334971, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--22.1, 23.4, 11.0
local timerBloodyThrashCD						= mod:NewCDTimer(25.7, 334945, nil, nil, nil, 3)
----Bargast
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22311))
local timerRipSoulCD							= mod:NewCDTimer(30.1, 334797, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON..DBM_CORE_L.HEALER_ICON)
local timerShadesofBargastCD					= mod:NewCDTimer(60.1, 334757, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)--60-63 at least
----Hecutis
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22310))
local timerPetrifyingHowlCD						= mod:NewCDTimer(20.6, 334852, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
--mod:AddInfoFrameOption(308377, true)
mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, false, {1, 2, 3})--335111 335112 335113
--mod:AddNamePlateOption("NPAuraOnVolatileCorruption", 312595)

mod.vb.phase = 1
mod.vb.sinSeekerCount = 0

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.sinSeekerCount = 0
	timerSpreadshotCD:Start(6-delay)
	timerSinseekerCD:Start(25.5-delay, 1)
	--Margore on pull on heroic testing, but can this change?
	timerJaggedClawsCD:Start(10.9-delay)
	timerBloodyThrashCD:Start(18.7-delay)--SUCCESS of debuff, not Command Margore-335119
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)--For Acid Splash
--	end
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 335114 then
		self.vb.sinSeekerCount = self.vb.sinSeekerCount + 1
		timerSinseekerCD:Start(self.vb.phase == 4 and 34.1 or 49, self.vb.sinSeekerCount+1)
	elseif spellId == 334404 then
		warnSpreadshot:Show()
		timerSpreadshotCD:Start(self.vb.phase == 4 and 6 or 12)
	elseif spellId == 334971 then
		timerJaggedClawsCD:Start()
	elseif spellId == 334797 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnRipSoul:Show()
			specWarnRipSoul:Play("defensive")
		end
		timerRipSoulCD:Start()
	elseif spellId == 334757 then
		specWarnShadesofBargast:Show()
		specWarnShadesofBargast:Play("killmob")
		timerShadesofBargastCD:Start()
	elseif spellId == 334852 then
		timerPetrifyingHowlCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 334945 then--First event with target information, it's where we sync timers to
		timerBloodyThrashCD:Start()
	elseif spellId == 334797 then
		specWarnRipSoulHealer:Show()
		specWarnRipSoulHealer:Play("healfull")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 334971 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			--local tauntStack = 3
			--if self:IsHard() and self.Options.TauntBehavior == "TwoHardThreeEasy" or self.Options.TauntBehavior == "TwoAlways" then
			--	tauntStack = 2
			--end
			if amount >= 5 then
				if args:IsPlayer() then
					specWarnJaggedClaws:Show(amount)
					specWarnJaggedClaws:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) and not self:IsHealer() then--Can't taunt less you've dropped yours off, period.
						specWarnJaggedClawsTaunt:Show(args.destName)
						specWarnJaggedClawsTaunt:Play("tauntboss")
					else
						warnJaggedClaws:Show(args.destName, amount)
					end
				end
			else
				warnJaggedClaws:Show(args.destName, amount)
			end
		end
	elseif spellId == 334860 then
		local amount = args.amount or 1
		if amount % 5 == 0 then
			warnCrushingStone:Show(args.destName, amount)
		end
	elseif spellId == 334945 then
		if args:IsPlayer() then
			specWarnBloodThrash:Show()
			specWarnBloodThrash:Play("gathershare")
			yellBloodThrash:Yell()
			yellBloodThrashFades:Countdown(spellId)
		else
			warnBloodyThrash:Show(args.destname)
		end
	elseif spellId == 334852 then
		warnPetrifyingHowl:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnPetrifyingHowl:Show()
			specWarnPetrifyingHowl:Play("scatter")
			yellPetrifyingHowl:Yell()
			yellPetrifyingHowlFades:Countdown(spellId)
		end
	elseif spellId == 335111 or spellId == 335112 or spellId == 335113 then
		warnSinseeker:CombinedShow(spellId == 335113 and 0.1 or 2.5, args.destName)
		local icon = 335111 and 1 or 335112 and 2 or 335113 and 3
		if args:IsPlayer() then
			specWarnSinseeker:Show(self:IconNumToTexture(icon))
			specWarnSinseeker:Play("mm"..icon)
			yellSinseeker:Yell(icon, icon, icon)
			yellSinseekerFades:Countdown(spellId, nil, icon)
		end
		if self.Options.SetIconOnSinSeeker then
			self:SetIcon(args.destName, icon)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 334945 then
		if args:IsPlayer() then
			yellBloodThrashFades:Cancel()
		end
	elseif spellId == 334860 then
		local amount = args.amount or 1
		if amount % 5 == 0 then
			warnCrushingStone:Show(args.destName, amount)
		end
	elseif spellId == 334852 then
		if args:IsPlayer() then
			yellPetrifyingHowlFades:Cancel()
		end
	elseif spellId == 335111 or spellId == 335112 or spellId == 335113 then
		if args:IsPlayer() then
			yellSinseekerFades:Cancel()
		end
		if self.Options.SetIconOnSinSeeker then
			self:SetIcon(args.destName, 0)
		end
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 165067 then--margore
		self.vb.phase = 2
		timerJaggedClawsCD:Stop()
		timerBloodyThrashCD:Stop()
		--Start Next Dog. Move if order changes or is variable
		timerRipSoulCD:Start(15.6)
		timerShadesofBargastCD:Start(23.4)
		--Boss also adjusts timers, but only in first half of test pulls
--		timerSinseekerCD:Stop()
--		timerSinseekerCD:Start(28.5, self.vb.sinSeekerCount+1)
	elseif cid == 169457 then--bargast
		self.vb.phase = 3
		timerRipSoulCD:Stop()
		timerShadesofBargastCD:Stop()
		--Start Next Dog. Move if order changes or is variable
		timerPetrifyingHowlCD:Start(20)
		--Boss also adjusts timers, but only in first half of test pulls
--		timerSinseekerCD:Stop()
--		timerSinseekerCD:Start(23.7, self.vb.sinSeekerCount+1)
	elseif cid == 169458 then--hecutis
		self.vb.phase = 4
		timerPetrifyingHowlCD:Stop()
		--Boss also adjusts timers, but only in first half of test pulls
--		timerSinseekerCD:Stop()
--		timerSinseekerCD:Start(38.7, self.vb.sinSeekerCount+1)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--Hacky, but works super well
--Not currently needed though since targetting info in combat log, IF that ever changes, backup method
function mod:RAID_BOSS_WHISPER(msg)
	msg = msg:lower()
	if msg:find("ability_hunter_assassinate2") then
		specWarnSinseeker:Show()
		specWarnSinseeker:Play("runout")
		yellSinseeker:Yell()
		yellSinseekerFades:Countdown(4)
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	msg = msg:lower()
	if msg:find("ability_hunter_assassinate2") and targetName then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName) then
			warnSinseeker:CombinedShow(0.75, targetName)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 310351 then

	end
end
--]]
