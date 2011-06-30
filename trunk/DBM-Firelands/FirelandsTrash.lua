local mod	= DBM:NewMod("FirelandsTrash", "DBM-BastionTwilight")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5756 $"):sub(12, -3))
mod:SetModelID(38765)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_DIED"
)

--[[	Possible additions?
Hell Hound:		Rend Flesh (stack / timer)
Ancient Core Hound:	Fear CD? (1st = 6-13sec after first breath. 2nd = 26-31 after 1st?
]]

local warnMoltenArmor		= mod:NewStackAnnounce(99532, 3, nil, mod:IsTank() or mod:IsHealer())

local timerMoltenArmor		= mod:NewTargetTimer(15, 99532, nil, mod:IsTank() or mod:IsHealer())

local specWarnMoltenArmor	= mod:NewSpecialWarningStack(99532, 4, nil, mod:IsTank())

mod:AddBoolOption("RangeFrame", true)

local surgers = 0
local surgerGUIDs = {}
do
	surgers = 0
	surgerGUIDs = {}	
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99532) then
		if (args.amount or 1) % 2 == 0 then
			warnMoltenArmor:Show(args.destName, args.amount or 1)
		end
		if args:IsPlayer() and (args.amount or 1) >= 4 then
			specWarnMoltenArmor:Show(args.amount)
		end
		timerMoltenArmor:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)	-- BoP or similar can remove the debuff?
	if args:IsSpellID(99532) then
		timerMoltenArmor:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(100012) and not surgerGUIDs[args.sourceGUID] then
		surgers = surgers + 1
		surgerGUIDs[args.sourceGUID] = 1
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	end
end
			
function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 53141 then
		surgers = surgers - 1
		if surgers <= 0 then 
			surgers = 0
			DBM.RangeCheck:Hide()
		end
	end	
end