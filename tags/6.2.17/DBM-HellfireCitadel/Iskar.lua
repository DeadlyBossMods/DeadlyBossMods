local mod	= DBM:NewMod(1433, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90316)
mod:SetEncounterID(1788)
mod:DisableESCombatDetection()--Remove if blizz fixes trash firing ENCOUNTER_START
mod:SetMinSyncRevision(13887)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--Unknown full spectrum of icons yet. Don't know how many debuffs go out.
mod:SetHotfixNoticeRev(14463)
mod.respawnTime = 15
mod:DisableRegenDetection()--Boss returns true on UnitAffectingCombat when fighting his trash, making boss pre mature pull by REGEN method

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 181912 181827 187998 181873 185345",
	"SPELL_CAST_SUCCESS 182178 181956 185510 181912",
	"SPELL_AURA_APPLIED 179202 181957 182325 187990 181824 179219 185510 181753 182178 182200",
	"SPELL_AURA_REMOVED 179202 181957 182325 187990 181824 179219 185510 181753 182178 182200",
	"SPELL_PERIODIC_DAMAGE 182600",
	"SPELL_PERIODIC_MISSED 182600",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_ADDON",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--(ability.id = 181912 or ability.id = 181827 or ability.id = 187998 or ability.id = 181873 or ability.id = 185345) and type = "begincast" or (ability.id = 182178 or ability.id = 181956 or ability.id = 181912 or ability.id = 185510) and type = "cast" or (ability.id = 181824 or ability.id = 187990 or ability.id = 181753) and type = "applydebuff"
--Boss
local warnEyeofAnzu						= mod:NewTargetAnnounce(179202, 1, nil, false)--Important, but spammy, Will do something fancy with infoframe to show target instead of spamming screen with warnings
local warnPhantasmalWinds				= mod:NewTargetAnnounce(181957, 4)--Announce to all, for things like life grips, body and soul, etc to keep them on platform while anzu person helps clear them.
local warnPhantasmalWounds				= mod:NewTargetAnnounce(182325, 2, nil, "Healer")
local warnFelChakram					= mod:NewTargetAnnounce(182178, 4)
local warnLaser							= mod:NewTargetAnnounce(182582, 3)
local warnShadowRiposte					= mod:NewSpellAnnounce(185345, 4)
--Adds
local warnPhantasmalCorruption			= mod:NewTargetAnnounce(181824, 3)
local warnPhantasmalFelBomb				= mod:NewTargetAnnounce(179219, 3, nil, false)--Fake fel bombs, they'll show up on radar but don't need to know targets if person with anzu isn't terrlbe at game. they have 5 seconds to find and throw to ONE target.
local warnFelBomb						= mod:NewTargetAnnounce(181753, 3)
local warnDarkBindings					= mod:NewTargetAnnounce(185510, 4)--Mythic (Chains of Despair Debuff)
local warnFelConduit					= mod:NewCastAnnounce(181827, 3, nil, nil, "-Healer")

--Boss
local specWarnEyeofAnzu					= mod:NewSpecialWarningYou(179202)
local specWarnThrowAnzu					= mod:NewSpecialWarning("specWarnThrowAnzu", nil, nil, nil, 1, 5)
local specWarnFocusedBlast				= mod:NewSpecialWarningCount(181912, nil, nil, nil, 2)
local specWarnPhantasmalWinds			= mod:NewSpecialWarningYou(181957, nil, nil, nil, 3)
local specWarnFelChakram				= mod:NewSpecialWarningMoveAway(182178, nil, nil, nil, 1, 2)
local yellFelChakram					= mod:NewYell(182178)
local specWarnFelChakramTank			= mod:NewSpecialWarningTaunt(182178, nil, nil, nil, 1, 2)
local yellPhantasmalWinds				= mod:NewYell(181957)--So person with eye can see where the targets are faster
local specWarnPhantasmalWounds			= mod:NewSpecialWarningYou(182325, false)
local yellPhantasmalWounds				= mod:NewYell(182325, nil, false)--Can't see much reason to have THIS one on by default, but offered as an option.
local specWarnFelLaser					= mod:NewSpecialWarningMoveAway(182582, nil, nil, nil, 1, 2)
local specWarnFelLaserGTFO				= mod:NewSpecialWarningMove(182600, nil, nil, nil, 1, 2)
local yellFelLaser						= mod:NewYell(182582)
local specWarnShadowRiposte				= mod:NewSpecialWarningSpell(185345, nil, nil, nil, 3)--Has eye of anzu, they need to know this badly.
--Adds
local specWarnPhantasmalCorruption		= mod:NewSpecialWarningYou(181824)--Not move away on purpose, correct way to handle is get eye of anzu, you do NOT move
local yellPhantasmalCorruption			= mod:NewYell(181824)--For eye of anzu holder. Explosion shouldn't happen.
local specWarnPhantasmalFelBomb			= mod:NewSpecialWarningYou(179219)--Not move away on purpose, correct way to handle is get eye of anzu to real fel bomb
local yellPhantasmalFelBomb				= mod:NewYell(179219, nil, false)--Fake bombs off by default, they will never explode and eye of anzu holder will get distracted
local specWarnFelBomb					= mod:NewSpecialWarningYou(181753)--Not move away on purpose, correct way to handle is get eye of anzu, you do NOT move
local yellFelBomb						= mod:NewYell(181753)--Yell for real fel bomb on by default only
local specWarnFelBombDispel				= mod:NewSpecialWarningDispel(181753, nil, nil, nil, 1, 2)--Doesn't need option default, it's filtered by anzu check
local specWarnDarkBindings				= mod:NewSpecialWarningYou(185510)--Mythic
local specWarnFelConduit				= mod:NewSpecialWarningInterrupt(181827, nil, nil, nil, 1, 2)--On for everyone, filtered by eye of anzu, if this person can't interrupt, then they better pass it to someone who can

local timerFelLaserCD					= mod:NewCDTimer(16, 182582, nil, nil, nil, 3)--16-22. Never pauses, used all phases
local timerChakramCD					= mod:NewCDTimer(33, 182178, nil, nil, nil, 3)
local timerPhantasmalWindsCD			= mod:NewCDTimer(35, 181957, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerPhantasmalWoundsCD			= mod:NewCDTimer(30.5, 182325, nil, "Healer", 2, 5)--30.5-32
local timerFocusedBlast					= mod:NewCastTimer(11, 181912, nil, nil, nil, 2)--Doesn't realy need a cd timer. he casts it twice back to back, then lands
local timerShadowRiposteCD				= mod:NewCDTimer(23.5, 185345, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
--Adds
local timerFelBombCD					= mod:NewCDTimer(18.5, 181753, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerFelConduitCD					= mod:NewCDTimer(15, 181827, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerPhantasmalCorruptionCD		= mod:NewCDTimer(14, 181824, nil, "Tank", nil, 3)--14-18
local timerDarkBindingsCD				= mod:NewCDTimer(34, 185456, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)

local countdownPhantasmalWinds			= mod:NewCountdown(35, 181957)
local countdownFelBomb					= mod:NewCountdown("Alt18", 181753)
local countdownCorruption				= mod:NewCountdown("AltTwo14", 181824, "Tank")

local berserkTimer						= mod:NewBerserkTimer(540)

local voiceFocusedBlast					= mod:NewVoice(181912)--gather
local voiceFelConduit					= mod:NewVoice(181827)--kickcast
local voiceFelChakram					= mod:NewVoice(182178)--runout
local voiceFelLaser						= mod:NewVoice(182582)--runout
local voiceFelBombDispel				= mod:NewVoice(181753)	--dispel now
local voiceThrowAnzu					= mod:NewVoice(179202)	--New, 179202,"throw eye to someone with debuff"; 179202h,"throw eye to healer"; 179202m,"throw eye to melee"

mod:AddRangeFrameOption(15)--Both aoes are 15 yards, ref 187991 and 181748
mod:AddSetIconOption("SetIconOnAnzu", 179202, false)
mod:AddSetIconOption("SetIconOnWinds", 181957, true)
mod:AddSetIconOption("SetIconOnFelBomb", 181753, true)
mod:AddSetIconOption("SetIconOnAdds", 181873, false, true)
mod:AddHudMapOption("HudMapOnChakram", 182178)

mod.vb.escapeCount = 0
mod.vb.focusedBlast = 0
mod.vb.savedChakram = nil
mod.vb.savedWinds = nil
mod.vb.savedWounds = nil
mod.vb.savedRiposte = nil
mod.vb.windsTargets = 0
mod.vb.bombActive = nil
local chakramTargets = {}
local playerHasAnzu = false
local corruption = GetSpellInfo(181824)
local phantasmalFelBomb = GetSpellInfo(179219)
local realFelBomb = GetSpellInfo(181753)
local darkBindings = GetSpellInfo(185510)
local playerName = UnitName("player")
local AddsSeen = {}

local debuffFilter
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, corruption) or UnitDebuff(uId, phantasmalFelBomb) or UnitDebuff(uId, realFelBomb) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	--Both spells have same 15 yard range so this makes it easy
	--Player has either debuff, show everyone
	if UnitDebuff("player", corruption) or UnitDebuff("player", phantasmalFelBomb) or UnitDebuff("player", realFelBomb) then
		DBM.RangeCheck:Show(15)
	else--Show players with either debuff near you.
		DBM.RangeCheck:Show(15, debuffFilter)
	end
end

local function showChakram(self)
	warnFelChakram:Show(table.concat(chakramTargets, "<, >"))
	--Chakram is always thrown ranged-->melee-->Tank
	--Need to determine roles for the hud
	if not self.Options.HudMapOnChakram then return end
	local ranged, melee, tank = nil, nil, nil
	for i = 1, #chakramTargets do
		local name = chakramTargets[i]
		local uId = DBM:GetRaidUnitId(name)
		if not uId then return end--Prevent errors if person leaves group
		if self:IsMeleeDps(uId) then--Melee
			melee = chakramTargets[i]
			DBM:Debug("Melee Chakram found: "..melee, 2)
		elseif self:IsTanking(uId, "boss1") then--Tank
			tank = chakramTargets[i]
			DBM:Debug("Tank Chakram found: "..tank, 2)
		else--Ranged
			ranged = chakramTargets[i]
			DBM:Debug("Ranged Chakram found: "..ranged, 2)
		end
	end
	if ranged and melee and tank then
		DBM:Debug("All Chakram found!", 2)
		DBMHudMap:RegisterRangeMarkerOnPartyMember(182178, "party", ranged, 0.65, 6, nil, nil, nil, 0.8, nil, false):Appear():SetLabel(ranged, nil, nil, nil, nil, nil, 0.8, nil, -15, 8, nil)
		DBMHudMap:RegisterRangeMarkerOnPartyMember(182178, "party", melee, 0.65, 6, nil, nil, nil, 0.8, nil, false):Appear():SetLabel(melee, nil, nil, nil, nil, nil, 0.8, nil, -15, 8, nil)
		DBMHudMap:RegisterRangeMarkerOnPartyMember(182178, "party", tank, 0.65, 6, nil, nil, nil, 0.8, nil, false):Appear():SetLabel(tank, nil, nil, nil, nil, nil, 0.8, nil, -15, 8, nil)
		if playerName == melee or playerName == ranged or playerName == tank then--Player in it, green lines
			DBMHudMap:AddEdge(0, 1, 0, 0.5, 6, ranged, melee, nil, nil, nil, nil)
			DBMHudMap:AddEdge(0, 1, 0, 0.5, 6, melee, tank, nil, nil, nil, nil)
		else--Yellow lines
			DBMHudMap:AddEdge(1, 1, 0, 0.5, 6, ranged, melee, nil, nil, nil, nil)
			DBMHudMap:AddEdge(1, 1, 0, 0.5, 6, melee, tank, nil, nil, nil, nil)
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.escapeCount = 0
	self.vb.focusedBlast = 0
	self.vb.savedChakram = nil
	self.vb.savedWinds = nil
	self.vb.savedWounds = nil
	self.vb.savedRiposte = nil
	self.vb.windsTargets = 0
	self.vb.bombActive = nil
	playerHasAnzu = false
	table.wipe(AddsSeen)
	table.wipe(chakramTargets)
	updateRangeFrame(self)
	timerChakramCD:Start(5-delay)--Seems still 5 in all modes
	if self:IsNormal() then--Normal timers are about 40% slower on pull, 20% slower rest of fight
		timerFelLaserCD:Start(25)
		timerPhantasmalWindsCD:Start(30-delay)
		countdownPhantasmalWinds:Start(30-delay)
		timerPhantasmalWoundsCD:Start(44-delay)
	else
		timerPhantasmalWindsCD:Start(16.5-delay)
		countdownPhantasmalWinds:Start(16.5-delay)
		timerFelLaserCD:Start(18.5)--Verify it can still be this low, every pull on mythic was 20-22
		timerPhantasmalWoundsCD:Start(28-delay)
		if self:IsMythic() then
			timerShadowRiposteCD:Start(9.5-delay)
		end
	end
	if self:IsNormal() or self:IsMythic() then
		berserkTimer:Start(480-delay)
	else
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnChakram then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 181912 then
		self.vb.focusedBlast = self.vb.focusedBlast + 1
		specWarnFocusedBlast:Show(self.vb.focusedBlast)
		if not UnitDebuff("player", corruption) and not UnitDebuff("player", realFelBomb) and not UnitDebuff("player", phantasmalFelBomb) and not UnitDebuff("player", darkBindings) then--Filter debuffs that kill other players
			voiceFocusedBlast:Play("gather")
		end
		timerFocusedBlast:Start()
	elseif spellId == 181827 or spellId == 187998 then--Both versions of it. I assume the 5 second version is probably LFR/Normal
		timerFelConduitCD:Start(args.sourceGUID)
		if playerHasAnzu then--Able to interrupt
			specWarnFelConduit:Show(args.sourceName)
			if self:IsHealer() then--It's still on healer that did last dispel, they need to throw to better interruptor, probably tank
				specWarnThrowAnzu:Show(TANK)
				voiceThrowAnzu:Play("179202m") --throw to melee (maybe change to throw to tank, in strat i saw, it was best to bounce eye between tank and healer since throwing to tank also made immune to Phantasmal Corruption as added bonus)
			else
				voiceFelConduit:Play("kickcast")
			end
		else
			warnFelConduit:Show()
		end
	elseif spellId == 181873 then--Air phase start (Shadow Escape)
		self.vb.escapeCount = self.vb.escapeCount + 1
		self.vb.focusedBlast = 0
		--Timers pause, save times
		self.vb.savedChakram = timerChakramCD:GetRemaining()
		self.vb.savedWinds = timerPhantasmalWindsCD:GetRemaining()
		self.vb.savedWounds = timerPhantasmalWoundsCD:GetRemaining()
		if self:IsMythic() then
			self.vb.savedRiposte = timerShadowRiposteCD:GetRemaining()
			if self.Options.SetIconOnAdds then
				self:ScanForMobs(93625, 2, 8, 1, 0.2, 15)--Mythic Add
				self:ScanForMobs(91543, 2, 7, 1, 0.2, 15)--Bomb Add
				if self.vb.escapeCount >= 2 then
					self:ScanForMobs(91541, 2, 6, 1, 0.2, 15)--Construct Add
				end
				if self.vb.escapeCount == 3 then
					self:ScanForMobs(91539, 2, 5, 1, 0.2, 15)--Raven Add
				end
			end
		else
			if self.Options.SetIconOnAdds then
				self:ScanForMobs(91543, 2, 8, 1, 0.2, 15)--Bomb Add
				if self.vb.escapeCount >= 2 then
					self:ScanForMobs(91541, 2, 7, 1, 0.2, 15)--Construct Add
				end
				if self.vb.escapeCount == 3 then
					self:ScanForMobs(91539, 2, 6, 1, 0.2, 15)--Raven Add
				end
			end
		end
		--Clear. Sure I could just do GetTime+39 and call it a day, but this is prettier
		timerChakramCD:Cancel()
		timerPhantasmalWindsCD:Cancel()
		countdownPhantasmalWinds:Cancel()
		timerPhantasmalWoundsCD:Cancel()
		timerDarkBindingsCD:Cancel()
		timerShadowRiposteCD:Cancel()
	elseif spellId == 185345 and not args:IsSrcTypePlayer() then
		if playerHasAnzu then
			specWarnShadowRiposte:Show()
		else
			warnShadowRiposte:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 182178 then
		table.wipe(chakramTargets)
		timerChakramCD:Start()
	elseif spellId == 181956 then
		if self:IsNormal() then
			timerPhantasmalWindsCD:Start(46)
			countdownPhantasmalWinds:Start(46)
		else
			timerPhantasmalWindsCD:Start()
			countdownPhantasmalWinds:Start()
		end
	elseif spellId == 181912 and self.vb.focusedBlast == 2 then--Air phase over immediately after he finishes casting 2nd blast.
		--Timers resume with +3-7, sometimes more. Extreme cases I suspect just got delayed by laser or some other channeled spell
		timerChakramCD:Start(self.vb.savedChakram+3)
		timerPhantasmalWindsCD:Start(self.vb.savedWinds+5)
		--countdownPhantasmalWinds:Start(self.vb.savedWinds+5)--no countdown for this one unless made accurate enough
		timerPhantasmalWoundsCD:Start(self.vb.savedWounds+5)
		if self:IsMythic() then
			timerShadowRiposteCD:Start(self.vb.savedRiposte+5)
		end
		self.vb.savedChakram = nil
		self.vb.savedWinds = nil
		self.vb.savedWounds = nil
		self.vb.savedRiposte = nil
	elseif spellId == 185510 then
		timerDarkBindingsCD:Start(args.sourceGUID)
	elseif spellId == 185345 and not args:IsSrcTypePlayer() then
		timerShadowRiposteCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 179202 then--Eye of Anzu!
		warnEyeofAnzu:Show(args.destName)
		if self.Options.SetIconOnAnzu then
			self:SetIcon(args.destName, 1)
		end
		if args:IsPlayer() then
			playerHasAnzu = true
			--Check for bombs or winds and show action warnings
			if self.vb.bombActive then
				if self:IsHealer() then--Can dispel
					specWarnFelBombDispel:Show(self.vb.bombActive)
					voiceFelBombDispel:Play("dispelnow")
				else--Cannot dispel, get eye to a healer asap!
					specWarnThrowAnzu:Show(HEALER)
					voiceThrowAnzu:Play("179202h")
				end
			elseif self.vb.windsTargets > 0 then
				specWarnThrowAnzu:Show(GetSpellInfo(181957))
				voiceThrowAnzu:Play("179202")
			else--No bombs or winds, show generic "eye on you" warning
				specWarnEyeofAnzu:Show()
			end
		end
	elseif spellId == 181957 then
		warnPhantasmalWinds:CombinedShow(0.3, args.destName)
		self.vb.windsTargets = self.vb.windsTargets + 1
		if args:IsPlayer() then
			specWarnPhantasmalWinds:Show()
			yellPhantasmalWinds:Yell()
		end
		if self.Options.SetIconOnWinds and not self:IsLFR() then
			self:SetSortedIcon(0.5, args.destName, 3)--Start at 3 and count up
		end
		if playerHasAnzu and self:AntiSpam(3, 1) then
			specWarnThrowAnzu:Show(args.spellName)
			voiceThrowAnzu:Play("179202")
		end
	elseif spellId == 182325 then
		warnPhantasmalWounds:CombinedShow(1, args.destName)--It goes out kind of slow
		if self:AntiSpam(5, 2) then
			if self:IsNormal() then
				timerPhantasmalWoundsCD:Start(40)
			else
				timerPhantasmalWoundsCD:Start()
			end
		end
		if args:IsPlayer() then
			specWarnPhantasmalWounds:Show()
			yellPhantasmalWounds:Yell()
		end
	elseif spellId == 181824 or spellId == 187990 then
		warnPhantasmalCorruption:Show(args.destName)
		if self:IsNormal() then
			timerPhantasmalCorruptionCD:Start(21, args.sourceGUID)
			countdownCorruption:Start(21)
		else
			timerPhantasmalCorruptionCD:Start(args.sourceGUID)
			countdownCorruption:Start()
		end
		if args:IsPlayer() then
			updateRangeFrame(self)
			specWarnPhantasmalCorruption:Show()
			yellPhantasmalCorruption:Yell()
		else
			if playerHasAnzu then
				specWarnThrowAnzu:Show(args.destName)
				voiceThrowAnzu:Play("179202")
			end
		end
	elseif spellId == 179219 then
		warnPhantasmalFelBomb:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			updateRangeFrame(self)
			specWarnPhantasmalFelBomb:Schedule(0.3)
			yellPhantasmalFelBomb:Schedule(0.3)
		end
	elseif spellId == 181753 then
		self.vb.bombActive = args.destName
		warnFelBomb:Show(args.destName)
		if self:IsNormal() then
			timerFelBombCD:Start(23, args.sourceGUID)
			countdownFelBomb:Start(23)
		else
			timerFelBombCD:Start(args.sourceGUID)
			countdownFelBomb:Start()
		end
		if args:IsPlayer() then
			updateRangeFrame(self)
			specWarnPhantasmalFelBomb:Cancel()
			yellPhantasmalFelBomb:Cancel()
			specWarnFelBomb:Show()
			yellFelBomb:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(15)
			end
		else
			if playerHasAnzu then
				if self:IsHealer() then--Can dispel
					specWarnFelBombDispel:Show(args.destName)
					voiceFelBombDispel:Play("dispelnow")
				else--Cannot dispel, get eye to a healer asap!
					specWarnThrowAnzu:Show(HEALER)
					voiceThrowAnzu:Play("179202h")
				end
			end
		end
		if self.Options.SetIconOnFelBomb then
			self:SetIcon(args.destName, 2)
		end
	elseif spellId == 185510 then
		warnDarkBindings:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDarkBindings:Show()
		end
		if playerHasAnzu and self:AntiSpam(3, 3) then
			specWarnThrowAnzu:Show(args.spellName)
			voiceThrowAnzu:Play("179202")
		end
	elseif spellId == 182178 or spellId == 182200 then
		chakramTargets[#chakramTargets+1] = args.destName
		self:Unschedule(showChakram)
		if #chakramTargets == 3 then
			showChakram(self)
		else
			self:Schedule(0.5, showChakram, self)
		end
		if args:IsPlayer() then
			specWarnFelChakram:Show()
			voiceFelChakram:Play("runout")
			yellFelChakram:Yell()
		end
		--Check if it's a tank
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") and not UnitIsUnit("player", uId) then
			--It is a tank and we're not tanking. Fire taunt warning
			specWarnFelChakramTank:Show(args.destName)
			voiceFelChakram:Play("tauntboss")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 179202 then
		if self.Options.SetIconOnAnzu then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			playerHasAnzu = false
		end
	elseif spellId == 181957 and self.Options.SetIconOnWinds then
		self.vb.windsTargets = self.vb.windsTargets - 1
		self:SetIcon(args.destName, 0)
	elseif (spellId == 181824 or spellId == 187990) then
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 179219 then
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 181753 then
		self.vb.bombActive = nil
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
		if self.Options.SetIconOnFelBomb then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 182178 or spellId == 182200 then
--		if self.Options.HudMapOnChakram then
--			DBMHudMap:FreeEncounterMarkerByTarget(182178, args.destName)
--		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 182600 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnFelLaserGTFO:Show()
		voiceFelLaser:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:182582") then
		specWarnFelLaser:Show()
		yellFelLaser:Yell()
		voiceFelLaser:Play("runout")
	end
end

--per usual, use transcriptor message to get messages from both bigwigs and DBM, all without adding comms to this mod at all
function mod:CHAT_MSG_ADDON(prefix, msg, channel, targetName)
	if prefix ~= "Transcriptor" then return end
	if msg:find("spell:182582") then--
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(5, targetName) then--Antispam sync by target name, since this doesn't use dbms built in onsync handler.
			warnLaser:Show(targetName)
		end
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitGUID = UnitGUID("boss"..i)
		if unitGUID and not AddsSeen[unitGUID] then
			AddsSeen[unitGUID] = true
			local cid = self:GetCIDFromGUID(unitGUID)
			if cid == 91543 then--Corrupted Talonpriest
				timerFelBombCD:Start(14, unitGUID)
				countdownFelBomb:Start(14)
			elseif cid == 91541 then--Shadowfel Warden
				timerFelConduitCD:Start(4, unitGUID)
			elseif cid == 91539 then--Fel Raven
				timerPhantasmalCorruptionCD:Start(16, unitGUID)
				countdownCorruption:Start(16)
			elseif cid == 93625 then--Phantasmal Resonance
				timerDarkBindingsCD:Start(23.6, unitGUID)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 91543 then--Corrupted Talonpriest
		timerFelBombCD:Cancel(args.destGUID)
		countdownFelBomb:Cancel()
	elseif cid == 91541 then--Shadowfel Warden
		timerFelConduitCD:Cancel(args.destGUID)
	elseif cid == 91539 then--Fel Raven
		timerPhantasmalCorruptionCD:Cancel(args.destGUID)
		countdownCorruption:Cancel()
	elseif cid == 93625 then--Phantasmal Resonance
		timerDarkBindingsCD:Cancel(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 182582 or spellId == 184630 then--Fel Incineration
		if self:IsNormal() then
			timerFelLaserCD:Start(23)
		else
			timerFelLaserCD:Start()
		end
	end
end
