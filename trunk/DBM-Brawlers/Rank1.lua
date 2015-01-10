local mod	= DBM:NewMod("BrawlRank1", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(46327)--Last Boss of Rank 1
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 135342 132666 33975 136334 39945",
	"SPELL_AURA_APPLIED 134624 134650 126209",
	"SPELL_AURA_APPLIED_DOSE 134624",
	"SPELL_AURA_REMOVED 126209 134650",
	"UNIT_SPELLCAST_CHANNEL_START target focus"
)

local warnLumberingCharge		= mod:NewSpellAnnounce(134527, 4)--Goredome
local warnPyroblast				= mod:NewCastAnnounce(33975, 3)--Sanoriak
local warnFireWall				= mod:NewSpellAnnounce(132666, 4)--Sanoriak
local warnToughLuck				= mod:NewStackAnnounce(134624, 1)--Smash Hoofstomp
local warnShieldWaller			= mod:NewSpellAnnounce(134650, 2)--Smash Hoofstomp
local warnShadowStrikes			= mod:NewSpellAnnounce(126209, 3)--Akama
local warnChainLightning		= mod:NewSpellAnnounce(39945, 3)--Akama

local specWarnLumberingCharge	= mod:NewSpecialWarningDodge(134527)--Goredome
local specWarnFireWall			= mod:NewSpecialWarningSpell(132666)--Sanoriak
local specWarnShadowStrikes		= mod:NewSpecialWarningDispel(126209, mod:IsMagicDispeller())--Akama
local specWarnChainLightning	= mod:NewSpecialWarningInterrupt(39945)--Akama

local timerLumberingChargeCD	= mod:NewCDTimer(7, 134527)--Goredome
local timerShieldWaller			= mod:NewBuffActiveTimer(10, 134650)
local timerFirewallCD			= mod:NewCDTimer(18, 132666)--Sanoriak
local timerShadowStrikes		= mod:NewBuffActiveTimer(15, 126209)--Akama
local timerChainLightningCD		= mod:NewCDTimer(17, 39945)--Akama

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args:IsSpellID(33975, 136334) then--Spellid is used by 5 diff mobs in game, but SetZone sould filter the other 4 mobs.
		warnPyroblast:Show()
	elseif args.spellId == 132666 then
		warnFireWall:Show()
		timerFirewallCD:Start()--First one is 5 seconds after combat start
		if brawlersMod:PlayerFighting() then
			specWarnFireWall:Show()
		end
	elseif args.spellId == 39945 then
		warnChainLightning:Show()
		timerChainLightningCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnChainLightning:Show(args.sourceName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 134624 then
		warnToughLuck:Show(args.destName, args.amount or 1)
	elseif args.spellId == 134650 then
		warnShieldWaller:Show()
		timerShieldWaller:Start()
	elseif args.spellId == 126209 then
		warnShadowStrikes:Show()
		timerShadowStrikes:Start()
		if brawlersMod:PlayerFighting() then
			specWarnShadowStrikes:Show(args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 134650 then
		timerShieldWaller:Cancel()
	elseif args.spellId == 126209 then
		timerShadowStrikes:Cancel()
	end
end

--This event won't really work well for spectators if they target the player instead of boss. This event only fires if boss is on target/focus
--It is however the ONLY event you can detect this spell using.
function mod:UNIT_SPELLCAST_CHANNEL_START(uId, _, _, _, spellId)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if spellId == 134527 and self:AntiSpam() then
		warnLumberingCharge:Show()
		timerLumberingChargeCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnLumberingCharge:Show()
		end
	end
end
