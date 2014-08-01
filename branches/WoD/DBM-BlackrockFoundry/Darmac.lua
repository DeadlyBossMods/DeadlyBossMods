local mod	= DBM:NewMod(1122, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76865)--No need to add beasts to this. It's always main boss that's engaged first and dies last.
mod:SetEncounterID(1694)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 154975 155198",
	"SPELL_CAST_SUCCESS 155247",
	"SPELL_SUMMON 154956",
	"SPELL_AURA_APPLIED 154960 155458 155459 155460 155399 155028 155236",
	"SPELL_AURA_APPLIED_DOSE 155028 155236",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--Because boss numbering tends to get out of wack with things constantly joining/leaving fight. I've only seen boss1 and boss2 but for good measure.
)

--Boss basic attacks
local warnPinDown					= mod:NewSpellAnnounce(155365, 3)--Debuffs/target only show in combat log 1 in 5 times. so target warning not reliable for timers/warnings right now. 154960#Pin Down#1#DEBUFF is debuff
local warnPinDownTargets			= mod:NewTargetAnnounce(154960, 3)
local warnCallthePack				= mod:NewSpellAnnounce(154975, 3)
--Boss gained abilities (beast deaths grant boss new abilities)
local warnWolf						= mod:NewTargetAnnounce(155458, 3)--Grants Rend and Tear
local warnRendandTear				= mod:NewSpellAnnounce(155385, 3)--Target scanning doesn't seem to work, target is nil. Will check targettarget or something fancy just in case
local warnRylak						= mod:NewTargetAnnounce(155459, 3)--Grants Superheated Shrapnel
local warnSuperheatedShrapnel		= mod:NewSpellAnnounce(155499, 3, nil, mod:IsHealer())
local warnElekk						= mod:NewTargetAnnounce(155460, 3)--Grants Tantrum
local warnTantrum					= mod:NewSpellAnnounce(162275, 3)
--Beast abilities (living beasts)
local warnSavageHowl				= mod:NewSpellAnnounce(155198, 3, nil, mod:IsHealer() or mod:IsTank())
local warnConflag					= mod:NewTargetAnnounce(155399, 3, nil, mod:IsHealer())
local warnSearingFangs				= mod:NewStackAnnounce(155028, 2, nil, mod:IsTank())
local warnCrushArmor				= mod:NewStackAnnounce(155236, 2, nil, mod:IsTank())
local warnStampede					= mod:NewSpellAnnounce(155247, 3)

--Boss basic attacks
local specWarnCallthePack			= mod:NewSpecialWarningSwitch(154975, not mod:IsHealer())
--Boss gained abilities (beast deaths grant boss new abilities)
local specWarnSuperheatedShrapnel	= mod:NewSpecialWarningSpell(155499, nil, nil, nil, 2)--Still iffy on it
local specWarnTantrum				= mod:NewSpecialWarningSpell(162275, nil, nil, nil, 2)
--Beast abilities (living)
local specWarnSavageHowl			= mod:NewSpecialWarningSpell(155198, mod:IsHealer() or mod:IsTank(), nil, nil, 2)
local specWarnSearingFangs			= mod:NewSpecialWarningStack(155028, mod:IsTank(), 3)--Stack count assumed, may be 2
local specWarnSearingFangsOther		= mod:NewSpecialWarningTaunt(155028, mod:IsTank())
local specWarnCrushArmor			= mod:NewSpecialWarningStack(155236, mod:IsTank(), 3)--Stack count assumed, may be less
local specWarnCrushArmorOther		= mod:NewSpecialWarningTaunt(155236, mod:IsTank())

--Boss basic attacks
local timerPinDownCD				= mod:NewCDTimer(20.5, 155365)--Every 20 seconds unless delayed by other things. CD timer used for this reason
local timerCallthePackCD			= mod:NewCDTimer(20.5, 154975)--Every 20.5sec cd but RARELY 20 seconds. often 26-30 seconds. Don't mistake for 26 second cd. It is absolutely 20
--Boss gained abilities (beast deaths grant boss new abilities)
local timerRendandTearCD			= mod:NewCDTimer(12, 155385)
--local timerSuperheatedShrapnelCD	= mod:NewCDTimer(30, 155499)
--local timerTantrumCD				= mod:NewCDTimer(30, 162275)
--Beast abilities (living)
--local timerSavageHowlCD			= mod:NewCDTimer(30, 155198)
--local timerConflagCD				= mod:NewCDTimer(30, 155399)
--local timerStampedeCD				= mod:NewCDTimer(30, 155247)

mod:AddRangeFrameOption("8/7/3")

mod.vb.RylakActive = false
local activeBossGUIDS = {}

local function pinDelay()
	warnPinDown:Show()
end

function mod:OnCombatStart(delay)
	self.vb.RylakActive = false
	table.wipe(activeBossGUIDS)
	timerCallthePackCD:Start(8-delay)
	timerPinDownCD:Start(12.5-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(3)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 154975 then
		warnCallthePack:Show()
		specWarnCallthePack:Show()
		timerCallthePackCD:Start()
	elseif spellId == 155198 then
		warnSavageHowl:Show()
		specWarnSavageHowl:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155247 then
		warnStampede:Show()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 154956 and self:AntiSpam(3, 1) then
		self:Schedule(0.5, pinDelay)--Schedule a delay, wait to see if debuffs appear in combat log and show those instead.
		timerPinDownCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 154960 then
		self:Unschedule(pinDelay)--We git debuffs, show target warning instead of generic
		warnPinDownTargets:CombinedShow(0.5, args.destName)
	elseif spellId == 155399 then
		warnConflag:CombinedShow(0.5, args.destName)
	elseif spellId == 155028 then
		local amount = args.amount
		warnSearingFangs:Show(args.destName, amount)
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnSearingFangs:Show(amount)
			else
				if not UnitDebuff("player", GetSpellInfo(155028)) and not UnitIsDeadOrGhost("player") then
					specWarnSearingFangsOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 155236 then
		local amount = args.amount or 1
		warnCrushArmor:Show(args.destName, amount)
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnCrushArmor:Show(amount)
			else
				if not UnitDebuff("player", GetSpellInfo(155236)) and not UnitIsDeadOrGhost("player") then
					specWarnCrushArmorOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 155458 then--Wolf Aura
		warnWolf:Show(args.destName)
		if self.Options.RangeFrame and not self:IsMelee() and not self.vb.RylakActive then
			DBM.RangeCheck:Show(7)--Upgrade range frame to 7 now that he has rend and tear. TODO: If this attack doesn't target melee
		end
	elseif spellId == 155459 then--Rylak Aura
		warnRylak:Show(args.destName)
		self.vb.RylakActive = true
		if self.Options.RangeFrame and not self:IsMelee() then
			DBM.RangeCheck:Show(8)--Update range frame to 8 for Scrapnal. TODO, again, see if melee affected by this or not
		end
	elseif spellId == 155460 then--Elekk Aura
		warnElekk:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

local function updateBeasts(cid, status, beastName)
	if DBM.BossHealth:IsShown() then--Cannot be used yet until I find out section IDs for the sub bosses and actually support adding them in the IEEU handler first.
		if status == 1 then--Add beast, remove boss
			DBM.BossHealth:RemoveBoss(76865)
			DBM.BossHealth:AddBoss(cid, beastName)
		else--Status 0, remove beast add boss
			DBM.BossHealth:RemoveBoss(cid)
			DBM.BossHealth:AddBoss(76865, L.name)
		end
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		if UnitExists(unitID) and not activeBossGUIDS[unitGUID] then
			activeBossGUIDS[unitGUID] = true
			local cid = self:GetCIDFromGUID(unitGUID)
			if cid == 76884 then--Cruelfang
				updateBeasts(cid, 1, UnitName(unitID))
			elseif cid == 76874 then--Dreadwing
				updateBeasts(cid, 1, UnitName(unitID))
				--Cancel timers for abilities he can't use from other dead beasts
				timerRendandTearCD:Cancel()
			elseif cid == 76945 then--Ironcrusher
				updateBeasts(cid, 1, UnitName(unitID))
				--Cancel timers for abilities he can't use from other dead beasts
				timerRendandTearCD:Cancel()
			elseif cid == 76946 then--Faultline
				updateBeasts(cid, 1, UnitName(unitID))
				--Cancel timers for abilities he can't use from other dead beasts
				timerRendandTearCD:Cancel()
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 76884 then--Cruelfang
		updateBeasts(cid, 0)
		timerRendandTearCD:Start()--Start timer over, Cruel won't do anymore but boss will.
	elseif cid == 76874 then--Dreadwing
		updateBeasts(cid, 0)
	elseif cid == 76945 then--Ironcrusher
		updateBeasts(cid, 0)
	elseif cid == 76946 then--Faultline
		updateBeasts(cid, 0)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 155221 then--IronCrusher Tantrum
		warnTantrum:Show()
		specWarnTantrum:Show()
	elseif spellId == 155520 then--Beastlord Darmac Tantrum
		warnTantrum:Show()
		specWarnTantrum:Show()
	elseif spellId == 155497 then--Superheated Shrapnel
		warnSuperheatedShrapnel:Show()
		specWarnSuperheatedShrapnel:Show()
	elseif spellId == 155385 or spellId == 155515 then--Both versions of spell(boss and beast), they seem to have same cooldown so combining is fine
		warnRendandTear:Show()
		timerRendandTearCD:Start()
	end
end
