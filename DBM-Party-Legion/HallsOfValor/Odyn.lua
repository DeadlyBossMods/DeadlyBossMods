local mod	= DBM:NewMod(1489, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(95676)
mod:SetEncounterID(1809)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 197963 197964 197965 197966 197967",
	"SPELL_AURA_REMOVED 197963 197964 197965 197966 197967",
	"SPELL_CAST_START 198263 198077 198750",
	"SPELL_CAST_SUCCESS 197961",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--http://legion.wowhead.com/icons/name:boss_odunrunes_
--["198263-Radiant Tempest"] = "pull:8.0, 72.0, 40.0", huh?
local warnSpear						= mod:NewSpellAnnounce(198072, 2)--Target not available so no target warning.

local specWarnTempest				= mod:NewSpecialWarningRun(198263, nil, nil, nil, 4, 2)
local specWarnShatterSpears			= mod:NewSpecialWarningDodge(198077, nil, nil, nil, 2, 2)
local specWarnRunicBrand			= mod:NewSpecialWarningMoveTo(197961, nil, nil, nil, 2, 6)
local specWarnAdd					= mod:NewSpecialWarningSwitch(201221, "-Healer", nil, nil, 1, 2)
local specWarnSurge					= mod:NewSpecialWarningInterrupt(198750, "HasInterrupt", nil, nil, 1, 2)

--local timerSpearCD					= mod:NewCDTimer(8, 198077, nil, nil, nil, 3)--More data needed
local timerTempestCD				= mod:NewCDCountTimer(40, 198263, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)--More data needed
local timerShatterSpearsCD			= mod:NewCDTimer(56, 198077, nil, nil, nil, 2)
local timerRunicBrandCD				= mod:NewCDCountTimer(56, 197961, nil, nil, nil, 3)
local timerAddCD					= mod:NewCDTimer(54, 201221, nil, nil, nil, 1, 201215)--54-58

local voiceTempest					= mod:NewVoice(198263)--runout
local voiceShatterSpears			= mod:NewVoice(198077)--watchorb
local voiceRunicBrand				= mod:NewVoice(197961)--locations
local voiceAdd						= mod:NewVoice(201221, "-Healer")--killmob
local voiceSurge					= mod:NewVoice(198750, "HasInterrupt")--kickcast

--Boss has (at least) three timer modes, cannot determine which one on pull so on fly figuring out is used
local tempestTimers = {
	[1] = {8, 56, 72},
	[2] = {16, 48, 64},--If such a beast exists, it'll look like this based on theory. This sequence is COPMLETE guesswork
	[3] = {24, 40, 56},
	[4] = {32, 32, 48},--32 and 48 are guessed based on theory
}
local brandTimers = {44, 56}
mod.vb.temptestMode = 1
mod.vb.tempestCount = 0
mod.vb.brandCount = 0

mod:AddHudMapOption("HudMapForRunes", 197961, true)

--Should run at 10, 18, 26, and 34
local function tempestDelayed(self)
	if self.vb.tempestCount == 0 then
		DBM:AddMsg(L.tempestModeMessage:format(self.vb.temptestMode))
		self.vb.temptestMode = self.vb.temptestMode + 1
		self:Schedule(8, tempestDelayed, self)
		timerTempestCD:Start(6, 1)
	else
		return
	end
end

function mod:OnCombatStart(delay)
	self.vb.temptestMode = 1
	self.vb.tempestCount = 0
	self.vb.brandCount = 0
--	timerSpearCD:Start(-delay)
	timerTempestCD:Start(8-delay, 1)
	self:Schedule(10, tempestDelayed, self, 1)
	timerShatterSpearsCD:Start(40-delay)
	timerRunicBrandCD:Start(44-delay)
end

function mod:OnCombatEnd()
	if self.Options.HudMapForRunes then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 197963 and args:IsPlayer() then--Purple K (NE)
		specWarnRunicBrand:Show("NE")
		voiceRunicBrand:Play("frontright")
		if self.Options.HudMapForRunes then
			local m1 = DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 0.1, 12, 0, 1, 0, 0.5):Appear()--tiny dot for self, to create line PoO
			local m2 = DBMHudMap:RegisterPositionMarker(spellId, "OdunHelper", "odunpurple", 2437, 498, 3.5, 12, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
			m2:EdgeTo(m1, nil, 12, 0, 1, 0, 1)--Now draw line between player and rune
		end
	elseif spellId == 197964 and args:IsPlayer() then--Orange N (SE)
		specWarnRunicBrand:Show("SE")
		voiceRunicBrand:Play("backright")
		if self.Options.HudMapForRunes then
			local m1 = DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 0.1, 12, 0, 1, 0, 0.5):Appear()--tiny dot for self, to create line PoO
			local m2 = DBMHudMap:RegisterPositionMarker(spellId, "OdunHelper", "odunorange", 2403, 509, 3.5, 12, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
			m2:EdgeTo(m1, nil, 12, 0, 1, 0, 1)--Now draw line between player and rune
		end
	elseif spellId == 197965 and args:IsPlayer() then--Yellow H (SW)
		specWarnRunicBrand:Show("SW")
		voiceRunicBrand:Play("backleft")
		if self.Options.HudMapForRunes then
			local m1 = DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 0.1, 12, 0, 1, 0, 0.5):Appear()--tiny dot for self, to create line PoO
			local m2 = DBMHudMap:RegisterPositionMarker(spellId, "OdunHelper", "odunyellow", 2403, 548, 3.5, 12, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
			m2:EdgeTo(m1, nil, 12, 0, 1, 0, 1)--Now draw line between player and rune
		end
	elseif spellId == 197966 and args:IsPlayer() then--Blue fishies (NW)
		specWarnRunicBrand:Show("NW")
		voiceRunicBrand:Play("frontleft")
		if self.Options.HudMapForRunes then
			local m1 = DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 0.1, 12, 0, 1, 0, 0.5):Appear()--tiny dot for self, to create line PoO
			local m2 = DBMHudMap:RegisterPositionMarker(spellId, "OdunHelper", "odunblue", 2437, 559, 3.5, 12, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
			m2:EdgeTo(m1, nil, 12, 0, 1, 0, 1)--Now draw line between player and rune
		end
	elseif spellId == 197967 and args:IsPlayer() then--Green box (N)
		specWarnRunicBrand:Show("N")
		voiceRunicBrand:Play("frontcenter")--Does not exist yet
		if self.Options.HudMapForRunes then
			local m1 = DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 0.1, 12, 0, 1, 0, 0.5):Appear()--tiny dot for self, to create line PoO
			local m2 = DBMHudMap:RegisterPositionMarker(spellId, "OdunHelper", "odungreen", 2461, 528, 3.5, 12, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
			m2:EdgeTo(m1, nil, 12, 0, 1, 0, 1)--Now draw line between player and rune
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if (spellId == 197963 or spellId == 197964 or spellId == 197965 or spellId == 197966 or spellId == 197967) and args:IsPlayer() and self.Options.HudMapForRunes then--Odun runes
		DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		DBMHudMap:FreeEncounterMarkerByTarget(spellId, "OdunHelper")
		DBMHudMap:ClearAllEdges()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198072 then
		warnSpear:Show()
	elseif spellId == 198263 then
		self.vb.tempestCount = self.vb.tempestCount + 1
		specWarnTempest:Show(self.vb.tempestCount)
		voiceTempest:Play("runout")
--		timerSpearCD:Start(12)
		local timers = tempestTimers[self.vb.temptestMode]
		if timers then
			local nextCast = self.vb.tempestCount+1
			if timers[nextCast] then
				timerTempestCD:Start(timers[nextCast], nextCast)
			end
		end
	elseif spellId == 198077 then
		specWarnShatterSpears:Show()
		voiceShatterSpears:Play("watchorb")
		timerShatterSpearsCD:Start()
	elseif spellId == 198750 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnSurge:Show(args.sourceName)
		voiceSurge:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 197961 then
		self.vb.brandCount = self.vb.brandCount + 1
--		timerSpearCD:Start(18)
		local nextCount = self.vb.brandCount+1
		local timer = brandTimers[nextCount]
		if timer then
			timerRunicBrandCD:Start(timer, nextCount)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 198396 then
		warnSpear:Show()
	elseif spellId == 201221 then--Summon Stormforged
		specWarnAdd:Show()
		voiceAdd:Play("killmob")
		timerAddCD:Start()
	end
end
