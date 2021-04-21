local mod	= DBM:NewMod(2439, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175726)--Skyja (TODO, add other 2 and set health to highest?)
mod:SetEncounterID(2429)
mod:SetUsedIcons(8, 7, 6, 4, 3, 2, 1)
--mod:SetHotfixNoticeRev(20201222000000)
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 350202 350342 350339 350365 350283 350385 350467 352744 350541 350482 350687",
	"SPELL_CAST_SUCCESS 350286 350184 351399",
	"SPELL_AURA_APPLIED 350202 350157 350109 351139 350039 350542",
	"SPELL_AURA_APPLIED_DOSE 350202",
	"SPELL_AURA_REMOVED 350157 350109 351139 350039 350542",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, tank swap stacks
--TODO, forrmless mass alternate event https://ptr.wowhead.com/spell=350343/formless-mass?
--TODO, how many formless mass spawn? confirm spawn event and mark them faster as well, if possible
--TODO, soulful blast CD if it's long enough?
--TODO, confirm agatha's, Dschla's, Aradne's attacks.
--TODO, Annhylde multiple targets?
--TODO, if aegis targets npc, add buff duration to nameplate aura, if it's a bubble on ground boss has to be moved from, leave as is
--TODO, marking anything else??
--TODO, total fragments/icons needed on each difficulty
--TODO, fragments spellId used (cast/timer)
--TODO, figure out fancy shit for the raid icons for player jumps, if jump has sourcename then pull icons from sourcename and move same icon to dest name in same action (unless they already have an icon)
--TODO, stage 2 detection
--TODO, pretty sure journal is a mess regarding word of Recall so handling in this mod is assumed and needs vetting.
--Stage One: The Unending Voice
----Kyra, The Unending
local warnUnendingStrike						= mod:NewStackAnnounce(350202, 2, nil, "Tank|Healer")
----Signe, The Voice
--local warnBloodLantern						= mod:NewTargetNoFilterAnnounce(341684, 2)
----Skyja, The First
local warnCalloftheValkyr						= mod:NewCountAnnounce(350467, 3)
local warnAnnhyldesBrightAegis					= mod:NewTargetNoFilterAnnounce(350157, 2)
local warnBrynjasMournfulDirge					= mod:NewTargetNoFilterAnnounce(350109, 2)
local warnArthurasCrushingGaze					= mod:NewTargetNoFilterAnnounce(350039, 3)
local warnFragmentsofDestiny					= mod:NewTargetNoFilterAnnounce(350542, 4)
--Stage Two: The First of the Mawsworn
local warnPierceSoul							= mod:NewStackAnnounce(350475, 2, nil, "Tank|Healer")
local warnResentment							= mod:NewCountAnnounce(351399, 3)
local warnLinkEssence							= mod:NewTargetAnnounce(350482, 3)

--Stage One: The Unending Voice
----Kyra, The Unending
local specWarnUnendingStrike					= mod:NewSpecialWarningStack(350202, nil, 3, nil, nil, 1, 6)
local specWarnUnendingStrikeTaunt				= mod:NewSpecialWarningTaunt(350202, nil, nil, nil, 1, 2)
local specWarnFormlessMass						= mod:NewSpecialWarningSwitch(342077, "Dps", nil, nil, 1, 2)
local specWarnSiphonVitality					= mod:NewSpecialWarningInterruptCount(350339, "HasInterrupt", nil, nil, 1, 2)
local specWarnWingsofRage						= mod:NewSpecialWarningRun(350365, nil, nil, nil, 4, 2)
----Signe, The Voice
local specWarnSoulfulBlast						= mod:NewSpecialWarningInterrupt(350283, false, nil, nil, 1, 2)--Opt in, only some should be doing this one
local specWarnSongofDissolution					= mod:NewSpecialWarningInterrupt(350286, "HasInterrupt", nil, nil, 1, 2)
local specWarnReverberatingRefrain				= mod:NewSpecialWarningMoveTo(350385, nil, nil, nil, 3, 2)
----Skyja, The First
------Call of the Val'kyr
local specWarnAgathasEternalblade				= mod:NewSpecialWarningDodge(350031, nil, nil, nil, 2, 2)
local specWarnDaschlasMightyAnvil				= mod:NewSpecialWarningDodge(350184, nil, nil, nil, 2, 2)
local specWarnAradnesFallingStrike				= mod:NewSpecialWarningSoak(350098, nil, nil, nil, 1, 2)
local specWarnBrynjasMournfulDirge				= mod:NewSpecialWarningMoveAway(350109, nil, nil, nil, 1, 2)
local yellBrynjasMournfulDirge					= mod:NewShortYell(350109)
local yellBrynjasMournfulDirgeFades				= mod:NewShortFadesYell(350109)
local specWarnArthurasCrushingGaze				= mod:NewSpecialWarningMoveTo(350039, nil, nil, nil, 3, 2)
local yellArthurasCrushingGaze					= mod:NewYell(350039, nil, nil, nil, "YELL")
local yellArthurasCrushingGazeFades				= mod:NewShortFadesYell(350039, nil, nil, nil, "YELL")
------End Valks
local specWarnFragmentsofDestiny				= mod:NewSpecialWarningMoveAway(350542, nil, nil, nil, 1, 2)
local yellFragmentsofDestiny					= mod:NewShortYell(350542)--TODO, probably change to icon/numbered yell system based on icon/combatlog order
--Stage Two: The First of the Mawsworn
local specWarnPierceSoul						= mod:NewSpecialWarningStack(350475, nil, 4, nil, nil, 1, 6)
local specWarnPierceSoulTaunt					= mod:NewSpecialWarningTaunt(350475, nil, nil, nil, 1, 2)
local specWarnLinkEssence						= mod:NewSpecialWarningYou(350482, nil, nil, nil, 1, 2)
local specWarnWordofRecall						= mod:NewSpecialWarningSpell(350687, nil, nil, nil, 2, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Stage One: The Unending Voice
----Kyra, The Unending
local timerUnendingStrikeCD						= mod:NewAITimer(17.8, 350202, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerFormlessMassCD						= mod:NewAITimer(23, 342077, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerWingsofRageCD						= mod:NewAITimer(23, 350365, nil, nil, nil, 2)
----Signe, The Voice
local timerSongofDissolutionCD					= mod:NewAITimer(23, 350286, nil, nil, nil, 4, nil, DBM_CORE_L.INTERRUPT_ICON)
local timerReverberatingRefrainCD				= mod:NewAITimer(23, 350385, nil, nil, nil, 2)
----Skyja, The First
local timerCalloftheValkyrCD					= mod:NewAITimer(23, 350467, nil, nil, nil, 3, nil, nil, nil, 1, 3)
local timerFragmentsofDestinyCD					= mod:NewAITimer(23, 350541, nil, nil, nil, 3, nil, nil, nil, 2, 3)
--Stage Two: The First of the Mawsworn
local timerPierceSoulCD							= mod:NewAITimer(17.8, 350475, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerResentmentCD							= mod:NewAITimer(23, 351399, nil, nil, nil, 2)
local timerLinkEssenceCD						= mod:NewAITimer(23, 350482, nil, nil, nil, 3, nil, DBM_CORE_L.HEROIC_ICON)
local timerWordofRecallCD						= mod:NewAITimer(23, 350687, nil, nil, nil, 2)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(350365, true)
mod:AddSetIconOption("SetIconOnFragments", 350542, true, false, {1, 2, 3, 4})--Mythic says max 4, so probably the cap
mod:AddSetIconOption("SetIconOnFormlessMass", 342077, true, true, {7, 8, 6})
mod:AddNamePlateOption("NPAuraOnBrightAegis", 350157)

local castsPerGUID = {}
mod.vb.addIcon = 8
mod.vb.valkCount = 0
mod.vb.fragmentsIcon = 1
mod.vb.resentmentCount = 0

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.addIcon = 8
	self.vb.valkCount = 0
	self.vb.resentmentCount = 0
	--Kyra
	timerUnendingStrikeCD:Start(1-delay)
	timerFormlessMassCD:Start(1-delay)
	timerWingsofRageCD:Start(1-delay)
	--Signe
	timerSongofDissolutionCD:Start(1-delay)
	timerReverberatingRefrainCD:Start(1-delay)
	--Skyja
	timerCalloftheValkyrCD:Start(1-delay)
	timerFragmentsofDestinyCD:Start(1-delay)
--	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_L.INFOFRAME_POWER)
		DBM.InfoFrame:Show(3, "enemypower", 2)
	end
	if self.Options.NPAuraOnBrightAegis then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnBrightAegis then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 350202 then
		timerUnendingStrikeCD:Start()
	elseif spellId == 350342 then
		self.vb.addIcon = 8
		specWarnFormlessMass:Show()
		specWarnFormlessMass:Play("killmob")
		timerFormlessMassCD:Start()
	elseif spellId == 350339 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnFormlessMass and self.vb.addIcon > 3 then--Only use up to 5 icons
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 12, "SetIconOnFormlessMass")
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnSiphonVitality:Show(args.sourceName, count)
			if count == 1 then
				specWarnSiphonVitality:Play("kick1r")
			elseif count == 2 then
				specWarnSiphonVitality:Play("kick2r")
			elseif count == 3 then
				specWarnSiphonVitality:Play("kick3r")
			elseif count == 4 then
				specWarnSiphonVitality:Play("kick4r")
			elseif count == 5 then
				specWarnSiphonVitality:Play("kick5r")
			else
				specWarnSiphonVitality:Play("kickcast")
			end
		end
	elseif spellId == 350365 then
		specWarnWingsofRage:Show()
		specWarnWingsofRage:Play("justrun")
		timerWingsofRageCD:Start()
	elseif spellId == 350283 and self:CheckInterruptFilter(args.sourceGUID, false, false) then
		specWarnSoulfulBlast:Show(args.sourceName)
		specWarnSoulfulBlast:Play("kickcast")
	elseif spellId == 350385 then
		specWarnReverberatingRefrain:Show(args.sourceName)
		specWarnReverberatingRefrain:Play("findshelter")
		timerReverberatingRefrainCD:Start()
	elseif spellId == 350467 then
		self.vb.valkCount = self.vb.valkCount + 1
		warnCalloftheValkyr:Show(self.vb.valkCount)
		timerCalloftheValkyrCD:Start()
	elseif spellid == 352744 or spellId == 350541 then
		self.vb.fragmentsIcon = 1
		timerFragmentsofDestinyCD:Start()
	elseif spellId == 350482 then
		timerLinkEssenceCD:Start()
	elseif spellId == 350687 then
		specWarnWordofRecall:Show()
		specWarnWordofRecall:Play("specialsoon")
		timerWordofRecallCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 350286 and self:CheckInterruptFilter(args.sourceGUID, false, false) then
		specWarnSongofDissolution:Show(args.sourceName)
		specWarnSongofDissolution:Play("kickcast")
	elseif spellId == 350184 then
		specWarnDaschlasMightyAnvil:Show()
		specWarnDaschlasMightyAnvil:Play("watchstep")
	elseif spellId == 351399 then
		self.vb.resentmentCount = self.vb.resentmentCount + 1
		warnResentment:Show(self.vb.resentmentCount)
		timerResentmentCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 350202 then
		local amount = args.amount or 1
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnUnendingStrike:Show(amount)
				specWarnUnendingStrike:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
					specWarnUnendingStrikeTaunt:Show(args.destName)
					specWarnUnendingStrikeTaunt:Play("tauntboss")
				else
					warnUnendingStrike:Show(args.destName, amount)
				end
			end
		else
			warnUnendingStrike:Show(args.destName, amount)
		end
	elseif spellId == 350475 then
		local amount = args.amount or 1
		if amount >= 4 then
			if args:IsPlayer() then
				specWarnPierceSoul:Show(amount)
				specWarnPierceSoul:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
					specWarnPierceSoulTaunt:Show(args.destName)
					specWarnPierceSoulTaunt:Play("tauntboss")
				else
					warnUnendingStrike:Show(args.destName, amount)
				end
			end
		else
			warnUnendingStrike:Show(args.destName, amount)
		end
	elseif spellId == 350157 then
		warnAnnhyldesBrightAegis:CombinedShow(0.3, args.destName)
		if self.Options.NPAuraOnBrightAegis then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350109 or spellId == 351139 then--Ones probably normal/LFR and other heroic/mythic
		if args:IsPlayer() then
			specWarnBrynjasMournfulDirge:Show()
			specWarnBrynjasMournfulDirge:Play("runout")
			yellBrynjasMournfulDirge:Yell()
			yellBrynjasMournfulDirgeFades:Countdown(spellId)
		end
	elseif spellId == 350039 then
		if args:IsPlayer() then
			specWarnArthurasCrushingGaze:Show(DBM_CORE_L.ALLIES)
			specWarnArthurasCrushingGaze:Play("gathershare")
			yellArthurasCrushingGaze:Yell()
			yellArthurasCrushingGazeFades:Countdown(spellId)
		else
			warnArthurasCrushingGaze:Show(targetname)
		end
	elseif spellId == 350542 then
		local icon = self.vb.fragmentsIcon
		if self.Options.SetIconOnFragments then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnFragmentsofDestiny:Show()
			specWarnFragmentsofDestiny:Play("targetyou")
			yellFragmentsofDestiny:Yell()--icon, icon
		end
		warnFragmentsofDestiny:CombinedShow(0.3, args.destName)
		self.vb.fragmentsIcon = self.vb.fragmentsIcon + 1
	elseif spellId == 350482 then
		warnLinkEssence:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnLinkEssence:Show()
			specWarnLinkEssence:Play("targetyou")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 350157 then
		if self.Options.NPAuraOnBrightAegis then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350109 or spellId == 351139 then--Ones probably normal/LFR and other heroic/mythic
		if args:IsPlayer() then
			yellBrynjasMournfulDirgeFades:Cancel()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 177407 then--Formless Mass
		castsPerGUID[args.destGUID] = nil
	elseif cid == 178738 then--Kyra
		timerUnendingStrikeCD:Stop()
		timerFormlessMassCD:Stop()
		timerWingsofRageCD:Stop()
	elseif cid == 178736 then--Signe
		timerSongofDissolutionCD:Stop()
		timerReverberatingRefrainCD:Stop()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:350031") then
		specWarnAgathasEternalblade:Show()
		specWarnAgathasEternalblade:Play("farfromline")
--		local targetname = DBM:GetUnitFullName(target) or target--For people not in group, GetUnitFullName fails so need to at least use blizz provided target as backup
--		if targetname == UnitName("player") then
--			specWarnChargedAnimaBlast:Show()
--			specWarnChargedAnimaBlast:Play("runout")
--		else
--			warnChargedAnimaBlast:Show(targetname)
--		end
--		if self.Options.SetIconOnAnimaBlast then
--			self:SetIcon(targetname, 8, 5)--Icon clears 1 second after blast
--		end
	elseif msg:find("spell:350098") or msg:find("spell:350078") then
		specWarnAradnesFallingStrike:Show()
		specWarnAradnesFallingStrike:Play("helpsoak")
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 342074 then

	end
end
--]]
