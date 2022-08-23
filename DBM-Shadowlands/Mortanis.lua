local mod	= DBM:NewMod(2431, "DBM-Shadowlands", nil, 1192)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(167525)
mod:SetEncounterID(2410)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetMinSyncRevision(11969)
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 338848 338846 338847",
	"SPELL_CAST_SUCCESS 338851 338849",
	"SPELL_AURA_APPLIED 338850 338847 338851",
	"SPELL_AURA_REMOVED 338851"
)

--TODO, see if Screaming Skull can be target scanned to warn meteor target even faster
--TODO, anything else?
local warnFrenzy							= mod:NewTargetNoFilterAnnounce(338847, 3, nil, "Tank|Healer|RemoveEnrage")
local warnScreamingSkull					= mod:NewTargetNoFilterAnnounce(338851, 2)
local warnBoneCleave						= mod:NewSpellAnnounce(338846, 3, nil, "Tank|Healer")

--local specWarnSpineClaw						= mod:NewSpecialWarningDodge(338848, nil, nil, nil, 1, 2)
local specWarnFrenzy						= mod:NewSpecialWarningDispel(338847, "RemoveEnrage", nil, nil, 1, 2)
local specWarnScreamingSkull				= mod:NewSpecialWarningMoveTo(338851, nil, nil, 2, 1, 2)
local specWarnUnrulyremains					= mod:NewSpecialWarningDodge(338849, nil, nil, nil, 2, 2)

local timerSpineCrawlCD						= mod:NewCDTimer(20.3, 338848, nil, nil, nil, 3)
local timerFrenzyCD							= mod:NewCDTimer(33.2, 338847, nil, nil, nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON)
local timerScreamingSkullCD					= mod:NewCDTimer(26.7, 338851, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBoneCleaveCD						= mod:NewCDTimer(12.3, 338846, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerUnrulyRemainsCD					= mod:NewCDTimer(15.6, 338849, nil, nil, nil, 3)--15.6-20

mod:AddSetIconOption("SetIconOnSkull", 338851, true, false, {1})

--Ugly, but only accurate way to do it
local function checkBuff(self)
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local UnitID = "raid"..i.."target"
			local guid = UnitGUID(UnitID)
			if guid then
				local cid = self:GetCIDFromGUID(guid)
				if cid == 167525 then
					if DBM:UnitBuff(338850) then
						return true
					end
				end
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			local UnitID = "party"..i.."target"
			local guid = UnitGUID(UnitID)
			if guid then
				local cid = self:GetCIDFromGUID(guid)
				if cid == 167525 then
					if DBM:UnitBuff(338850) then
						return true
					end
				end
			end
		end
	else
		local guid = UnitGUID("target")
		if guid then
			local cid = self:GetCIDFromGUID(guid)
			if cid == 167525 then
				if DBM:UnitBuff(338850) then
					return true
				end
			end
		end
	end
	return false
end

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerSpineCrawlCD:Start(1)
		--timerFrenzyCD:Start(8)--SUCCESS
		--timerScreamingSkullCD:Start(1)--SUCCESS
		--timerBoneCleaveCD:Start(1)
		--timerUnrulyRemainsCD:Start(1)
	end
end
--"<18.46 11:59:08> [CLEU] SPELL_CAST_SUCCESS#Creature-0-4220-2222-501-167525-0000749A40#Mortanis##nil#338849#Unruly Remains#nil#nil", -- [8898]
--"<18.67 11:59:09> [CLEU] SPELL_SUMMON#Creature-0-4220-2222-501-167525-0000749A40#Mortanis#Creature-0-4220-2222-501-173385-0000749ADC#Unknown#338849#Unruly Remains#nil#nil",

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 338848 then
--		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "RetchTarget", 0.1, 6)
		timerSpineCrawlCD:Start(22)
	elseif spellId == 338846 then
		warnBoneCleave:Show()
		timerBoneCleaveCD:Start()
	elseif spellId == 339240 then--Unruly 16 yard
		specWarnUnrulyremains:Show(16)
	elseif spellId == 339241 then--Unruly 24 yard
		specWarnUnrulyremains:Show(24)
	elseif spellId == 338847 then
		timerFrenzyCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 338851 then
		timerScreamingSkullCD:Start()
	elseif spellId == 338849 then--Unruly 8 yard
		specWarnUnrulyremains:Show(8)
		specWarnUnrulyremains:Play("watchstep")
		timerUnrulyRemainsCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 338850 then
		timerSpineCrawlCD:Stop()
	elseif spellId == 338847 then
		if self.Options.SpecWarn338847dispel then
			specWarnFrenzy:Show(args.destName)
			specWarnFrenzy:Play("enrage")
		else
			warnFrenzy:Show(args.destName)
		end
	elseif spellId == 338851 then
		if args:IsPlayer() then
			specWarnScreamingSkull:Show(DBM_COMMON_L.ALLIES)
			specWarnScreamingSkull:Play("gathershare")
		else
			warnScreamingSkull:Show(args.destName)
		end
		if self.Options.SetIconOnSkull then
			self:SetIcon(args.destName, 1)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 338851 and self.Options.SetIconOnSkull then
		self:SetIcon(args.destName, 0)
	end
end
