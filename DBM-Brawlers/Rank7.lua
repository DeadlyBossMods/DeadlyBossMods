local mod	= DBM:NewMod("BrawlRank7", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(46798)

mod:RegisterEvents(
	"SPELL_CAST_START 133308 229154",
	"SPELL_CAST_SUCCESS 133227",
--	"SPELL_AURA_APPLIED_DOSE 138901",
--	"SPELL_AURA_REMOVED_DOSE 138901",
--	"SPELL_AURA_REMOVED 138901",
	"UNIT_DIED"
)

local warnThrowNet					= mod:NewSpellAnnounce(133308, 3)--Fran and Riddoh
local warnGoblinDevice				= mod:NewSpellAnnounce(133227, 4)--Fran and Riddoh
local warnHighNoon					= mod:NewCastAnnounce(229154, 4)

local specWarnGoblinDevice			= mod:NewSpecialWarningSpell(133227)--Fran and Riddoh

local timerThrowNetCD				= mod:NewCDTimer(20, 133308, nil, nil, nil, 3)--Fran and Riddoh
local timerGoblinDeviceCD			= mod:NewCDTimer(21.8, 133227, nil, nil, nil, 3)--Fran and Riddoh
local timerHighNoon					= mod:NewCastTimer(80, 229154, nil, nil, nil, 3)

local brawlersMod = DBM:GetModByName("BrawlersGeneral")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133308 then
		warnThrowNet:Show()
		timerThrowNetCD:Start()
		if not brawlersMod:PlayerFighting() then
			timerThrowNetCD:SetSTFade(true)
		end
	elseif args.spellId == 229154 then
		warnHighNoon:Show()
		timerHighNoon:Start()
		if not brawlersMod:PlayerFighting() then
			timerHighNoon:SetSTFade(true)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133227 then
		timerGoblinDeviceCD:Start()--6 seconds after combat start, if i do that kind of detection later
		if brawlersMod:PlayerFighting() then--Only give special warnings if you're in arena though.
			specWarnGoblinDevice:Show()
		else
			warnGoblinDevice:Show()
			timerGoblinDeviceCD:SetSTFade(true)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 67524 then--These 2 have a 1 min 50 second berserk
		timerThrowNetCD:Stop()
	elseif cid == 67525 then--These 2 have a 1 min 50 second berserk
		timerGoblinDeviceCD:Stop()
	elseif cid == 229154 then--Dupree
		timerHighNoon:Stop()
	end
end
