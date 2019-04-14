local mod	= DBM:NewMod(2131, "DBM-Party-BfA", 8, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(string.sub("@file-date-integer@", 1, -5))
mod:SetCreatureID(131817)
mod:SetEncounterID(2118)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 260416 260333",
	"SPELL_AURA_REMOVED 260416",
	"SPELL_CAST_START 260793 260292",
	"SPELL_CAST_SUCCESS 260333",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
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

local timerIndigestionCD			= mod:NewCDTimer(70, 260793, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerChargeCD					= mod:NewCDTimer(20.7, 260292, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerTantrumCD				= mod:NewCDTimer(13, 260333, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)

mod:AddNamePlateOption("NPAuraMetamorphosis", 260416)

mod.vb.IndigestionCast = false--Never used more than once per cycle, whereass charge is always may or may not be cast twice
mod.vb.tantrumCast = 0

function mod:OnCombatStart(delay)
	self.vb.IndigestionCast = false
	self.vb.tantrumCast = 0
	if self.Options.NPAuraMetamorphosis then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	--he casts random ability first
	timerIndigestionCD:Start(8.3-delay)
	timerChargeCD:Start(8.3-delay)
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
		--Regardless of whether the 20 seconds will be up before then, Indigestion always resets charge to 12
		timerChargeCD:Stop()
		local checkTantrum = timerTantrumCD:GetRemaining() or 100--If timer doesn't exist set to 100 (like normal mode)
		if checkTantrum > 12 then
			timerChargeCD:Start(12)
		end
	elseif spellId == 260292 then
		specWarnCharge:Show()
		specWarnCharge:Play("chargemove")
		--If not cast first, it'll be cast 10.9 seconds after the first charge cast
		if not self.vb.IndigestionCast or self:IsNormal() then--Normal is guesswork, and very likely wrong
			timerIndigestionCD:Start(10.9)
		else
			--Very niche combat start condition. This segment slightly longer than rest
			--As such, it's the ONLY time he'll double charge if Indigestion was first
			if self.vb.tantrumCast == 0 then
				timerChargeCD:Start()
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 260333 then
		self.vb.IndigestionCast = false
		self.vb.tantrumCast = self.vb.tantrumCast + 1
		timerChargeCD:Stop()
		specWarnTantrum:Show(self.vb.tantrumCast)
		specWarnTantrum:Play("aesoon")
		--Start both bars, what he uses first is random
		timerIndigestionCD:Start(18.2)
		timerChargeCD:Start(18.2)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 271775 then--Tantrum Energy Bar
		timerTantrumCD:Start(15)
	end
end
