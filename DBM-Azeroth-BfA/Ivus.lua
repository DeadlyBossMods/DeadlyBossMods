local dungeonID, creatureID
local breathId, strikeId, gtfoId
if UnitFactionGroup("player") == "Alliance" then
	dungeonID, creatureID = 2345, 148295--Ivus the Decayed
	breathId, strikeId, gtfoId = 287537, 287549, 287538
else--Horde
	dungeonID, creatureID = 2329, 144946--Ivus the Forest Lord
	breathId, strikeId, gtfoId = 282404, 282489, 282414
end
local mod	= DBM:NewMod(dungeonID, "DBM-Azeroth-BfA", 4, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(creatureID)
--mod:SetEncounterID(2263)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282404 287537 282463 282486 287549 282615 287554",
	"SPELL_AURA_APPLIED 282414 287538",
	"SPELL_AURA_REMOVED 282615 287554"
)

local warnPetrify						= mod:NewSpellAnnounce(282615, 2, nil, nil, nil, nil, nil, 2)
local warnPetrifyEnded					= mod:NewEndAnnounce(282615, 2, nil, nil, nil, nil, nil, 2)

local specWarnBreath					= mod:NewSpecialWarningSpell(breathId, nil, nil, nil, 1, 2)
local specWarnShockwaveYou				= mod:NewSpecialWarningYou(282463, nil, nil, nil, 1, 2)
local specWarnShockwaveClose			= mod:NewSpecialWarningClose(282463, nil, nil, nil, 1, 2)
local specWarnShockwave					= mod:NewSpecialWarningDodge(282463, nil, nil, nil, 2, 2)
local specWarnGroundSpell				= mod:NewSpecialWarningSpell(strikeId, nil, nil, nil, 3, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(gtfoId, nil, nil, nil, 1, 8)

local timerBreathCD						= mod:NewCDTimer(71.5, breathId, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--71-76?
local timerShockwaveCD					= mod:NewCDTimer(23, 282463, nil, nil, nil, 3)--23-25
local timerGroundSpellCD				= mod:NewCDTimer(71.5, strikeId, nil, nil, nil, 3)--71-76?

function mod:ShockwaveTarget(targetname, uId)
	if not targetname then
		specWarnShockwave:Show()
		specWarnShockwave:Play("shockwave")
		return
	end
	if targetname == UnitName("player") then
		specWarnShockwaveYou:Show()
		specWarnShockwaveYou:Play("runaway")
	elseif self:CheckNearby(10, targetname) then
		specWarnShockwaveClose:Show(targetname)
		specWarnShockwaveClose:Play("runaway")
	else
		specWarnShockwave:Show()
		specWarnShockwave:Play("shockwave")
	end
end

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerBreathCD:Start(1-delay)
		--timerShockwaveCD:Start(1-delay)
		--timerGroundSpellCD:Start(1-delay)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 282404 or spellId == 287537 then
		specWarnBreath:Show()
		specWarnBreath:Play("breathsoon")
		--timerBreathCD:Start()
	elseif spellId == 282463 then
		timerShockwaveCD:Start()
		self:BossTargetScanner(args.sourceGUID, "ShockwaveTarget", 0.2, 5)
	elseif spellId == 282486 or spellId == 287549 then
		specWarnGroundSpell:Show()
		specWarnGroundSpell:Play("watchstep")
		--timerGroundSpellCD:Start()
	elseif spellId == 282615 or spellId == 287554 then
		warnPetrify:Show()
		warnPetrify:Play("phasechange")
		timerShockwaveCD:Stop()
		timerBreathCD:Stop()
		timerGroundSpellCD:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if (spellId == 282414 or spellId == 287538) and args:IsPlayer() then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 282615 or spellId == 287554 then
		warnPetrifyEnded:Show()
		warnPetrifyEnded:Play("phasechange")
		--Horde
		--"<68.97 22:37:20> [CLEU] SPELL_AURA_REMOVED#Creature-0-3133-1-14200-144946-00001081D1#Ivus the Forest Lord#Creature-0-3133-1-14200-144946-00001081D1#Ivus the Forest Lord#282615#Petrify#BUFF#nil", -- [1876]
		--"<85.15 22:37:36> [CLEU] SPELL_CAST_START#Creature-0-3133-1-14200-144946-00001081D1#Ivus the Forest Lord##nil#282463#Shockwave#nil#nil", -- [2224]
		--"<91.25 22:37:42> [CLEU] SPELL_CAST_START#Creature-0-3133-1-14200-144946-00001081D1#Ivus the Forest Lord##nil#282404#Frost Breath#nil#nil", -- [2367]
		--"<97.46 22:37:48> [CLEU] SPELL_CAST_START#Creature-0-3133-1-14200-144946-00001081D1#Ivus the Forest Lord##nil#282486#Lunar Strike#nil#nil", -- [2556]
		--Alliance
		--"<72.32 15:24:21> [CLEU] SPELL_AURA_REMOVED#Creature-0-3888-1-1949-148295-0000194E89#Ivus the Decayed#Creature-0-3888-1-1949-148295-0000194E89#Ivus the Decayed#287554#Petrify#BUFF#nil"
		--"<88.78 15:24:37> [CLEU] SPELL_CAST_START#Creature-0-3888-1-1949-148295-0000194E89#Ivus the Decayed##nil#282463#Shockwave#nil#nil", -- [1152]
		--"<94.82 15:24:43> [CLEU] SPELL_CAST_START#Creature-0-3888-1-1949-148295-0000194E89#Ivus the Decayed##nil#287537#Plague Breath#nil#nil", -- [1370]
		--"<100.85 15:24:49> [CLEU] SPELL_CAST_START#Creature-0-3888-1-1949-148295-0000194E89#Ivus the Decayed##nil#287549#Fungal Bloom#nil#nil", -- [1584]
		timerShockwaveCD:Start(16.1)
		timerBreathCD:Start(22.2)
		timerGroundSpellCD:Start(28.4)
	end
end
