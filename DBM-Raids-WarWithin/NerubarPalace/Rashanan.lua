local mod	= DBM:NewMod(2609, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(200927)
mod:SetEncounterID(2918)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20231115000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 444687 439789 455373 439784 439795 439811 454989 452806",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 444704",
	"SPELL_AURA_APPLIED_DOSE 444704"
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--NOTE, some spellIds might be mixed up with 5 man version (and viceversa). (especially with private auras)
--TODO, tune tank swap stacks
--TODO, maybe auto mark https://www.wowhead.com/beta/spell=434579/corrosion so still assign clears by icon
--TODO, maybe use https://www.wowhead.com/beta/spell=455287/infested-bite to announce or mark infested spawns after the fact for healing?
--TODO, target scan Web Reave? Or probably CHAT_MSG_RAID_BOSS_EMOTE or WHISPER. it's not a private aura (yet)
--TODO, emphasize Enveloping webs cast itself? will probably only have a soon warning for it that's emphasized with a precise timer
--TODO, actually detect her retreating on phase changes to stop/restart timers (possibly https://www.wowhead.com/beta/spell=457877/acidic-carapace)
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(27649))
local warnSavageAssault							= mod:NewStackAnnounce(444687, 2, nil, "Tank|Healer")
local warnRollingAcid							= mod:NewIncomingCountAnnounce(439789, 2)--General announce, private aura sound will be personal emphasis
local warnInfestedSpawn							= mod:NewIncomingCountAnnounce(455373, 2)
local warnSpinneretsStrands						= mod:NewIncomingCountAnnounce(439784, 3)--General announce, private aura sound will be personal emphasis
local warnErosiveSpray							= mod:NewCountAnnounce(439811, 2)
local warnEnvelopingWebs						= mod:NewCountAnnounce(454989, 4)
local warnAcidEruption							= mod:NewCastAnnounce(452806, 4)

local specWarnSavageAssault						= mod:NewSpecialWarningDefensive(444687, nil, nil, nil, 1, 2)
local specWarnSavageAssaultStack				= mod:NewSpecialWarningStack(444687, nil, 12, nil, nil, 1, 6)
local specWarnSavageAssaultSwap					= mod:NewSpecialWarningTaunt(444687, nil, nil, nil, 1, 2)
local specWarnWebReave							= mod:NewSpecialWarningCount(439795, nil, nil, nil, 2, 2)
--local yellSearingAftermath					= mod:NewShortYell(422577)
--local yellSearingAftermathFades				= mod:NewShortFadesYell(422577)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerSavageAssaultCD						= mod:NewAITimer(49, 444687, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRollingAcidCD						= mod:NewAITimer(21.3, 439789, nil, nil, nil, 3)
local timerInfestedSpawnCD						= mod:NewAITimer(21.3, 455373, nil, nil, nil, 1)
local timerSpinneretsStrandsCD					= mod:NewAITimer(33.9, 439784, nil, nil, nil, 3)
local timerWebReaveCD							= mod:NewAITimer(49, 439795, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerErosiveSprayCD						= mod:NewAITimer(49, 439811, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerEnvelopingWebsCD						= mod:NewAITimer(49, 454989, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)

--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, 0, {1, 2, 3})
mod:AddPrivateAuraSoundOption(434406, true, 439789, 1)--Rolling Acid target
mod:AddPrivateAuraSoundOption(455284, true, 455373, 1)--Infested Spawn target
mod:AddPrivateAuraSoundOption(439783, true, 439784, 1)--Spineret's Strands target

mod.vb.assaultCount = 0
mod.vb.rollingCount = 0
mod.vb.spawnCount = 0
mod.vb.strandsCount = 0
mod.vb.reaveCount = 0
mod.vb.sprayCount = 0
mod.vb.envelopingCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.assaultCount = 0
	self.vb.rollingCount = 0
	self.vb.spawnCount = 0
	self.vb.strandsCount = 0
	self.vb.reaveCount = 0
	self.vb.sprayCount = 0
	self.vb.envelopingCount = 0
	timerSavageAssaultCD:Start(1)
	timerRollingAcidCD:Start(1)
	timerInfestedSpawnCD:Start(1)
	timerSpinneretsStrandsCD:Start(1)
	timerWebReaveCD:Start(1)
	timerErosiveSprayCD:Start(1)
	if self:IsMythic() then
		timerEnvelopingWebsCD:Start(1)
	end
	self:EnablePrivateAuraSound(434406, "targetyou", 2)--Likely dungeon version of Rolling Acid
	self:EnablePrivateAuraSound(439790, "targetyou", 2, 434406)--Likely the raid version of Rolling Acid
	self:EnablePrivateAuraSound(455284, "mobout", 2)--Maybe better sound later, but this one does say "mob out" as in "mob on you, get out and spread" which is the mechanic
	self:EnablePrivateAuraSound(439815, "mobout", 2, 455284)--Secondary ID for Infested Spawn
	self:EnablePrivateAuraSound(439783, "pullin", 12)--Likely the dungeon version of Spinneret's Strands
	self:EnablePrivateAuraSound(434090, "pullin", 12, 439783)--Likely the raid version of Spinneret's Strands
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 444687 then
		self.vb.assaultCount = self.vb.assaultCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnSavageAssault:Show()
			specWarnSavageAssault:Play("defensive")
		end
		timerSavageAssaultCD:Start()
	elseif spellId == 439789 then
		self.vb.rollingCount = self.vb.rollingCount + 1
		warnRollingAcid:Show(self.vb.rollingCount)
		timerRollingAcidCD:Start()--nilil, self.vb.rollingCount+1
	elseif spellId == 455373 then
		self.vb.spawnCount = self.vb.spawnCount + 1
		warnInfestedSpawn:Show()
		timerInfestedSpawnCD:Start()
	elseif spellId == 439784 then
		self.vb.strandsCount = self.vb.strandsCount + 1
		warnSpinneretsStrands:Show(self.vb.strandsCount)
		timerSpinneretsStrandsCD:Start()
	elseif spellId == 439795 then
		self.vb.reaveCount = self.vb.reaveCount + 1
		specWarnWebReave:Show(self.vb.reaveCount)
		specWarnWebReave:Play("gathershare")
		timerWebReaveCD:Start()
	elseif spellId == 439811 then
		self.vb.sprayCount = self.vb.sprayCount + 1
		warnErosiveSpray:Show(self.vb.sprayCount)
		timerErosiveSprayCD:Start()
	elseif spellId == 454989 then
		self.vb.envelopingCount = self.vb.envelopingCount + 1
		warnEnvelopingWebs:Show(self.vb.envelopingCount)
		timerEnvelopingWebsCD:Start()
	elseif spellId == 452806 then
		--TEMP CODE
		if self:GetStage(1) then
			self:SetStage(2)
			warnAcidEruption:Show()
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 422277 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 444704 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 12 then--Tuned giga high for now. obviously fix later
				if args:IsPlayer() then
					specWarnSavageAssaultStack:Show(amount)
					specWarnSavageAssaultStack:Play("stackhigh")
				else
					if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then
						specWarnSavageAssaultSwap:Show(args.destName)
						specWarnSavageAssaultSwap:Play("tauntboss")
					else
						warnSavageAssault:Show(args.destName, amount)
					end
				end
			else
				warnSavageAssault:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 421656 then

	end
end
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 421532 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 209800 then--cycle-warden

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 426144 then

	end
end
--]]
