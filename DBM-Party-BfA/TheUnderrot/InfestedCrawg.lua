local mod	= DBM:NewMod(2131, "DBM-Party-BfA", 8, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(131817)
mod:SetEncounterID(2118)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 260416 260333",
	"SPELL_AURA_REMOVED 260416",
	"SPELL_CAST_START 260793 260292",
	"SPELL_CAST_SUCCESS 260333"
)

--TODO, a really long normal pull to get timer interactions correct when there are no tantrums
--These don't exist on WCL, or at least not in a way they can be found easily :\
--[[
ability.id = 260333 and type = "cast"
 or (ability.id = 260793 or ability.id = 260292) and type = "begincast"
--]]
local specWarnIndigestion			= mod:NewSpecialWarningSpell(260793, "Tank", nil, nil, 1, 2)
local specWarnCharge				= mod:NewSpecialWarningDodge(260292, nil, nil, nil, 3, 2)
local specWarnTantrum				= mod:NewSpecialWarningCount(260333, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerIndigestionCD			= mod:NewCDTimer(70, 260793, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerChargeCD					= mod:NewCDTimer(20.7, 260292, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
local timerTantrumCD				= mod:NewCDTimer(13, 260333, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON)

mod:AddNamePlateOption("NPAuraMetamorphosis", 260416)

mod.vb.IndigestionCast = false--Never used more than once per cycle, whereass charge may or may not be cast twice
mod.vb.chargeCast = 0
mod.vb.tantrumCast = 0

function mod:OnCombatStart(delay)
	self.vb.IndigestionCast = false
	self.vb.chargeCast = 0
	self.vb.tantrumCast = 0
	if self.Options.NPAuraMetamorphosis then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	--he casts random ability first
	timerIndigestionCD:Start(8.3-delay)
	timerChargeCD:Start(8.3-delay)
	--timerTantrumCD:Start(45)
end

function mod:OnCombatEnd()
	if self.Options.NPAuraMetamorphosis then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 260416 then
		if self.Options.NPAuraMetamorphosis then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 8)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 260416 then
		if self.Options.NPAuraMetamorphosis then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 260793 then
		self.vb.IndigestionCast = true
		specWarnIndigestion:Show()
		specWarnIndigestion:Play("breathsoon")
		--Charge is always 12 seconds after indigiestion in EVERY combo
		--Also, regardless of time left on charg timer, Indigestion always resets charge to 12
		timerChargeCD:Stop()
		timerChargeCD:Start(12)
		if not self:IsNormal() then
			if self.vb.chargeCast == 0 then--No charge yet, it means it's one of the two Indigestion first combos
				if self.vb.tantrumCast == 0 then--Indigestion, charge, charge, Tantrum
					--Very niche combat start condition. This segment slightly longer than rest
					timerTantrumCD:Start(43.7)
				else
					--It's only Indigestion, charge, Tantrum
					timerTantrumCD:Start(26.7)
				end
			end
		else
			timerIndigestionCD:Start(45)
			--(will probably never be accurate, since WCL lacks tools to search for normal dungeons)
		end
	elseif spellId == 260292 then
		self.vb.chargeCast = self.vb.chargeCast + 1
		specWarnCharge:Show()
		specWarnCharge:Play("chargemove")
		if not self:IsNormal() then
			--If charge is first, Indigestion will always be cast 10.9 seconds after
			if not self.vb.IndigestionCast then--charge, indigestion, charge combo.
				timerIndigestionCD:Start(10.9)
				timerTantrumCD:Start(37.6)
			else--Indigestion was first, check for niche Indigestion, charge, charge, Tantrum combo
				if self.vb.tantrumCast == 0 then
					timerChargeCD:Start(20)
				end
			end
		else--On normal, just always start the 20 second timer, but allow it to still be corrected by Indigestion Cast
			timerChargeCD:Start(20)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 260333 then
		self.vb.IndigestionCast = false
		self.vb.chargeCast = 0
		self.vb.tantrumCast = self.vb.tantrumCast + 1
		timerChargeCD:Stop()
		specWarnTantrum:Show(self.vb.tantrumCast)
		specWarnTantrum:Play("aesoon")
		--Start both bars, what he uses first is random
		timerIndigestionCD:Start(18.2)
		timerChargeCD:Start(18.2)
	end
end
