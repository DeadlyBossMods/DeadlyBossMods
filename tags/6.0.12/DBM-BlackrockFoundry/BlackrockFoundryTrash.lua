local mod	= DBM:NewMod("BlackrockFoundryTrash", "DBM-BlackrockFoundry")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 11326 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true
--[[
mod:RegisterEvents(
	"SPELL_AURA_APPLIED 147200 147328 145553",
	"SPELL_CAST_START 146728 147884",
	"RAID_BOSS_WHISPER"
)

local warnWarBanner					= mod:NewSpellAnnounce(147328, 3)
local warnFracture					= mod:NewTargetAnnounce(147200, 3)
local warnChainHeal					= mod:NewCastAnnounce(146728, 4)
local warnBribe						= mod:NewTargetAnnounce(145553, 3, nil, false)--Off by default because it's not useful to most people, and in LFR they are dumb enough to think you're supposed to switch to this target if it has an alert. I like having it though to warn for optential tank/healer MCs
local warnInfusion					= mod:NewSpellAnnounce(147884, 3, nil, "Tank")
local warnLockedOn					= mod:NewTargetAnnounce(146680, 3)

local specWarnWarBanner				= mod:NewSpecialWarningSwitch(147328, "-Healer")
local specWarnFracture				= mod:NewSpecialWarningTarget(147200, false)
local specWarnChainheal				= mod:NewSpecialWarningInterrupt(146728)
local specWarnInfusion				= mod:NewSpecialWarningMove("OptionVersion2", 147884, "Tank")
local specWarnLockedOn				= mod:NewSpecialWarningRun(146680)
local specWarnCrawlerMineFixate		= mod:NewSpecialWarningYou("ej8212")

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local galakrasMod = DBM:GetModByName("868")--Because for first 10-20 seconds of galakras, EncounterInProcess() return false, so mod.isTrashMod = true won't filter first set of adds

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 147200 and not galakrasMod:IsInCombat() then
		warnFracture:Show(args.destName)
		specWarnFracture:Show(args.destName)
	elseif spellId == 147328 and not galakrasMod:IsInCombat() then
		warnWarBanner:Show()
		specWarnWarBanner:Show()
	elseif spellId == 145553 then
		warnBribe:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 146728 and not galakrasMod:IsInCombat() then
		local source = args.sourceName
		warnChainHeal:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnChainheal:Show(source)
		end
	elseif spellId == 147884 and self:AntiSpam(3) then
		warnInfusion:Show()
		specWarnInfusion:Show()
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if not self.Options.Enabled then return end
	if msg:find("Ability_Siege_Engineer_Superheated") then
		specWarnLockedOn:Show()
		self:SendSync("LockedOnTarget", UnitGUID("player"))
	elseif msg:find("Ability_Siege_Engineer_Detonate") then--Assumed trash same as boss for ths one too, I've never been targeted, i'm a tank
		specWarnCrawlerMineFixate:Show()
	end
end

function mod:OnSync(msg, guid)
	if msg == "LockedOnTarget" and guid and self.Options.Enabled then
		local targetName = DBM:GetFullPlayerNameByGUID(guid)
		warnLockedOn:Show(targetName)
	end
end--]]
