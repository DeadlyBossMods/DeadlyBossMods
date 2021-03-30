local mod	= DBM:NewMod(2415, "DBM-Party-Shadowlands", 8, 1189)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162103)
mod:SetEncounterID(2361)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 322554",
--	"SPELL_CAST_SUCCESS 322574",
	"SPELL_AURA_APPLIED 323548 328494",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
ability.id = 322554 and type = "begincast"
 or ability.id = 323548 and type = "applydebuff"
--]]
local warnCastigate					= mod:NewTargetNoFilterAnnounce(322554, 4)

local specWarnCastigate				= mod:NewSpecialWarningMoveAway(322554, nil, nil, nil, 1, 2)
local yellCastigate					= mod:NewYell(322554)
local specWarnCoalesceManifestation	= mod:NewSpecialWarningSwitch(322574, "-Healer", nil, nil, 1, 2)
local specWarnSintouchedAnima		= mod:NewSpecialWarningDispel(328494, "RemoveCurse", nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerCastigateCD				= mod:NewNextTimer(20.5, 322554, nil, nil, nil, 3)
local timerCoalesceManifestationCD	= mod:NewCDTimer(29.5, 322574, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)--30 with a standard variationn of 1

mod:AddRangeFrameOption(8, 322554)
mod:AddNamePlateOption("NPAuraOnEnergy", 323548)

mod.vb.AddsActive = 0
local unitTracked = {}

function mod:CastigateTarget(targetname, uId, bossuid, scanningTime)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnCastigate:Show()
		specWarnCastigate:Play("targetyou")
		yellCastigate:Yell()
	else
		warnCastigate:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.AddsActive = 0
	table.wipe(unitTracked)
	timerCastigateCD:Start(3.7-delay)
	timerCoalesceManifestationCD:Start(14.6-delay)
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
		timerCastigateCD:Start()
		self:BossTargetScanner(args.sourceGUID, "CastigateTarget", 0.1, 8)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 323548 then
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
	elseif spellId == 328494 and args:IsDestTypePlayer() and self:CheckDispelFilter() then
		specWarnSintouchedAnima:Show(args.destName)
		specWarnSintouchedAnima:Play("helpdispel")
	end
end

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
