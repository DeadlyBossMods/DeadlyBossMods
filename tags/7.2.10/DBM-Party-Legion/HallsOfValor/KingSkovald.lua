local mod	= DBM:NewMod(1488, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(95675)
mod:SetEncounterID(1808)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 202711",
	"SPELL_AURA_REMOVED 193826",
	"SPELL_CAST_START 193659 193668 193826 194112",
	"SPELL_CAST_SUCCESS 193659",
	"SPELL_PERIODIC_DAMAGE 193702",
	"SPELL_PERIODIC_MISSED 193702"
)

--TODO, longer/more pulls, a timer sequence may be better than on fly timer correction.
local warnAegis						= mod:NewTargetAnnounce(202711, 1)
local warnFelblazeRush				= mod:NewTargetAnnounce(193659, 2)
local warnClaimAegis				= mod:NewSpellAnnounce(194112, 2)

local yellFelblazeRush				= mod:NewYell(193659)
local specWarnSavageBlade			= mod:NewSpecialWarningDefensive(193668, "Tank", nil, nil, 1, 2)
local specWarnRagnarok				= mod:NewSpecialWarningMoveTo(193826, nil, nil, nil, 3, 2)
local specWarnFlames				= mod:NewSpecialWarningMove(193702, nil, nil, nil, 1, 2)

local timerRushCD					= mod:NewCDTimer(11, 193659, nil, nil, nil, 3)--11-13 unless delayed by claim aegis or ragnarok
local timerSavageBladeCD			= mod:NewCDTimer(19, 193668, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--23 unless delayed by claim aegis or ragnarok
local timerRagnarokCD				= mod:NewCDTimer(51, 193826, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)--60 now? or maybe health based?

local voiceSavageBlade				= mod:NewVoice(193668, "Tank")--defensive
local voiceRagnarok					= mod:NewVoice(193826)--findshield
local voiceFlames					= mod:NewVoice(193702)--runaway

function mod:FelblazeRushTarget(targetname, uId)
	if not targetname then return end
	warnFelblazeRush:Show(targetname)
	if targetname == UnitName("player") then
		yellFelblazeRush:Yell()
	end
end

function mod:OnCombatStart(delay)
	timerRushCD:Start(7.1-delay)
	timerRagnarokCD:Start(11-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 202711 and args:IsDestTypePlayer() then
		warnAegis:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 193826 then
		timerRagnarokCD:Start()
		--timerRushCD:Start(25)--Verify
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 193659 then
		self:BossUnitTargetScannerAbort()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 193659 then
		--Because of boss delay (never looking at correct target immediately/before cast start
		--there is time to use this better method for fastest and most efficient method
		self:BossUnitTargetScanner("boss1", "FelblazeRushTarget")
--[[		local elapsed, total = timerRagnarokCD:GetTime()
		local remaining = total - elapsed
		if remaining < 11 then
			local extend = 11 - remaining
			DBM:Debug("timerRushCD Extend by: "..extend)
			timerRushCD:Start(11+extend)
		else--]]
			timerRushCD:Start()
		--end
	elseif spellId == 193668 then
		specWarnSavageBlade:Show()
		voiceSavageBlade:Play("defensive")
		local elapsed, total = timerRagnarokCD:GetTime()
		local remaining = total - elapsed
		if remaining < 20 then
			--Do nothing, ragnaros will reset it
		else
			timerSavageBladeCD:Start()
		end
	elseif spellId == 193826 then
		specWarnRagnarok:Show(SHIELDSLOT)
		voiceRagnarok:Play("findshield")
		timerRushCD:Stop()
		timerSavageBladeCD:Stop()
		timerSavageBladeCD:Start(12)
	elseif spellId == 194112 then
		warnClaimAegis:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 193702 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnFlames:Show()
		voiceFlames:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
