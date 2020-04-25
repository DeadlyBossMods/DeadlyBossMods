local mod	= DBM:NewMod(2415, "DBM-Party-Shadowlands", 8, 1189)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162103)
mod:SetEncounterID(2361)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START 322554",
	"SPELL_CAST_SUCCESS 322574",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, warn for https://shadowlands.wowhead.com/spell=328494/sintouched-anima spawns?
--TODO, figure ot how Castigate works to more accurately warn it
local warnCastigate				= mod:NewCastAnnounce(322554, 4)

local specWarnCastigate				= mod:NewSpecialWarningMoveAway(322554, nil, nil, nil, 1, 2)
--local yellCastigate				= mod:NewYell(322554)
local specWarnCoalesceManifestation	= mod:NewSpecialWarningSwitch(322574, "-Healer", nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerCastigateCD				= mod:NewAITimer(13, 322554, nil, nil, nil, 3)
local timerCoalesceManifestationCD	= mod:NewAITimer(15.8, 322574, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

mod:AddRangeFrameOption(8, 322554)
mod:AddNamePlateOption("NPAuraOnEnergy", 323548)

mod.vb.AddsActive = 0
local unitTracked = {}

function mod:OnCombatStart(delay)
	self.vb.AddsActive = 0
	table.wipe(unitTracked)
	timerCastigateCD:Start(1-delay)
	timerCoalesceManifestationCD:Start(1-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	if self.Options.NPAuraOnEnergy then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnEnergy then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 322554 then
		warnCastigate:Show()
		timerCastigateCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 322574 then
		self.vb.AddsActive = self.vb.AddsActive + 1
		specWarnCoalesceManifestation:Show()
		specWarnCoalesceManifestation:Play("killmob")
		timerCoalesceManifestationCD:Start()
		if self.Options.NPAuraOnEnergy and self.vb.AddsActive == 1 then
			self:RegisterOnUpdateHandler(function(self)
				for i = 1, 40 do
					local UnitID = "nameplate"..i
					local GUID = UnitGUID(UnitID)
					local cid = self:GetCIDFromGUID(GUID)
					if cid == 168882 then
						local unitPower = UnitPower(UnitID)
						if not unitTracked[GUID] then unitTracked[GUID] = "None" end
						if (unitPower < 30) then
							if unitTracked[GUID] ~= "Green" then
								unitTracked[GUID] = "Green"
								DBM.Nameplate:Show(true, GUID, 276299, 463281)
							end
						elseif (unitPower < 60) then
							if unitTracked[GUID] ~= "Yellow" then
								unitTracked[GUID] = "Yellow"
								DBM.Nameplate:Hide(true, GUID, 276299, 463281)
								DBM.Nameplate:Show(true, GUID, 276299, 460954)
							end
						elseif (unitPower < 90) then
							if unitTracked[GUID] ~= "Red" then
								unitTracked[GUID] = "Red"
								DBM.Nameplate:Hide(true, GUID, 276299, 460954)
								DBM.Nameplate:Show(true, GUID, 276299, 463282)
							end
						elseif (unitPower < 100) then
							if unitTracked[GUID] ~= "Critical" then
								unitTracked[GUID] = "Critical"
								DBM.Nameplate:Hide(true, GUID, 276299, 463282)
								DBM.Nameplate:Show(true, GUID, 276299, 237521)
							end
						end
					end
				end
			end, 1)
		end
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 168882 then
		DBM.Nameplate:Hide(true, args.destGUID)
		unitTracked[args.destGUID] = nil
		self.vb.AddsActive = self.vb.AddsActive - 1
		if self.vb.AddsActive == 0 then
			self:UnregisterOnUpdateHandler()--Kill scanner, no adds left
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
