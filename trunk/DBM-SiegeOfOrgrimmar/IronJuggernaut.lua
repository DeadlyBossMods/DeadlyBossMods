local mod	= DBM:NewMod(864, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71466)
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
)

--Assault Mode
local warnBorerDrill			= mod:NewSpellAnnounce(144209, 3)
local warnLaserStrike			= mod:NewSpellAnnounce(144456, 3)
local warnMortarBarrage			= mod:NewTargetAnnounce(144553, 3)
local warnCrawlerMine			= mod:NewTargetAnnounce(146342, 3)--No doubt in my mind this is WRONG trigger.
local warnIgniteArmor			= mod:NewStackAnnounce(144467, 2, nil, mod:IsTank())--Seems redundant to count debuffs and warn for breath, so just do debuffs
--Siege Mode
local warnSeismicActivity		= mod:NewSpellAnnounce(144483, 2)--A mere actiivation
local warnShockPulse			= mod:NewSpellAnnounce(144485, 3)--The actual threatening quake mechanic
local warnDemolisherCanons		= mod:NewSpellAnnounce(144154, 3)
local warnCutterLaser			= mod:NewSpellAnnounce(146325, 4)--Not holding my breath this shows in combat log.
--Could not find any tar spellids. blizz obviously named spell something completely diff from EJ since there isn't a single spell in game files with word "tar" in it that matches this spell

--Assault Mode
local specWarnBorerDrill		= mod:NewSpecialWarningSpell(144209, nil, nil, nil, 2)
local specWarnMortarBarrage		= mod:NewSpecialWarningYou(144553)
local specWarnMortarBarrageNear	= mod:NewSpecialWarningClose(144553)
local yellMortarBarrage			= mod:NewYell(144553)
--Siege Mode
local specWarnShockPulse		= mod:NewSpecialWarningSpell(144485, nil, nil, nil, 2)
local specWarnCutterLaser		= mod:NewSpecialWarningYou(146325)
local yellCutterLaser			= mod:NewYell(146325)

--Assault Mode
local timerIgniteArmor			= mod:NewTargetTimer(30, 144467)
--Siege Mode
local timerCuttingLaser			= mod:NewTargetTimer(15, 146325)

local soundCuttingLaser			= mod:NewSound(146325)

mod:AddBoolOption("RangeFrame")--Really only want this during siege mode, but without phase trigger it's opened on pull for now.

function mod:MortarBarrageTarget(targetname, uId)
	if not targetname then
		print("DBM DEBUG: MortarBarrageTarget Scan failed")
		return
	end
	warnMortarBarrage:Show(targetname)
	if targetname == UnitName("player") then
		specWarnMortarBarrage:Show()
		yellMortarBarrage:Yell()
	else
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 9 then
				specWarnMortarBarrageNear:Show(args.destName)
			end
		end
	end
end

function mod:OnCombatStart(delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144209 then
		warnBorerDrill:Show()
		specWarnBorerDrill:Show()
	elseif args.spellId == 144553 then
		self:BossTargetScanner(71466, "MortarBarrageTarget", 0.025, 16)
	elseif args.spellId == 144483 then
		warnSeismicActivity:Show()
	elseif args.spellId == 144485 then
		warnShockPulse:Show()
		specWarnShockPulse:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 144456 then
		warnLaserStrike:Show()
	elseif args.spellId == 146342 then
		warnCrawlerMine:Show()
	elseif args.spellId == 144154 then
		warnDemolisherCanons:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144467 then
		local amount = args.amount or 1
		warnIgniteArmor:Show(args.destName, amount)
		timerIgniteArmor:Start(args.destName)
	elseif args.spellId == 146325 then
		warnCutterLaser:Show(args.destName)
		timerCuttingLaser:Start(args.destName)
		if args:IsPlayer() then
			specWarnCutterLaser:Show()
			yellCutterLaser:Yell()
			soundCuttingLaser:Play()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144467 then
		timerIgniteArmor:Cancel(args.destName)
	elseif args.spellId == 146325 then
		timerCuttingLaser:Cancel(args.destName)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 138006 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnElectrifiedWaters:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137175") then
		local target = DBM:GetFullNameByShortName(target)
		warnThrow:Show(target)
		timerStormCD:Start()
		self:Schedule(55.5, checkWaterStorm)--check before 5 sec.
		if target == UnitName("player") then
			specWarnThrow:Show()
		else
			specWarnThrowOther:Show(target)
		end
	end
end
--]]
