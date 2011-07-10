local mod	= DBM:NewMod("FirelandsTrash", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5756 $"):sub(12, -3))
mod:SetModelID(38765)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_DIED",
	"ZONE_CHANGED_NEW_AREA"
)

--[[	Possible additions?
Hell Hound:		Rend Flesh (stack / timer)
Ancient Core Hound:	Fear CD? (1st = 6-13sec after first breath. 2nd = 26-31 after 1st?
]]

local warnMoltenArmor		= mod:NewStackAnnounce(99532, 3, nil, mod:IsTank() or mod:IsHealer())

local specWarnFieroblast	= mod:NewSpecialWarningInterrupt(100094, false)
local specWarnMoltenArmor	= mod:NewSpecialWarningStack(99532, mod:IsTank(), 4)

local timerMoltenArmor		= mod:NewTargetTimer(15, 99532, nil, mod:IsTank() or mod:IsHealer())

mod:AddBoolOption("RangeFrame", false)--off by default, this was NOT well recieved, furthermore, it doesn't hide if you wipe on the trash.

local surgers = 0
local surgerGUIDs = {}
do
	surgers = 0
	surgerGUIDs = {}	
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99532, 100767) then
		warnMoltenArmor:Show(args.destName, args.amount or 1)
		if args:IsPlayer() and (args.amount or 1) >= 4 then
			specWarnMoltenArmor:Show(args.amount)
		end
		timerMoltenArmor:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)	-- BoP or similar can remove the debuff?
	if args:IsSpellID(99532, 100767) then
		timerMoltenArmor:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(100094) then--Trash version of spell used on boss fight.
		if args.sourceGUID == UnitGUID("target") then
			specWarnFieroblast:Show()
		end
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
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end	
end

function mod:ZONE_CHANGED_NEW_AREA()
	if surgers > 0 then--You probably wiped on trash and don't need the range finder to get stuck open.
		surgers = 0--Reset the surgers.
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end