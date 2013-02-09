if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(824, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69427)
mod:SetModelID(47527)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"RAID_BOSS_WHISPER"
)

local warnCrimsonWake				= mod:NewTargetAnnounce(138480, 3)--Maybe target scannning will work faster, if not, i'll just sync the RAID_BOSS_WHISPER for highest accuracy (target scanning on multiple mobs with same creatureid and no bossX unit ID sucks)
local warnMatterSwap				= mod:NewTargetAnnounce(138609, 3)--Debuff.
local warnMatterSwapped				= mod:NewAnnounce("warnMatterSwapped", 3, 138618)--Actual swap(caused by dispel)

local specWarnCrimsonWakeYou		= mod:NewSpecialWarningRun(138480)--Kiter
local specWarnCrimsonWake			= mod:NewSpecialWarningMove(138485)--Standing in stuff left behind by kiter
local yellCrimsonWake				= mod:NewYell(138480)
local specWarnMatterSwap			= mod:NewSpecialWarningYou(138609)

local timerMatterSwap				= mod:NewTargetTimer(12, 138609)--If not dispelled, it ends after 12 seconds regardless

local soundCrimsonWake				= mod:NewSound(138480)

local crimsonWake = GetSpellInfo(138485)--Debuff ID I believe, not cast one. Same spell name though
local guids = {}
local guidTableBuilt = false--Entirely for DCs, so we don't need to reset between pulls cause it doesn't effect building table on combat start and after a DC then it will be reset to false always
local function buildGuidTable()
	table.wipe(guids)
	for uId, i in DBM:GetGroupMembers() do
		guids[UnitGUID(uId) or "none"] = GetRaidRosterInfo(i)
	end
end

function mod:OnCombatStart(delay)
	buildGuidTable()
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(138609) then
		warnMatterSwap:Show(args.destName)
		timerMatterSwap:Start(args.destName)
		if args:IsPlayer() then
			specWarnMatterSwap:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(138609) then
		timerMatterSwap:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 138485 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnCrimsonWake:Show()
	elseif spellId == 138618 then
		if not guidTableBuilt then
			buildGuidTable()
			guidTableBuilt = true
		end
		warnMatterSwapped:Show(spellName, guids[sourceGUID], guids[destGUID])
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

--"<83.8 14:59:54> [RAID_BOSS_WHISPER] RAID_BOSS_WHISPER#%s is pursuing you!#Crimson Wake#1#false", -- [5382]
--Seems to have no debuff event on combat log. Could possibly use UNIT_AURA, but this should be less cpu and since we can do it without localizing, no harm in doing it this way.
--Now, if target scanning doesn't work, may switch to unit aura to detect it on players other than self without requiring syncing.
function mod:RAID_BOSS_WHISPER(msg, npc)
	if npc == crimsonWake then--In case target scanning fails, personal warnings still always go off. Target scanning is just so everyone else in raid knows who it's on (since only target sees this emote)
		if self:AntiSpam(3, 1) then--This actually doesn't spam, but we ues same antispam here so that the MOVE warning doesn't fire at same time unless you fail to move for 2 seconds
			specWarnCrimsonWakeYou:Show()
		end
		yellCrimsonWake:Yell()
		soundCrimsonWake:Play()
		self:SendSync("WakeTarget", UnitGUID("player"))
	end
end

function mod:OnSync(msg, guid)
	if not guidTableBuilt then
		buildGuidTable()
		guidTableBuilt = true
	end
	if msg == "WakeTarget" and guids[guid] then
		warnCrimsonWake:Show(guids[guid])
	end
end

