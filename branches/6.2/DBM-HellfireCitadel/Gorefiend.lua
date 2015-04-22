local mod	= DBM:NewMod(1372, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91809)
mod:SetEncounterID(1783)
mod:SetZone()
mod:SetUsedIcons(2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 182049 181973 182788 181582",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 179864 179977 179909 179908 180148",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 179909 179908",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, figure out surging shadows. i see no player applied debuff ID
--TODO, figure out crushing darkness. probably a rapid cast sequence of 3-5 missles with a non special warning count warning
--TODO, use syncing for non stomach timers, hidden, but still saved, to use timer recovery when leaving stomach.
--TODO, UNIT_DIED and add timers for bellowingshout?
--TODO, more voices? "run to player"? "Shadow of Death"?
local warnShadowofDeath					= mod:NewTargetAnnounce(179864, 3)
local warnTouchofDoom					= mod:NewTargetAnnounce(179978, 4)
local warnSharedFate					= mod:NewTargetAnnounce(179909, 4)--Announce all 2/3
local warnHungerforLife					= mod:NewTargetAnnounce(180148, 3)

local specWarnShadowofDeath				= mod:NewSpecialWarningYou(179864)
local specWarnTouchofDoom				= mod:NewSpecialWarningRun(179977, nil, nil, nil, 4, nil, 2)
local specWarnSharedFate				= mod:NewSpecialWarningMoveTo(179908, nil, nil, nil, 3)--Only non rooted player get moveto. rooted player can't do anything.
local yellSharedFate					= mod:NewYell(179909)--Only rooted player should yell
local specWarnFeastofSouls				= mod:NewSpecialWarningSpell(181973, nil, nil, nil, 2)--Energy based, probably no cd, maybe add a soon announce off UNIT POWER
local specWarnHungerforLife				= mod:NewSpecialWarningRun(180148, nil, nil, nil, 4, nil, 2)
local specWarnBellowingShout			= mod:NewSpecialWarningInterrupt(181582, "-Healer", nil, nil, 1, nil, 2)

--local timerShadowofDeathCD			= mod:NewCDTimer(30, 179864)
--local timerTouchofDoomCD				= mod:NewCDTimer(45, 179977)
--local timerSharedFateCD				= mod:NewCDTimer(45, 179909)

--local berserkTimer					= mod:NewBerserkTimer(360)

local countdownShadowofDeath			= mod:NewCountdownFades("Alt5", 179864)
local countdownDigest					= mod:NewCountdown("Alt45", 155080)--40+5

local voiceTouchofDoom					= mod:NewVoice(179977)--runout
local voiceHungerforLife				= mod:NewVoice(180148)--justrun
local voiceBellowingShout				= mod:NewVoice(181582, "-Healer")--kickcast

mod:AddSetIconOption("SetIconOnFate", 179909)
mod:AddHudMapOption("HudMapOnSharedFate", 179909)--Smart hud, distinquishes rooted from non rooted by color coding.
mod:AddArrowOption("SharedFateArrow", 179909, true, 2)
mod:AddRangeFrameOption(5, 182049)--Needs to be optimized when surging shadows is figured out.

mod.vb.rootedFate = nil
mod.vb.rootedFate2 = nil--Just in case, but if this happens you're doing things badly

function mod:OnCombatStart(delay)
	self.vb.rootedFate = nil
	self.vb.rootedFate2 = nil
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
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
	elseif self.vb.rootedFate then
		specWarnSharedFate:Show(self.vb.rootedFate)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 182049 then
		DBM:Debug("Surging Shadows Cast", 2)
	elseif spellId == 181973 then
		specWarnFeastofSouls:Show()
	elseif spellId == 182788 then
		DBM:Debug("Crushing Darkness Cast", 2)
	elseif spellId == 181582 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnBellowingShout:Show(args.sourceName)
		voiceBellowingShout:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155326 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 179864 then
		warnShadowofDeath:CombinedShow(0.5, args.destName)--More than 1 target?
		if args:IsPlayer() then
			specWarnShadowofDeath:Show()
			countdownShadowofDeath:Start()
			countdownDigest:Start()
		end
	elseif spellId == 179977 then
		warnTouchofDoom:CombinedShow(0.5, args.destName)--More than 1 target?
		if args:IsPlayer() then
			specWarnTouchofDoom:Show()
			voiceTouchofDoom:Play("runout")
		end
	elseif spellId == 179909 then--Root version
		warnSharedFate:CombinedShow(0.5, args.destName)
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
		if self.Options.HudMapOnSharedFate then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(179909, "highlight", args.destName, 3, 900, 1, 1, 0, 0.5, nil, true):Pulse(0.5, 0.5)--Yellow
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
			DBMHudMap:RegisterRangeMarkerOnPartyMember(179908, "highlight", args.destName, 3, 900, 0, 1, 0, 0.5, nil, true):Pulse(0.5, 0.5)--Green
		end
	elseif spellId == 180148 then
		warnHungerforLife:CombinedShow(0.5, args.destName)--More than 1 target?
		if args:IsPlayer() then
			specWarnHungerforLife:Show()
			voiceHungerforLife:Play("justrun")
		end
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
