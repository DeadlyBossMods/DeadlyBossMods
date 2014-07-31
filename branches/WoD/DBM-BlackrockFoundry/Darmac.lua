local mod	= DBM:NewMod(1122, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76865)
mod:SetEncounterID(1694)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 154975 155198",
	"SPELL_CAST_SUCCESS 155247",
	"SPELL_AURA_APPLIED 155365 155499 162275 155222 161294 161291 161293 155399 155028 155236",
	"SPELL_AURA_APPLIED_DOSE 155028 155236",
	"SPELL_AURA_REMOVED 161294 161291",
	"UNIT_DIED"
)

--Boss basic attacks
local warnPinDown					= mod:NewTargetAnnounce(155365, 3)
local warnCallthePack				= mod:NewSpellAnnounce(154975, 3)
--Boss gained abilities (beast deaths grant boss new abilities)
local warnWolf						= mod:NewTargetAnnounce(161294, 3)--Grants Rend and Tear
--local warnRendandTear				= mod:NewTargetAnnounce(162283, 3)--Way too many spellids to assess which one is correct. I do know there are two IDs we'll need, one for boss version one for beast version
local warnRylak						= mod:NewTargetAnnounce(161291, 3)--Grants Superheated Shrapnel
local warnSuperheatedShrapnel		= mod:NewTargetAnnounce(155499, 3, nil, mod:IsHealer())
local warnElekk						= mod:NewTargetAnnounce(161293, 3)--Grants Tantrum
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
local specWarnTantrum				= mod:NewSpecialWarningSpell(162275, nil, nil, nil, 2)
--Beast abilities (living)
local specWarnSavageHowl			= mod:NewSpecialWarningSpell(155198, mod:IsHealer() or mod:IsTank(), nil, nil, 2)
local specWarnSearingFangs			= mod:NewSpecialWarningStack(155028, mod:IsTank(), 3)--Stack count assumed, may be 2
local specWarnSearingFangsOther		= mod:NewSpecialWarningTaunt(155028, mod:IsTank())
local specWarnCrushArmor			= mod:NewSpecialWarningStack(155236, mod:IsTank(), 4)--Stack count assumed, may be less
local specWarnCrushArmorOther		= mod:NewSpecialWarningTaunt(155236, mod:IsTank())

--Boss basic attacks
--local timerPinDownCD				= mod:NewCDTimer(30, 155365)
--local timerCallthePackCD			= mod:NewCDTimer(30, 154975)
--Boss gained abilities (beast deaths grant boss new abilities)
--local timerRendandTearCD			= mod:NewCDTimer(30, 162283)
--local timerSuperheatedShrapnelCD	= mod:NewCDTimer(30, 155499)
--local timerTantrumCD				= mod:NewCDTimer(30, 162275)
--Beast abilities (living)
--local timerSavageHowlCD			= mod:NewCDTimer(30, 155198)
--local timerConflagCD				= mod:NewCDTimer(30, 155399)
--local timerStampedeCD				= mod:NewCDTimer(30, 155247)

mod:AddRangeFrameOption("8/7/3")

function mod:OnCombatStart(delay)
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

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155365 then
		warnPinDown:CombinedShow(0.5, args.destName)
	elseif spellId == 155499 then
		warnSuperheatedShrapnel:CombinedShow(0.5, args.destName)
	elseif spellId == 155399 then
		warnConflag:CombinedShow(0.5, args.destName)
	elseif spellId == 162275 or spellId == 155222 then--162275 Boss version of tantrum/155222 Beast version of Tantrum (todo, see if they have different CDs and split by spellid)
		warnTantrum:Show()
		specWarnTantrum:Show()
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
		if amount >= 4 then
			if args:IsPlayer() then
				specWarnCrushArmor:Show(amount)
			else
				if not UnitDebuff("player", GetSpellInfo(155236)) and not UnitIsDeadOrGhost("player") then
					specWarnCrushArmorOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 161294 then--Wolf Aura
		warnWolf:Show(args.destName)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(7)--Upgrade range frame to 7 now that he has rend and tear. TODO: If this attack doesn't target melee, leave melee at 3 and only update to 7 for ranged
		end
	elseif spellId == 161291 then--Rylak Aura
		warnRylak:Show(args.destName)
		self.vb.RylakActive = true
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)--TODO, again, see if melee affected by this or not
		end
	elseif spellId == 161293 then--Elekk Aura
		warnElekk:Show(args.destName)
	--stage 3 beast auras, probably all apply at same time
--	elseif spellId == 155458 then--Wolf Aura (phase 3)

	elseif spellId == 155459 then--Rylak Aura (Phase 3)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)--TODO, again, see if melee affected by this or not
		end
--	elseif spellId == 155460 or spellId == 163247 then--Elekk Aura (phase 3)

	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 161294 or spellId == 161291 then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(3)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 76884 then--Cruelfang
		
	elseif cid == 76874 then--Dreadwing

	elseif cid == 76945 then--Ironcrusher

	elseif cid == 76946 then--Faultline
	
	end
end


--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 50630 and self:AntiSpam(2, 3) then--Eject All Passengers:
	
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("cFFFF0404") then

	elseif msg:find(L.tower) then

	end
end

function mod:OnSync(msg)
	if msg == "Adds" and self:AntiSpam(20, 4) and self:IsInCombat() then

	end
end--]]