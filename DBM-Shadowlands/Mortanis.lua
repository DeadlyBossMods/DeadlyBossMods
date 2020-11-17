local mod	= DBM:NewMod(2431, "DBM-Shadowlands", nil, 1192)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(173104)
mod:SetEncounterID(2410)
mod:SetReCombatTime(20)
--mod:SetMinSyncRevision(11969)
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 338848 338846 339239 339240 339241",
	"SPELL_CAST_SUCCESS 338847 338851",
	"SPELL_AURA_APPLIED 338850 338847 338851",
	"SPELL_AURA_REMOVED 338850 338851"
)

--TODO, activate two CD code for self.vb.crawlReduced when times known
--TODO, see if Screaming Skull can be target scanned to warn meteor target even faster
--TODO, anything else?
local warnFrenzy							= mod:NewTargetNoFilterAnnounce(338847, 3, nil, "Tank|Healer|RemoveEnrage")
local warnScreamingSkull					= mod:NewTargetNoFilterAnnounce(338851, 2)
local warnBoneCleave						= mod:NewSpellAnnounce(338846, 3, nil, "Tank|Healer")
local warnUnrulyRemains						= mod:NewCountAnnounce(339239, 2)

local specWarnSpineClaw						= mod:NewSpecialWarningDodge(338848, nil, nil, nil, 1, 2)
local specWarnFrenzy						= mod:NewSpecialWarningDispel(338847, "RemoveEnrage", nil, nil, 1, 2)
local specWarnScreamingSkull				= mod:NewSpecialWarningMoveTo(338851, nil, nil, nil, 3, 2)
local specWarnUnrulyremains					= mod:NewSpecialWarningDodgeCount(339239, nil, nil, nil, 2, 2)

--local timerSpineCrawlCD					= mod:NewCDTimer(82.0, 338848, nil, nil, nil, 3)
local timerFrenzyCD							= mod:NewAITimer(82.0, 338847, nil, nil, nil, 5, nil, DBM_CORE_L.ENRAGE_ICON)
local timerScreamingSkullCD					= mod:NewAITimer(82.0, 338851, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
local timerBoneCleaveCD						= mod:NewAITimer(82.0, 338846, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerUnrulyRemainsCD					= mod:NewCDTimer(82.0, 339239, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnSkull", 338851, true, false, {1})

mod.vb.crawlReduced = false

function mod:RetchTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSpineClaw:Show()
		specWarnSpineClaw:Play("watchstep")
	elseif self:CheckNearby() then
		specWarnSpineClaw:Show()
		specWarnSpineClaw:Play("watchstep")
	end
	DBM:AddMsg("RetchTarget returned: "..targetname.." Report if accurate or inaccurate to DBM Author")
end

--Ugly, but only accurate way to do it
local function checkBuff(self)
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local UnitID = "raid"..i.."target"
			local guid = UnitGUID(UnitID)
			if guid then
				local cid = self:GetCIDFromGUID(guid)
				if cid == 173104 then
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
				if cid == 173104 then
					if DBM:UnitBuff(338850) then
						return true
					end
				end
			end
		end
	else--Solo Raid?, maybe in classic TBC or classic WRATH. Future proofing the mod
		local guid = UnitGUID("target")
		if guid then
			local cid = self:GetCIDFromGUID(guid)
			if cid == 173104 then
				if DBM:UnitBuff(338850) then
					return true
				end
			end
		end
	end
	return false
end

function mod:OnCombatStart(delay, yellTriggered)
	if checkBuff(self) then
		self.vb.crawlReduced = true
	else
		self.vb.crawlReduced = false
	end
	if yellTriggered then
		--timerSpineCrawlCD:Start(1)
		--timerFrenzyCD:Start(1)--SUCCESS
		--timerScreamingSkullCD:Start(1)--SUCCESS
		--timerBoneCleaveCD:Start(1)
		--timerUnrulyRemainsCD:Start(1)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 338848 then
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "RetchTarget", 0.1, 6)
		--timerSpineCrawlCD:Start(self.vb.crawlReduced and 10 or 20)
	elseif spellId == 338846 then
		warnBoneCleave:Show()
		timerBoneCleaveCD:Start()
	elseif spellId == 339239 then--Unruly 8 yard
		specWarnUnrulyremains:Show(8)
		specWarnUnrulyremains:Play("watchstep")
		timerUnrulyRemainsCD:Start()
	elseif spellId == 339240 then--Unruly 16 yard
		specWarnUnrulyremains:Show(16)
	elseif spellId == 339241 then--Unruly 24 yard
		specWarnUnrulyremains:Show(24)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 338847 then
		timerFrenzyCD:Start()
	elseif spellId == 338851 then
		timerScreamingSkullCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 338850 then
		self.vb.crawlReduced = true
	elseif spellId == 338847 then
		if self.Options.SpecWarn338847dispel then
			specWarnFrenzy:Show(args.destName)
			specWarnFrenzy:Play("enrage")
		else
			warnFrenzy:Show(args.destName)
		end
	elseif spellId == 338851 then
		if args:IsPlayer() then
			specWarnScreamingSkull:Show(DBM_CORE_L.ALLIES)
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
	if spellId == 338850 then
		self.vb.crawlReduced = false
	elseif spellId == 338851 and self.Options.SetIconOnSkull then
		self:SetIcon(args.destName, 0)
	end
end
