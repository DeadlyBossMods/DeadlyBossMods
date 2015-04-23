local mod	= DBM:NewMod(1433, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90316)
mod:SetEncounterID(1788)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--Unknown full spectrum of icons yet. Don't know how many debuffs go out.
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 181912 182216 181827 187998",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 179202 181957 182325 187990 181824 179219 185510 181753 182178 182200",
	"SPELL_AURA_REMOVED 179202 181957 182325 187990 181824 179219 185510 181753",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, not a chance in hell 182582 (Fel Incineration) is in combat log as a fixate debuff. Find real debuff, or WHISPER event, and add it.
--TODO, hopefully phantasmalWinds isn't the entire raid. that's going to be spammy mess if it is.
--TODO, really need ot see fight to get voices right, so most not added yet
--TODO, figure out how cooldowns work, maybe specials are on a shared cd and boss has phases? maybe all his crap has cds, can any of it overlap?
--TODO, if it's confirmed certain abiltiies don't overlap, refine icon options to be more compatible with one another.
local warnEyeofAnzu						= mod:NewTargetAnnounce(179202, 1)--EVERYONE needs to know where this is, at all times.
local warnPhantasmalWinds				= mod:NewTargetAnnounce(181957, 3)--Announce to all, for things like life grips, body and soul, etc to keep them on platform while anzu person helps clear them.
local warnPhantasmalWounds				= mod:NewTargetAnnounce(182325, 3, nil, "Healer")
local warnPhantasmalCorruption			= mod:NewTargetAnnounce(181824, 3, nil, "Tank")
local warnPhantasmalFelBomb				= mod:NewTargetAnnounce(179219, 3, nil, false)--Fake fel bombs, they'll show up on radar but don't need to know targets if person with anzu isn't terrlbe at game. they have 5 seconds to find and throw to ONE target.
local warnFelBomb						= mod:NewTargetAnnounce(181753, 3)
local warnDarkBindings					= mod:NewTargetAnnounce(185510, 3)--Mythic (Chains of Despair Debuff)
local warnIskarWarriorBird				= mod:NewAnnounce("Iskar, Warrior Bird", 3, 182216)--Can have a little fun with the PTR right?
local warnFelChakram					= mod:NewTargetAnnounce(182178, 3)
local warnFelConduit					= mod:NewCastAnnounce(181827, 3, nil, nil, "-Healer")

local specWarnThrowAnzu					= mod:NewSpecialWarning("specWarnThrowAnzu")
local specWarnFocusedBlast				= mod:NewSpecialWarningSpell(181912, nil, nil, nil, 2)
local specWarnPhantasmalWinds			= mod:NewSpecialWarningYou(181957)
local yellPhantasmalWinds				= mod:NewYell(181957)--So person with eye can see where the targets are faster
local specWarnPhantasmalWounds			= mod:NewSpecialWarningYou(182325, false)
local yellPhantasmalWounds				= mod:NewYell(182325, nil, false)--Can't see much reason to have THIS one on by default, but offered as an option.
local specWarnPhantasmalCorruption		= mod:NewSpecialWarningYou(181824)--Not move away on purpose, correct way to handle is get eye of anzu, you do NOT move
local yellPhantasmalCorruption			= mod:NewYell(181824)--For eye of anzu holder. Explosion shouldn't happen.
local specWarnPhantasmalFelBomb			= mod:NewSpecialWarningYou(179219)--Not move away on purpose, correct way to handle is get eye of anzu to real fel bomb
local yellPhantasmalFelBomb				= mod:NewYell(179219, nil, false)--Fake bombs off by default, they will never explode and eye of anzu holder will get distracted
local specWarnFelBomb					= mod:NewSpecialWarningYou(181753)--Not move away on purpose, correct way to handle is get eye of anzu, you do NOT move
local yellFelBomb						= mod:NewYell(181753)--Yell for real fel bomb on by default only
local specWarnFelBombDispel				= mod:NewSpecialWarningDispel(181753)--Doesn't need option default, it's filtered by mods anzu check
local specWarnDarkBindings				= mod:NewSpecialWarningYou(185510)--Mythic
local specWarnFelChakram				= mod:NewSpecialWarningMoveAway(182178)--This one you DO move away, it's not dispelled by eye of anzu
local specWarnFelConduit				= mod:NewSpecialWarningInterrupt(181827, nil, nil, nil, 1, nil, 2)--On for everyone, filtered by eye of anzu, if this person can't interrupt, then they better pass it to someone who can

--local timerFocusedBlastCD				= mod:NewCDTimer(107, 181912)
--local timerPhantasmalWindsCD			= mod:NewCDTimer(107, 181957)
--local timerPhantasmalWoundsCD			= mod:NewCDTimer(107, 182325)
--local timerPhantasmalCorruptionCD		= mod:NewCDTimer(107, 181824)
--local timerPhantasmalFelBombCD		= mod:NewCDTimer(107, 179219)
--local timerDarkBindingsCD				= mod:NewCDTimer(107, 185456)

--local berserkTimer					= mod:NewBerserkTimer(360)

--local countdownInfernoSlice			= mod:NewCountdown(12, 155080, "Tank")

local voiceFocusedBlast					= mod:NewVoice(181912)--gather
local voiceFelConduit					= mod:NewVoice(181827)--kickcast
local voiceFelChakram					= mod:NewVoice(182178)--runout

mod:AddRangeFrameOption(15)--Both aoes are 15 yards, ref 187991 and 181748
mod:AddSetIconOption("SetIconOnAnzu", 179909)--Star icon used, because they are the "Star" of the show, yes?
mod:AddSetIconOption("SetIconOnWinds", 181957, false)
mod:AddSetIconOption("SetIconOnWounds", 182325, false)
mod:AddSetIconOption("SetIconOnFelBomb", 181753, true)--One of the two commented out has to go, can't do both, what's more important?

local playerHasAnzu = false
local corruption = GetSpellInfo(181824)
local phantasmalFelBomb = GetSpellInfo(179219)
local realFelBomb = GetSpellInfo(181753)
local darkBindings = GetSpellInfo(185510)

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
	playerHasAnzu = false
	updateRangeFrame(self)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 181912 then
		specWarnFocusedBlast:Show()
		if not UnitDebuff("player", corruption) and not UnitDebuff("player", realFelBomb) and not UnitDebuff("player", phantasmalFelBomb) and not UnitDebuff("player", darkBindings) then--Filter debuffs that kill other players
			voiceFocusedBlast:Play("gather")
		end
	elseif spellId == 182216 then
		warnIskarWarriorBird:Show()
	elseif spellId == 181827 or spellId == 187998 then--Both versions of it. I assume the 5 second version is probably LFR/Normal
		if playerHasAnzu then--Able to interrupt
			--Maybe check role, if is Healer, call out to throw to a better interuptor instead of interrupt warning. Not sure there really is enough time for that though.
			specWarnFelConduit:Show()
			voiceFelConduit:Play("kickcast")
		else
			warnFelConduit:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155326 then
		
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
		if self.Options.SetIconOnWinds then
			self:SetSortedIcon(0.5, args.destName, 3)--Start at 2 and count up
		end
	elseif spellId == 182325 then
		warnPhantasmalWounds:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnPhantasmalWounds:Show()
			yellPhantasmalWounds:Yell()
		end
		if self.Options.SetIconOnWounds then
			self:SetSortedIcon(0.5, args.destName, 8, nil, true)--Start at 8 and count down
		end
	elseif spellId == 181824 or spellId == 187990 then
		warnPhantasmalCorruption:Show(args.destName)
		if args:IsPlayer() then
			updateRangeFrame(self)
			specWarnPhantasmalCorruption:Show()
			yellPhantasmalCorruption:Yell()
		else
			if playerHasAnzu then
				specWarnThrowAnzu(args.destName)
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
				else--Cannot dispel, get eye to a healer asap!
					specWarnThrowAnzu(HEALER)
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
	elseif spellId == 182178 or spellId == 182200 then
		warnFelChakram:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFelChakram:Show()
			voiceFelChakram:Play("runout")
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
	elseif spellId == 182325 and self.Options.SetIconOnWounds then
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

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 173195 then
		
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
