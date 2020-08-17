local mod	= DBM:NewMod(2409, "DBM-Party-Shadowlands", 7, 1188)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164555, 164556)
mod:SetEncounterID(2394)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 320008 320787 320142 320168 321061 320132 320823",
	"SPELL_CAST_SUCCESS 323877 320132",
	"SPELL_AURA_APPLIED 320786 320147 323877",
	"SPELL_AURA_APPLIED_DOSE 320786 320147",
	"SPELL_AURA_REMOVED 320786",
	"SPELL_AURA_REMOVED_DOSE 320786",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, find event for their phase changes, probably a dialog UNIT event, so timers can be updated and variables reset.
--TODO, find a good stack count to warn for soaking.
--TODO, timer for any of buzz saws or warnings for them? It just seems like something that is spammed so for now they are excluded
--TODO, review some of normal warnings if they need to be special
--TODO, shadowfury has splash damage and stun, so figure out how to direct ONE player to hit millificent with it, not all of them
--Stage One: Millhouse's Magics
local warnSummonPowerCrystal		= mod:NewSpellAnnounce(320787, 3)
local warnThrowBuzzSaw				= mod:NewSpellAnnounce(320168, 3, nil, false)
local warnBleeding					= mod:NewStackAnnounce(320147, 2, nil, "Tank|Healer")
--Stage Two: Millificent's Gadgets
--local warnMechanicalBombSquirrel	= mod:NewSpellAnnounce(320825, 3)--Spammed

--Stage One: Millhouse's Magics
--local specWarnVulnerabilityStack	= mod:NewSpecialWarningStack(320786, nil, 12, nil, nil, 1, 6)
local specWarnDoom					= mod:NewSpecialWarningSpell(320142, nil, 226243, nil, 2, 2, 4)--Mythic only
local specWarnFrostbolt				= mod:NewSpecialWarningInterruptCount(320008, "HasInterrupt", nil, nil, 1, 2)
local specWarnBleeding				= mod:NewSpecialWarningStack(320147, nil, 12, nil, nil, 1, 6)
local specWarnLaser					= mod:NewSpecialWarningMoveTo(323877, nil, 143444, nil, 2, 8, 4)--Mythic only
local yellLaser						= mod:NewYell(323877)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)
--Stage Two: Millificent's Gadgets
local specWarnAerialRocketChicken	= mod:NewSpecialWarningDodge(321061, nil, 45255, nil, 2, 2, 4)--Mythic only
local specWarnShadowfury			= mod:NewSpecialWarningMoveTo(320132, nil, nil, nil, 2, 8, 4)--Mythic only

--General
local timerPhaseCD						= mod:NewPhaseTimer(30)
--Stage One: Millhouse's Magics
local timerSummonPowerCrystalCD			= mod:NewCDTimer(7.4, 320787, nil, nil, nil, 5)
local timerDoomCD						= mod:NewAITimer(15.8, 320142, 226243, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)--Shortname Doom!!!
local timerLaserCD						= mod:NewAITimer(15.8, 323877, 143444, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)--Shortname Laser
--Stage Two: Millificent's Gadgets
--local timerMechanicalBombSquirrelCD		= mod:NewAITimer(13, 320825, nil, nil, nil, 3)
local timerExperimentalSquirrelBombCD	= mod:NewCDTimer(8, 320823, nil, nil, nil, 5)
local timerAerialRocketChickenCD		= mod:NewAITimer(13, 321061, 45255, nil, nil, 3)--Shortname Rocket Chicken
local timerShadowfuryCD					= mod:NewAITimer(13, 320132, nil, nil, nil, 3)

mod:AddInfoFrameOption(320786, true)
mod:AddRangeFrameOption(8, 320132)

local millHouse, millificent = DBM:EJ_GetSectionInfo(22027), DBM:EJ_GetSectionInfo(22031)
local VulnerabilityStacks = {}
mod.vb.interruptCount = 0
mod.vb.activeBoss = 1--1-Millhouse, 2-Millificent

function mod:OnCombatStart(delay)
	table.wipe(VulnerabilityStacks)
	self.vb.interruptCount = 0
	self.vb.activeBoss = 1
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(320786))
		DBM.InfoFrame:Show(5, "table", VulnerabilityStacks, 1)
	end
	DBM:AddMsg("This fights phase changes aren't worked out yet so AI timers won't be able to predictively handle them yet")
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320787 then
		warnSummonPowerCrystal:Show()
		timerSummonPowerCrystalCD:Start()
	elseif spellId == 320008 and self.vb.activeBoss == 1 then
		self.vb.interruptCount = self.vb.interruptCount + 1
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			local count = self.vb.interruptCount
			specWarnFrostbolt:Show(args.sourceName, count)
			if count == 1 then
				specWarnFrostbolt:Play("kick1r")
			elseif count == 2 then
				specWarnFrostbolt:Play("kick2r")
			elseif count == 3 then
				specWarnFrostbolt:Play("kick3r")
			elseif count == 4 then
				specWarnFrostbolt:Play("kick4r")
			elseif count == 5 then
				specWarnFrostbolt:Play("kick5r")
			else
				specWarnFrostbolt:Play("kickcast")
			end
		end
	elseif spellId == 320142 then
		specWarnDoom:Show()
		specWarnDoom:Play("aesoon")
	elseif spellId == 320168 then
		warnThrowBuzzSaw:Show()
--	elseif spellId == 320825 and self:AntiSpam(5, 3) then
--		warnMechanicalBombSquirrel:Show()
--		timerMechanicalBombSquirrelCD:Start()
	elseif spellId == 321061 then
		specWarnAerialRocketChicken:Show()
		specWarnAerialRocketChicken:Play("watchstep")
	elseif spellId == 320132 then
		specWarnShadowfury:Show(millificent)
		specWarnShadowfury:Play("behindboss")
		timerShadowfuryCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif spellId == 320823 then
		timerExperimentalSquirrelBombCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 323877 then
		timerLaserCD:Start()
	elseif spellId == 320132 then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 320786 then
		local amount = args.amount or 1
		VulnerabilityStacks[args.destName] = amount
		--if args:IsPlayer() and (amount == 12 or amount >= 15 and amount % 2 == 1) then--12, 15, 17, 19
		--	specWarnVulnerabilityStack:Show(amount)
		--	specWarnVulnerabilityStack:Play("stackhigh")
		--end
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(VulnerabilityStacks)
		end
	elseif spellId == 320147 then
		local amount = args.amount or 1
		if amount >= 12 then--Guesswork
			if args:IsPlayer() then
				specWarnBleeding:Show(amount)
				specWarnBleeding:Play("stackhigh")
			else
				warnBleeding:Show(args.destName, amount)
			end
		end
	elseif spellId == 323877 then
		if args:IsPlayer() then
			specWarnLaser:Show(millHouse)
			specWarnLaser:Play("behindboss")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 320786 then
		VulnerabilityStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(VulnerabilityStacks)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 320786 then
		VulnerabilityStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(VulnerabilityStacks)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 164561 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 326684 then--Teleport (unique spell for Millhouse leaving)
		self.vb.activeBoss = 2
		timerSummonPowerCrystalCD:Stop()
		timerDoomCD:Stop()
		timerLaserCD:Stop()
		timerExperimentalSquirrelBombCD:Start(6)
		if self:IsMythic() then
			timerAerialRocketChickenCD:Start(2)
			timerShadowfuryCD:Start(2)
		end
		timerPhaseCD:Start(30)
	elseif spellId == 326799 then--Rocket Jump (unique spell for Millificent leaving) (not to be confused with 326804)
		self.vb.activeBoss = 1
		timerExperimentalSquirrelBombCD:Stop()
		timerAerialRocketChickenCD:Stop()
		timerShadowfuryCD:Stop()
		timerSummonPowerCrystalCD:Start(7)
		if self:IsMythic() then
			timerDoomCD:Start(1)
			timerLaserCD:Start(1)
		end
		timerPhaseCD:Start(30)
	end
end
