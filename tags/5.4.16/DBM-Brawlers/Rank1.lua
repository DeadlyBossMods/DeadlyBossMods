local mod	= DBM:NewMod("BrawlRank1", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(46327)--Last Boss of Rank 1
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 135342 133286 134740 133607",
	"SPELL_AURA_APPLIED 133286",
	"UNIT_SPELLCAST_CHANNEL_START target focus"
)

local warnChomp					= mod:NewSpellAnnounce(135342, 4)
local warnVolatileFlames		= mod:NewSpellAnnounce(134740, 3)
local warnFireLine				= mod:NewCastAnnounce(133607, 4, 2)
local warnLumberingCharge		= mod:NewSpellAnnounce(134527, 4)
local warnHeatedPokers			= mod:NewSpellAnnounce(133286, 4)

local specWarnChomp				= mod:NewSpecialWarningMove(135342)
local specWarnFireLine			= mod:NewSpecialWarningMove(133607)
local specWarnLumberingCharge	= mod:NewSpecialWarningMove(134527)
local specWarnHeatedPokers		= mod:NewSpecialWarningSpell(133286)--Can be interrupted, if you don't have one. can stun through buff or run away. How you handle varies, but you MUST handle it.

local timerChompCD				= mod:NewCDTimer(8, 135342)
local timerLumberingChargeCD	= mod:NewCDTimer(7, 134527)--7-10 sec variation
local timerHeatedPokers			= mod:NewBuffActiveTimer(8, 133286)
local timerHeatedPokersCD		= mod:NewCDTimer(29, 133286)
local timerVolatileFlamesCD		= mod:NewCDTimer(11, 134740)--11-20 sec variation
local timerFireLineCD			= mod:NewCDTimer(15, 133607)--15-22 sec variation

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 135342 then
		warnChomp:Show()--Give reg warnings for spectators
		timerChompCD:Start()--And timers (first one is after 6 seconds)
		if brawlersMod:PlayerFighting() then--Only give special warnings if you're in arena though.
			specWarnChomp:Show()
		end
	elseif args.spellId == 133286 then
		warnHeatedPokers:Show()
		timerHeatedPokersCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnHeatedPokers:Show()
		end
	elseif args.spellId == 134740 then
		warnVolatileFlames:Show()
		timerVolatileFlamesCD:Start()
	elseif args.spellId == 133607 then
		warnFireLine:Show()
		timerFireLineCD:Start()--First one is 9-10 seconds after combat start
		if brawlersMod:PlayerFighting() then
			specWarnFireLine:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 133286 then
		timerHeatedPokers:Start()
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
