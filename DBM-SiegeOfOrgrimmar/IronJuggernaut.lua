local mod	= DBM:NewMod(864, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71466)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Assault Mode
local warnBorerDrill			= mod:NewSpellAnnounce(144218, 3)
local warnLaserBurn				= mod:NewTargetAnnounce(144459, 3, nil, mod:IsHealer())
local warnMortarCannon			= mod:NewSpellAnnounce(144316, 3, nil, false)--Could not get target scanning working.
local warnCrawlerMine			= mod:NewSpellAnnounce(144673, 3)
local warnIgniteArmor			= mod:NewStackAnnounce(144467, 2, nil, mod:IsTank())--Seems redundant to count debuffs and warn for breath, so just do debuffs
--Siege Mode
local warnSeismicActivity		= mod:NewSpellAnnounce(144483, 2)--A mere activation of phase
local warnNapalmOil				= mod:NewSpellAnnounce(144492, 3)
local warnShockPulse			= mod:NewCountAnnounce(144485, 3)
local warnDemolisherCanon		= mod:NewSpellAnnounce(144154, 3)
local warnCutterLaser			= mod:NewTargetAnnounce(146325, 4)--Not holding my breath this shows in combat log.
local warnMortarBarrage			= mod:NewSpellAnnounce(144555, 4)--Heroic

--Assault Mode
local specWarnIgniteArmor		= mod:NewSpecialWarningStack(144467, mod:IsTank(), 3)
local specWarnIgniteArmorOther	= mod:NewSpecialWarningTarget(144467, mod:IsTank())
local specWarnBorerDrill		= mod:NewSpecialWarningSpell(144218, false, nil, nil, 2)
local specWarnBorerDrillMove	= mod:NewSpecialWarningMove(144218)
--Siege Mode
local specWarnShockPulse		= mod:NewSpecialWarningCount(144485, nil, nil, nil, 2)
local specWarnCutterLaser		= mod:NewSpecialWarningRun(146325)
local specWarnNapalmOil			= mod:NewSpecialWarningMove(144498)
local yellCutterLaser			= mod:NewYell(146325)
local specWarnMortarBarrage		= mod:NewSpecialWarningSpell(144555, nil, nil, nil, 2)

--Assault Mode
local timerAssaultModeCD		= mod:NewNextTimer(64, 141395, nil, "timerAssaultModeCD")--141395 is correct timer text but it's wrong spellid, custom option text for real timer description
local timerIgniteArmor			= mod:NewTargetTimer(30, 144467, nil, mod:IsTank() or mod:IsHealer())
local timerIgniteArmorCD		= mod:NewCDTimer(10, 144467, nil, mod:IsTank())
local timerLaserBurn			= mod:NewTargetTimer(16, 144459, nil, false)
local timerLaserBurnCD			= mod:NewCDTimer(12, 144459)
local timerBorerDrillCD			= mod:NewCDTimer(17, 144218)
local timerCrawlerMineCD		= mod:NewCDTimer(30, 144673)
--Siege Mode
--http://us.battle.net/wow/en/forum/topic/9423383447?page=2#38 do to major inconsitecies and possible bugs, Some timers for Siege mode are disabled until a later test
local timerSiegeModeCD			= mod:NewNextTimer(116, 84974, nil, nil, "timerSiegeModeCD")--Wish spell name was a litlte shorter but still better than localizing
local timerCuttingLaser			= mod:NewTargetTimer(10, 146325)--Spell tooltip says 15 but combat log showed 10
--local timerCuttingLaserCD		= mod:NewCDTimer(10, 146325)
local timerShockPulseCD			= mod:NewNextCountTimer(16.5, 144485)--Confirmed, blizzard did take solid argued feedback and changed this mechanic, yay.
--local timerNapalmOilCD		= mod:NewCDTimer(21.5, 144492)
local timerDemolisherCanonCD	= mod:NewCDTimer(9, 144154)
local timerMortarBarrageCD		= mod:NewCDTimer(30, 144555)

local soundCuttingLaser			= mod:NewSound(146325)

local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddBoolOption("RangeFrame", mod:IsRanged())

local siegeMode = false
local shockCount = 0

function mod:OnCombatStart(delay)
	siegeMode = false
	shockCount = 0
	timerIgniteArmorCD:Start(9-delay)
	timerLaserBurnCD:Start(-delay)
	timerBorerDrillCD:Start(-delay)
	timerCrawlerMineCD:Start(-delay)
	timerSiegeModeCD:Start(120.5-delay)--First one longer than rest
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144483 then--Siege mode transition
		siegeMode = true
		shockCount = 0
		timerLaserBurnCD:Cancel()
		timerCrawlerMineCD:Cancel()
		timerBorerDrillCD:Cancel()
		warnSeismicActivity:Show()
		timerShockPulseCD:Start(nil, 1)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerMortarBarrageCD:Start(15)
		end
		timerAssaultModeCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif args.spellId == 144485 then
		shockCount = shockCount + 1
		warnShockPulse:Show(shockCount)
		specWarnShockPulse:Show(shockCount)
		if shockCount < 3 then
			timerShockPulseCD:Start(nil, shockCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 146325 then
		self:SendSync("LaserTarget", args.destGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144467 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then
			local amount = args.amount or 1
			warnIgniteArmor:Show(args.destName, amount)
			timerIgniteArmor:Start(args.destName)
			timerIgniteArmorCD:Start()
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnIgniteArmor:Show(amount)
				else
					specWarnIgniteArmorOther:Show(args.destName)
				end
			end
		end
	elseif args.spellId == 146325 then
		self:SendSync("LaserTarget", args.destGUID)
	elseif args.spellId == 144459 then
		warnLaserBurn:Show(args.destName)
		timerLaserBurn:Start(args.destName)
		timerLaserBurnCD:Start()
	elseif args.spellId == 144498 and args:IsPlayer() then
		specWarnNapalmOil:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144467 then
		timerIgniteArmor:Cancel(args.destName)
	elseif args.spellId == 146325 then
		self:SendSync("LaserTargetRemoved", args.destGUID)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 144218 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnBorerDrillMove:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_WHISPER(msg)--It was actually CHAT_MSG_RAID_BOSS_EMOTE during test, but that was a bug, it'll probably be whisper next time
	if msg:find("spell:144918") then
		self:SendSync("LaserTarget", UnitGUID("player"))
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 145407 then
		warnMortarCannon:Show()
	elseif spellId == 144296 then--absolutely do NOT add 144218 to this. 144218 is an every 0.4 second periodic trigger that fires after 144296
		warnBorerDrill:Show()
		specWarnBorerDrill:Show()
		timerBorerDrillCD:Start()
	elseif spellId == 144673 then
		warnCrawlerMine:Show()
		if not siegeMode then--These spawn during siege mode but random as all hell, there is no timer in this phase for these
			timerCrawlerMineCD:Start()
		end
	elseif spellId == 144198 then
		warnDemolisherCanon:Show()
		timerDemolisherCanonCD:Start()
	elseif spellId == 144492 then
		warnNapalmOil:Show()
--		timerNapalmOilCD:Start()
	elseif spellId == 146359 then--Regeneration (Assault Mode power regen activation)
		--2 seconds slower than emote, but it's not pressing enough to matter so it's better localisation wise to do it this way
--		timerNapalmOilCD:Cancel()
		timerDemolisherCanonCD:Cancel()
		timerMortarBarrageCD:Cancel()
--		timerCuttingLaserCD:Cancel()
		if siegeMode == true then--don't start timer on pull regenerate, pull regenerate is 5 seconds longer than rest of them
			timerSiegeModeCD:Start()
			siegeMode = false
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif spellId == 144555 then
		warnMortarBarrage:Show()
		specWarnMortarBarrage:Show()
		timerMortarBarrageCD:Start()
	end
end

function mod:OnSync(msg, guid)
	--Syncing used do to combat log range AND combat log bugs
	--In ptr testing, the spell firing a combat log event was hit or miss
	--Sometimes it fire SUCCESS but not APPLIED, sometimes APPLIED but not success
	--And sometimes, fired neither one and emote only.
	--So screw it, watch for all 3 and sync to cover range restriction too
	if msg == "LaserTarget" and guid then
		local targetName = DBM:GetFullPlayerNameByGUID(guid)
		warnCutterLaser:Show(targetName)
		timerIgniteArmor:Start(targetName)
--		timerCuttingLaserCD:Start()
		if targetName == UnitName("player") then
			specWarnCutterLaser:Show()
			yellCutterLaser:Yell()
			soundCuttingLaser:Play()
		end
	elseif msg == "LaserTargetRemoved" and guid then
		timerCuttingLaser:Cancel(DBM:GetFullPlayerNameByGUID(guid))
	end
end
