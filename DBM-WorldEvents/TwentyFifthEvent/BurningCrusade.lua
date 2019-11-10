local mod	= DBM:NewMod("BCEvent", "DBM-WorldEvents", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(17968, 21212, 19622)
mod:SetEncounterID(2319)
mod:SetModelID(20939)--Archimond
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")
mod:SetWipeTime(60)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 31970",
	"SPELL_AURA_APPLIED 38280 38575 32014",
	"SPELL_AURA_REMOVED 38280",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"ZONE_CHANGED_NEW_AREA"
)

--Vashj
local warnCharge		= mod:NewTargetAnnounce(38280, 4)
--Archimonde
local warnBurst			= mod:NewTargetAnnounce(32014, 3)

--Vashj
local specWarnCharge	= mod:NewSpecialWarningMoveAway(38280, nil, nil, nil, 1, 2)
local yellCharge		= mod:NewYell(38280)
local specWarnToxic		= mod:NewSpecialWarningMove(38575, nil, nil, nil, 1, 2)
--Archimonde
local specWarnFear		= mod:NewSpecialWarningSpell(31970, nil, nil, nil, 2, 2)
local specWarnBurst		= mod:NewSpecialWarningYou(32014, nil, nil, nil, 1, 2)

mod:AddRangeFrameOption(10, 38280)

mod.vb.phase = 0
local seenAdds = {}

function mod:OnCombatStart(delay)
	table.wipe(seenAdds)
	self.vb.phase = 0
	self.vb.bossLeft = 4--Because we change it to 3 right away
	self.numBoss = 3
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 31970 then
		specWarnFear:Show()
		specWarnFear:Play("fearsoon")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 38280 then
		if args:IsPlayer() then
			specWarnCharge:Show()
			specWarnCharge:Play("runout")
			yellCharge:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		else
			warnCharge:Show(args.destName)
		end
	elseif args.spellId == 38575 and args:IsPlayer() and self:AntiSpam() then
		specWarnToxic:Show()
		specWarnToxic:Play("runaway")
	elseif args.spellId == 32014 then
		warnBurst:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnBurst:Show()
			specWarnBurst:Play("targetyou")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 38280 and args:IsPlayer() then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not seenAdds[GUID] then
			seenAdds[GUID] = true
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 17968 then--Archimonde
				self.vb.phase = self.vb.phase + 1
				self.vb.bossLeft = self.vb.bossLeft - 1
			elseif cid == 21212 then--Lady Vashj
				self.vb.phase = self.vb.phase + 1
				self.vb.bossLeft = self.vb.bossLeft - 1
			elseif cid == 19622 then--Kael
				self.vb.phase = self.vb.phase + 1
				self.vb.bossLeft = self.vb.bossLeft - 1
			end
		end
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	--Cleanup timers and scheduled events
	if IsEncounterInProgress() then return end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end
