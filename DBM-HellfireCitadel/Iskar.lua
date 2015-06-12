local mod	= DBM:NewMod(1433, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90316)
mod:SetEncounterID(1788)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--Unknown full spectrum of icons yet. Don't know how many debuffs go out.
mod:SetRespawnTime(15)
mod:DisableRegenDetection()--Boss returns true on UnitAffectingCombat when fighting his trash, making boss pre mature pull by REGEN method

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 181912 181827 187998 181873",
	"SPELL_CAST_SUCCESS 182178 181956 185510",
	"SPELL_AURA_APPLIED 179202 181957 182325 187990 181824 179219 185510 181753 182178 182200",
	"SPELL_AURA_REMOVED 179202 181957 182325 187990 181824 179219 185510 181753",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_ADDON",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnEyeofAnzu						= mod:NewTargetAnnounce(179202, 1, nil, false)--Important, but spammy, Will do something fancy with infoframe to show target instead of spamming screen with warnings
local warnPhantasmalWinds				= mod:NewTargetAnnounce(181957, 4)--Announce to all, for things like life grips, body and soul, etc to keep them on platform while anzu person helps clear them.
local warnPhantasmalWounds				= mod:NewTargetAnnounce(182325, 2, nil, "Healer")
local warnPhantasmalCorruption			= mod:NewTargetAnnounce(181824, 3)
local warnPhantasmalFelBomb				= mod:NewTargetAnnounce(179219, 3, nil, false)--Fake fel bombs, they'll show up on radar but don't need to know targets if person with anzu isn't terrlbe at game. they have 5 seconds to find and throw to ONE target.
local warnFelBomb						= mod:NewTargetAnnounce(181753, 3)
local warnDarkBindings					= mod:NewTargetAnnounce(185510, 4)--Mythic (Chains of Despair Debuff)
local warnFelChakram					= mod:NewTargetAnnounce(182178, 4)
local warnLaser							= mod:NewTargetAnnounce(182582, 3)
local warnFelConduit					= mod:NewCastAnnounce(181827, 3, nil, nil, "-Healer")

local specWarnThrowAnzu					= mod:NewSpecialWarning("specWarnThrowAnzu", nil, nil, nil, 1, 5)
local specWarnFocusedBlast				= mod:NewSpecialWarningCount(181912, nil, nil, nil, 2)
local specWarnPhantasmalWinds			= mod:NewSpecialWarningYou(181957, nil, nil, nil, 3)
local yellPhantasmalWinds				= mod:NewYell(181957)--So person with eye can see where the targets are faster
local specWarnPhantasmalWounds			= mod:NewSpecialWarningYou(182325, false)
local yellPhantasmalWounds				= mod:NewYell(182325, nil, false)--Can't see much reason to have THIS one on by default, but offered as an option.
local specWarnPhantasmalCorruption		= mod:NewSpecialWarningYou(181824)--Not move away on purpose, correct way to handle is get eye of anzu, you do NOT move
local yellPhantasmalCorruption			= mod:NewYell(181824)--For eye of anzu holder. Explosion shouldn't happen.
local specWarnPhantasmalFelBomb			= mod:NewSpecialWarningYou(179219)--Not move away on purpose, correct way to handle is get eye of anzu to real fel bomb
local yellPhantasmalFelBomb				= mod:NewYell(179219, nil, false)--Fake bombs off by default, they will never explode and eye of anzu holder will get distracted
local specWarnFelBomb					= mod:NewSpecialWarningYou(181753)--Not move away on purpose, correct way to handle is get eye of anzu, you do NOT move
local yellFelBomb						= mod:NewYell(181753)--Yell for real fel bomb on by default only
local specWarnFelBombDispel				= mod:NewSpecialWarningDispel(181753, nil, nil, nil, 1, 2)--Doesn't need option default, it's filtered by anzu check
local specWarnFelLaser					= mod:NewSpecialWarningMoveAway(182582, nil, nil, nil, 1, 2)
local yellFelLaser						= mod:NewYell(182582)
local specWarnDarkBindings				= mod:NewSpecialWarningYou(185510)--Mythic
local specWarnFelChakram				= mod:NewSpecialWarningMoveAway(182178, nil, nil, nil, 1, 2)
local specWarnFelChakramTank			= mod:NewSpecialWarningTaunt(182178, nil, nil, nil, 1, 2)
local specWarnFelConduit				= mod:NewSpecialWarningInterrupt(181827, nil, nil, nil, 1, 2)--On for everyone, filtered by eye of anzu, if this person can't interrupt, then they better pass it to someone who can

local timerFelLaserCD					= mod:NewCDTimer(19.5, 182582)--19.5-22. Never pauses, used all phases
local timerChakramCD					= mod:NewCDTimer(24.5, 182178)
local timerPhantasmalWindsCD			= mod:NewCDTimer(37, 181957)
local timerPhantasmalWoundsCD			= mod:NewCDTimer(30.5, 182325, nil, "Healer")--30.5-32
local timerFocusedBlast					= mod:NewCastTimer(11, 181912)--Doesn't realy need a cd timer. he casts it twice back to back, then lands
local timerDarkBindingsCD				= mod:NewCDTimer(34, 185456)
--Adds
local timerFelBombCD					= mod:NewCDTimer(18.5, 181753)
local timerFelConduitCD					= mod:NewCDTimer(15, 181827)
local timerPhantasmalCorruptionCD		= mod:NewCDTimer(14, 181824, nil, "Tank")--14-18

local berserkTimer						= mod:NewBerserkTimer(480)

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

mod.vb.focusedBlast = 0
mod.vb.savedChakram = nil
mod.vb.savedWinds = nil
mod.vb.savedWounds = nil
local playerHasAnzu = false
local corruption = GetSpellInfo(181824)
local phantasmalFelBomb = GetSpellInfo(179219)
local realFelBomb = GetSpellInfo(181753)
local darkBindings = GetSpellInfo(185510)
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

function mod:OnCombatStart(delay)
	self.vb.focusedBlast = 0
	self.vb.savedChakram = nil
	self.vb.savedWinds = nil
	self.vb.savedWounds = nil
	playerHasAnzu = false
	table.wipe(AddsSeen)
	updateRangeFrame(self)
	timerChakramCD:Start(5-delay)--Seems still 5 in all modes
	if self:IsNormal() then--Normal timers are about 40% slower on pull, 20% slower rest of fight
		timerFelLaserCD:Start(25)
		timerPhantasmalWindsCD:Start(30-delay)
		timerPhantasmalWoundsCD:Start(44-delay)
	else
		timerPhantasmalWindsCD:Start(16.5-delay)
		timerFelLaserCD:Start(18.5)--Verify it can still be this low, every pull on mythic was 20-22
		timerPhantasmalWoundsCD:Start(28-delay)
	end
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
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
			specWarnFelConduit:Show()
			if self:IsHealer() then--It's still on healer that did last dispel, they need to throw to better interruptor, probably tank
				specWarnThrowAnzu:Show(TANK)
				voiceThrowAnzu:Play("179202m") --throw to melee (maybe change to throw to tank, in strat i saw, it was best to bounce eye between tank and healer since throwing to tank also made immune to Phantasmal Corruption as added bonus)
			else
				voiceFelConduit:Play("kickcast")
			end
		else
			warnFelConduit:Show()
		end
	elseif spellId == 181873 then--Air phase start
		self.vb.focusedBlast = 0
		--Timers pause, save times
		self.vb.savedChakram = timerChakramCD:GetRemaining()
		self.vb.savedWinds = timerPhantasmalWindsCD:GetRemaining()
		self.vb.savedWounds = timerPhantasmalWoundsCD:GetRemaining()
		--Clear. Sure I could just do GetTime+39 and call it a day, but this is prettier
		timerChakramCD:Cancel()
		timerPhantasmalWindsCD:Cancel()
		timerPhantasmalWoundsCD:Cancel()
		timerDarkBindingsCD:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 182178 then
		if self:IsNormal() then
			timerChakramCD:Start(35)
		else
			timerChakramCD:Start()
		end
	elseif spellId == 181956 then
		if self:IsNormal() then
			timerPhantasmalWindsCD:Start(46)
		else
			timerPhantasmalWindsCD:Start()
		end
	elseif spellId == 181912 and self.vb.focusedBlast == 2 then--Air phase over immediately after he finishes casting 2nd blast.
		--Timers resume with +3-7, sometimes more. Extreme cases I suspect just got delayed by laser or some other channeled spell
		timerChakramCD:Start(self.vb.savedChakram+3)
		timerPhantasmalWindsCD:Start(self.vb.savedWinds+5)
		timerPhantasmalWoundsCD:Start(self.vb.savedWounds+5)
		self.vb.savedChakram = nil
		self.vb.savedWinds = nil
		self.vb.savedWounds = nil
	elseif spellId == 185510 then
		timerDarkBindingsCD:Start(args.sourceGUID)
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
		end
	elseif spellId == 181957 then
		warnPhantasmalWinds:CombinedShow(0.3, args.destName)
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
		timerPhantasmalCorruptionCD:Start(args.sourceGUID)
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
			specWarnPhantasmalFelBomb:Show()
			yellPhantasmalFelBomb:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(15)
			end
		end
	elseif spellId == 181753 then
		warnFelBomb:Show(args.destName)
		if self:IsNormal() then
			timerFelBombCD:Start(23, args.sourceGUID)
		else
			timerFelBombCD:Start(args.sourceGUID)
		end
		if args:IsPlayer() then
			updateRangeFrame(self)
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
		if playerHasAnzu and self:AntiSpam(3, 1) then
			specWarnThrowAnzu:Show(args.spellName)
			voiceThrowAnzu:Play("179202")
		end
	elseif spellId == 182178 or spellId == 182200 then
		warnFelChakram:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFelChakram:Show()
			voiceFelChakram:Play("runout")
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
	elseif spellId == 181957 and self.Options.SetIconOnWind then
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
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
		if self.Options.SetIconOnFelBomb then
			self:SetIcon(args.destName, 0)
		end
	end
end

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
			elseif cid == 91541 then--Shadowfel Warden
				timerFelConduitCD:Start(4, unitGUID)
			elseif cid == 91539 then--Fel Raven
				timerPhantasmalCorruptionCD:Start(16, unitGUID)
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
	elseif cid == 91541 then--Shadowfel Warden
		timerFelConduitCD:Cancel(args.destGUID)
	elseif cid == 91539 then--Fel Raven
		timerPhantasmalCorruptionCD:Cancel(args.destGUID)
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

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
