local mod	= DBM:NewMod(1372, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90199)
mod:SetEncounterID(1783)
mod:SetZone()
mod:SetUsedIcons(2, 1)
mod:SetRespawnTime(30)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 181973 181582 187814",
	"SPELL_CAST_SUCCESS 179977 181085",
	"SPELL_AURA_APPLIED 179864 179977 179909 179908 180148 181295 185982",
	"SPELL_AURA_REMOVED 179909 179908 181295 181973 185982",
	"SPELL_PERIODIC_DAMAGE 179995",
	"SPELL_ABSORBED 179995",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Note, surging shadows every 7-13 seconds, with a 1 second cast time. too variable, too short to have warnings or timers. so just keep range frame up whole fight.
--TODO< i'm still not sure crushing darkness is needed. I mean yeah it's avoidable, but even when not trying to avoid it, it rarely hit anything but pets. max melee range alone seems to avoid.
--TODO, UNIT_DIED and add timers for bellowingshout?
--TODO, more voices? "run to player"? "Shadow of Death"?
local warnShadowofDeath					= mod:NewTargetAnnounce(179864, 3)
local warnTouchofDoom					= mod:NewTargetAnnounce(179978, 4)
local warnSharedFate					= mod:NewTargetAnnounce(179909, 4)--Announce all 2/3
local warnHungerforLife					= mod:NewTargetAnnounce(180148, 3, nil, false)--Knowing who has it not very important, only if it's on you
local warnGoreboundSpiritSoon			= mod:NewSoonAnnounce("ej11020", 3, 187814)
local warnRagingCharge					= mod:NewSpellAnnounce(187814, 3, nil, "Melee")
local warnCrushingDarkness				= mod:NewCastAnnounce(180017, 3, 6, nil, "Melee")

local specWarnShadowofDeath				= mod:NewSpecialWarningYou(179864, nil, nil, nil, 1, 5)
local specWarnShadowofDeathTank			= mod:NewSpecialWarningTaunt(179864)
local specWarnTouchofDoom				= mod:NewSpecialWarningRun(179977, nil, nil, nil, 4, 2)
local yellTouchofDoom					= mod:NewYell(179977)
local specWarnDoomWell					= mod:NewSpecialWarningMove(179995)
local specWarnSharedFate				= mod:NewSpecialWarningMoveTo(179908, nil, nil, nil, 3, 2)--Only non rooted player get moveto. rooted player can't do anything.
local yellSharedFate					= mod:NewYell(179909)--Only rooted player should yell
local specWarnFeastofSouls				= mod:NewSpecialWarningSpell(181973, nil, nil, nil, 2)--Energy based
local specWarnFeastofSoulsEnded			= mod:NewSpecialWarningEnd(181973)
local specWarnHungerforLife				= mod:NewSpecialWarningRun(180148, nil, nil, nil, 4, 2)
local specWarnEnragedSpirit				= mod:NewSpecialWarningSwitch("ej11378", "-Healer")
local specWarnGoreboundSpirit			= mod:NewSpecialWarningSwitch("ej11020", "-Healer")
local specWarnBellowingShout			= mod:NewSpecialWarningInterrupt(181582, "-Healer", nil, nil, 1, 2)

local timerShadowofDeathCD				= mod:NewNextCountTimer(30, 179864)--Sequenced timer, uses table.
local timerTouchofDoomCD				= mod:NewNextTimer(18, 179977)
local timerSharedFateCD					= mod:NewCDTimer(29, 179909)--29-31
local timerCrushingDarknessCD			= mod:NewNextTimer(10, 179909, nil, "Melee")--Actually 16, but i delay start by 6 seconds for reduced spam
local timerFeastofSouls					= mod:NewCDTimer(123.5, 181973)--Probably next timer too, or close to it, depends how consistent energy gains are, may have small variation, like gruul

local timerDigest						= mod:NewCastTimer(40, 181295)
local timerCrushingDarkness				= mod:NewCastTimer(6, 180017, nil, "Melee")

--local berserkTimer					= mod:NewBerserkTimer(360)

local countdownShadowofDeath			= mod:NewCountdownFades("Alt5", 179864)
local countdownDigest					= mod:NewCountdown("Alt40", 181295)

local voiceTouchofDoom					= mod:NewVoice(179977)--runout
local voiceHungerforLife				= mod:NewVoice(180148)--justrun
local voiceBellowingShout				= mod:NewVoice(181582, "-Healer")--kickcast
local voiceShadowofDeath				= mod:NewVoice(179864)--teleyou, new voice, teleport into a new phase phase
local voiceSharedFate					= mod:NewVoice(179909)--linegather, new voice, like Blood-Queen Lana'thel's Pact of the Darkfallen, line gather will be better.

mod:AddSetIconOption("SetIconOnFate", 179909)
mod:AddHudMapOption("HudMapOnSharedFate", 179909)--Smart hud, distinquishes rooted from non rooted by color coding.
mod:AddArrowOption("SharedFateArrow", 179909, true, 2)
mod:AddRangeFrameOption(5, 182049)

mod.vb.rootedFate = nil
mod.vb.rootedFate2 = nil--Just in case, but if this happens you're doing things badly
mod.vb.shadowOfDeathCount = 0
local playerDown = false
local shadowofDeathTimers = {2, 11, 17, 7, 28, 8}--4 targets, 1 tank, 2 targets, 3 targets, 1 target, 3 targets (for LFR, scaling alters it some but ratios should be similar in all modes)

function mod:OnCombatStart(delay)
	self.vb.rootedFate = nil
	self.vb.rootedFate2 = nil
	self.vb.shadowOfDeathCount = 0
	playerDown = false
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
--	timerShadowofDeathCD:Start(2-delay, 1)--It's 2 seconds, needed?
	timerCrushingDarknessCD:Start(5-delay)
	timerTouchofDoomCD:Start(9-delay)
	timerSharedFateCD:Start(19-delay)
	timerFeastofSouls:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnSharedFate then
		DBMHudMap:Disable()
	end
end 

local function sharedFateDelay(self)
	if self.vb.rootedFate2 then--Check this first, assume you are linked to most recent
		specWarnSharedFate:Show(self.vb.rootedFate2)
		voiceSharedFate:Play("linegather")
	elseif self.vb.rootedFate then
		specWarnSharedFate:Show(self.vb.rootedFate)
		voiceSharedFate:Play("linegather")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 181973 then
		specWarnFeastofSouls:Show()
	elseif spellId == 181582 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnBellowingShout:Show(args.sourceName)
		voiceBellowingShout:Play("kickcast")
	elseif spellId == 187814 then
		warnRagingCharge:Show(args.sourceName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 179977 then
		timerTouchofDoomCD:Start()
	elseif spellId == 181085 then
		timerSharedFateCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 179864 then
		if self:AntiSpam(5, 4) then
			self.vb.shadowOfDeathCount = self.vb.shadowOfDeathCount + 1
			local cooldown = shadowofDeathTimers[self.vb.shadowOfDeathCount+1]
			if cooldown then
				timerShadowofDeathCD:Start(cooldown, self.vb.shadowOfDeathCount+1)
			end
		end
		warnShadowofDeath:CombinedShow(0.5, self.vb.shadowOfDeathCount, args.destName)
		if args:IsPlayer() then
			specWarnShadowofDeath:Show()
			countdownShadowofDeath:Start()
			voiceShadowofDeath:Play("teleyou")
		end
		--Check if it's a tank (todo, maybe just change it to count == 2 to reduce cpu, the tank is pretty much always 2/6
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") and not UnitIsUnit("player", uId) then
			--It is a tank and we're not tanking. Fire taunt warning
			specWarnShadowofDeathTank:Show(args.destName)
		end
	elseif spellId == 179977 then
		if not playerDown then
			warnTouchofDoom:CombinedShow(0.5, args.destName)
		end
		if args:IsPlayer() then
			specWarnTouchofDoom:Show()
			voiceTouchofDoom:Play("runout")
			yellTouchofDoom:Yell()
		end
	elseif spellId == 179909 then--Root version
		if not playerDown then
			warnSharedFate:CombinedShow(0.5, args.destName)
		end
		if self.vb.rootedFate then--One already exists
			self.vb.rootedFate2 = args.destName
		else
			self.vb.rootedFate = args.destName
		end
		if self.Options.SetIconOnFate then
			if self.vb.rootedFate2 then
				self:SetIcon(args.destName, 2)
			else
				self:SetIcon(args.destName, 1)
			end
		end
		if self.Options.HudMapOnSharedFate and not playerDown then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(179909, "highlight", args.destName, 3.5, 900, 1, 0, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)--Red
		end
		if args:IsPlayer() then
			yellSharedFate:Yell()
		end
	elseif spellId == 179908 then--Non root version (must run to rooted player)
		warnSharedFate:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			self:Schedule(0.5, sharedFateDelay, self)--Just in case rooted ID fires after non rooted ones
		end
		if self.Options.HudMapOnSharedFate then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(179908, "highlight", args.destName, 3.5, 900, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)--Yellow
		end
	elseif spellId == 180148 then
		warnHungerforLife:CombinedShow(0.5, args.destName)--More than 1 target?
		if args:IsPlayer() then
			specWarnHungerforLife:Show()
			voiceHungerforLife:Play("justrun")
		end
	elseif spellId == 181295 and args:IsPlayer() then
		timerDigest:Start()
		countdownDigest:Start()
		playerDown = true
	elseif spellId == 185982 and not playerDown then--Cast when a Enraged Spirit in stomach reaches 70%
		warnGoreboundSpiritSoon:Show()
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 179909 then--Root version
		if self.vb.rootedFate == args.destName then
			self.vb.rootedFate = nil
		elseif self.vb.rootedFate2 == args.destName then
			self.vb.rootedFate2 = nil
		end
		if self.Options.HudMapOnSharedFate then
			DBMHudMap:FreeEncounterMarkerByTarget(179909, args.destName)
		end
		if self.Options.SetIconOnFate then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 179908 then--Non root version (must run to rooted player)
		if self.Options.HudMapOnSharedFate then
			DBMHudMap:FreeEncounterMarkerByTarget(179908, args.destName)
		end
	elseif spellId == 181295 and args:IsPlayer() then
		timerDigest:Cancel()
		countdownDigest:Cancel()
		playerDown = false
	elseif spellId == 181973 then--Phase restart
		self.vb.shadowOfDeathCount = 0
		specWarnFeastofSoulsEnded:Show()
		--Timers exactly same as pull
		--timerShadowofDeathCD:Start(2, 1)
		timerCrushingDarknessCD:Start(5)
		timerTouchofDoomCD:Start(9)
		timerSharedFateCD:Start(19)
		timerFeastofSouls:Start()--This I can't confirm, but since others are same, hoping this is also the same
	elseif spellId == 185982 and not playerDown then
		--When it fades, it means it's casting Expel Soul and returning to surface as a Gorebound Spirit
		--This is cleaner than IEEU and fires at same time
		specWarnGoreboundSpirit:Show()
	end
end


function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 180016 and self:AntiSpam(2, 1) then--Crushing Darkness
		warnCrushingDarkness:Show()
		timerCrushingDarkness:Start()
		timerCrushingDarknessCD:Schedule(6)--Delay timer by 6 seconds, so it doesn't start until after cast timer ends, reduce timer spam
	--"<39.51 18:23:36> [UNIT_SPELLCAST_SUCCEEDED] Gorefiend(Slootbag) [[boss1:Empower Spirits::0:180192]]", -- [2949]
	--"<41.98 18:23:38> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#boss1#true#true#true#Gorefiend#Vehicle-0-2012-1448-7347-90199-0000381EB8#elite#375918859#boss2#true#true#true#Gorebound Spirit
	elseif spellId == 185753 and playerDown then--Tank Add Exploit Protection (Enraged Spirit Spawn)
		specWarnEnragedSpirit:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 179995 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnDoomWell:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
