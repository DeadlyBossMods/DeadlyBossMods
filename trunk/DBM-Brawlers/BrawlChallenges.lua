local mod	= DBM:NewMod("BrawlChallenges", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
--mod:SetModelID(48465)
mod:SetZone()

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_AURA_APPLIED 141206 134650 142400 141371 141388 134624",
	"SPELL_AURA_APPLIED_DOSE 134624",
	"SPELL_AURA_REMOVED 134650",
	"SPELL_CAST_START 140868 140862 140886 135234 133650 133398 133262",
	"SPELL_CAST_SUCCESS 132670 133250",
	"UNIT_SPELLCAST_CHANNEL_START target focus"
)

local warnLumberingCharge			= mod:NewSpellAnnounce(134527, 4)--Goredome
local warnToughLuck					= mod:NewStackAnnounce(134624, 1)--Smash Hoofstomp
local warnShieldWaller				= mod:NewSpellAnnounce(134650, 2)--Smash Hoofstomp
local warnSummonTwister				= mod:NewSpellAnnounce(132670, 3)--Kirrawk
local warnStormCloud				= mod:NewSpellAnnounce(135234, 3)--Kirrawk
local warnSmolderingHeat			= mod:NewTargetNoFilterAnnounce(142400, 4)--Anthracite
local warnCooled					= mod:NewTargetNoFilterAnnounce(141371, 1)--Anthracite
local warnOnFire					= mod:NewTargetNoFilterAnnounce(141388, 4)--Anthracite
local warnRockPaperScissors			= mod:NewSpellAnnounce(141206, 3)--Ro-Shambo
local warnPowerCrystal				= mod:NewSpellAnnounce(133398, 3)--Millhouse Manastorm
local warnDoom						= mod:NewSpellAnnounce(133650, 4)--Millhouse Manastorm
local warnBlueCrush					= mod:NewSpellAnnounce(133262, 4)--Epicus Maximus
local warnDestructolaser			= mod:NewSpellAnnounce(133250, 4)--Epicus Maximus

local specWarnLumberingCharge		= mod:NewSpecialWarningDodge(134527)--Goredome
local specWarnStormCloud			= mod:NewSpecialWarningInterrupt(135234)--Kirrawk
local specWarnSmolderingHeat		= mod:NewSpecialWarningYou(142400)--Anthracite
local specWarnRPS					= mod:NewSpecialWarning("specWarnRPS")--Ro-Shambo
local specWarnDoom					= mod:NewSpecialWarningSpell(133650, nil, nil, nil, true)--Millhouse Manastorm
local specWarnBlueCrush				= mod:NewSpecialWarningInterrupt(133262, nil, nil, nil, 1, 2)--Epicus Maximus
local specWarnDestructolaser		= mod:NewSpecialWarningMove(133250, nil, nil, nil, 2, 1)--Epicus Maximus

local timerLumberingChargeCD		= mod:NewCDTimer(7, 134527, nil, nil, nil, 3)--Goredome
local timerShieldWaller				= mod:NewBuffActiveTimer(10, 134650)--Smash Hoofstomp
local timerSummonTwisterCD			= mod:NewCDTimer(15, 132670, nil, nil, nil, 3)--Kirrawk
local timerSmolderingHeatCD			= mod:NewCDTimer(20, 142400)--Anthracite
local timerCooled					= mod:NewTargetTimer(20, 141371, nil, nil, nil, 6)--Anthracite
local timerRockpaperScissorsCD		= mod:NewCDTimer(42, 141206, nil, nil, nil, 6)--Ro-Shambo
local timerPowerCrystalCD			= mod:NewCDTimer(13, 133398)--Millhouse Manastorm
local timerBlueCrushCD				= mod:NewCDTimer(19.4, 133262, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)--Epicus Maximus
local timerDestructolaserCD			= mod:NewNextTimer(30, 133250, nil, nil, nil, 3)--Epicus Maximus

mod:AddBoolOption("ArrowOnBoxing")--Ro-Shambo

local brawlersMod = DBM:GetModByName("Brawlers")
local lastRPS = DBM_CORE_UNKNOWN

--"<39.8 01:37:33> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#|TInterface\\Icons\\inv_inscription_scroll.blp:20|t %s Chooses |cFFFF0000Paper|r! You |cFF00FF00Win|r!#Ro-Shambo
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find(L.rock) then
		lastRPS = L.rock
	elseif msg:find(L.paper) then
		lastRPS = L.paper
	elseif msg:find(L.scissors) then
		lastRPS = L.scissors
	end
end

brawlersMod:OnMatchStart(function()
	lastRPS = DBM_CORE_UNKNOWN
end)

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 142400 then
		warnSmolderingHeat:Show(args.destName)
		timerSmolderingHeatCD:Start()
		if args:IsPlayer() then
			specWarnSmolderingHeat:Show()
		end
	elseif args.spellId == 134650 then
		warnShieldWaller:Show()
		timerShieldWaller:Start()
	elseif args.spellId == 141206 then
		warnRockPaperScissors:Show()
		timerRockpaperScissorsCD:Start()
		if brawlersMod:PlayerFighting() then
			if lastRPS == L.rock then--he's using paper this time
				specWarnRPS:Show(L.scissors)
			elseif lastRPS == L.paper then--He's using scissors this time
				specWarnRPS:Show(L.rock)
			elseif lastRPS == L.scissors then--he's using rock this time
				specWarnRPS:Show(L.paper)
			end
		end
	elseif args.spellId == 141371 then
		warnCooled:Show(args.destName)
		timerCooled:Start(args.destName)
	elseif args.spellId == 141388 then
		warnOnFire:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REMOVED = mod.SPELL_AURA_APPLIED_DOSE
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_APPLIED_DOSE

function mod:SPELL_AURA_REMOVED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 134650 then
		timerShieldWaller:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 140868 and self.Options.ArrowOnBoxing and brawlersMod:PlayerFighting() then--Left Hook
		DBM.Arrow:ShowStatic(270, 3)
	elseif args.spellId == 140862 and self.Options.ArrowOnBoxing and brawlersMod:PlayerFighting() then--Right Hook
		DBM.Arrow:ShowStatic(90, 3)
	elseif args.spellId == 140886 and self.Options.ArrowOnBoxing and brawlersMod:PlayerFighting() then--Right Hook
		DBM.Arrow:ShowStatic(180, 3)
	elseif args.spellId == 134624 then
		warnToughLuck:Show(args.destName, args.amount or 1)
	elseif args.spellId == 135234 then
		--CD seems to be 32 seconds usually but sometimes only 16? no timer for now
		if brawlersMod:PlayerFighting() then
			specWarnStormCloud:Show(args.sourceName)
		else
			warnStormCloud:Show()
		end
	elseif args.spellId == 133650 then
		if brawlersMod:PlayerFighting() then
			specWarnDoom:Show()
		else
			warnDoom:Show()
		end
	elseif args.spellId == 133398 then
		warnPowerCrystal:Show()
		timerPowerCrystalCD:Start()
	elseif args.spellId == 133262 then
		timerBlueCrushCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnBlueCrush:Show(args.sourceName)
			specWarnBlueCrush:Play("kickcast")
		else
			warnBlueCrush:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 132670 then
		warnSummonTwister:Show()
		timerSummonTwisterCD:Start()--22 seconds after combat start?
	elseif args.spellId == 133250 then
		timerDestructolaserCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnDestructolaser:Show()
			specWarnDestructolaser:Play("watchstep")
		else
			warnDestructolaser:Show()
		end
	end
end

--This event won't really work well for spectators if they target the player instead of boss. This event only fires if boss is on target/focus
--It is however the ONLY event you can detect this spell using.
function mod:UNIT_SPELLCAST_CHANNEL_START(uId, _, spellId)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if spellId == 134527 and self:AntiSpam() then
		timerLumberingChargeCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnLumberingCharge:Show()
		else
			warnLumberingCharge:Show()
		end
	end
end
