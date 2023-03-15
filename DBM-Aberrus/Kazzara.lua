local mod	= DBM:NewMod(2522, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(201261)
mod:SetEncounterID(2688)
mod:SetUsedIcons(1, 2, 3, 4, 5)
mod:SetHotfixNoticeRev(20230310000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 401319 406516 407198 407199 407200 407069 400430 403326 404744",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 406525 402253 404743",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 406525 402253",
	"SPELL_PERIODIC_DAMAGE 406530 402207 402420",
	"SPELL_PERIODIC_MISSED 406530 402207 402420"
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, Hellsteel Carnage is health triggered so no timer, but does triggering Hellsteel Carnage reset other timers?
--TODO, maybe start ray timer from rift event instead, of it's a secondary activation of rifts
--TODO, verify rays mechnanic. does it go on people who spawned rifts before them, or a new set of players after. can we detect what rift something is coming from so direct them to a different rift?
--local warnFlamerift								= mod:NewTargetNoFilterAnnounce(390715, 2)
local warnDreadRifts								= mod:NewTargetCountAnnounce(406516, 3, nil, nil, nil, nil, nil, nil, true)
local warnDreadRayofAnguish							= mod:NewTargetCountAnnounce(407069, 4, nil, nil, nil, nil, nil, nil, true)
--local warnBurningWound							= mod:NewStackAnnounce(394906, 2, nil, "Tank|Healer")

local specWarnHellsteelCarnage						= mod:NewSpecialWarningDodgeCount(401319, nil, nil, nil, 2, 2)
local specWarnDreadRift								= mod:NewSpecialWarningYouPos(406525, nil, nil, nil, 1, 2)
local yellDreadRift									= mod:NewShortPosYell(406525)
local yellDreadRiftFades							= mod:NewIconFadesYell(406525)
local specWarnRayofAnguish							= mod:NewSpecialWarningYouPos(402253, nil, nil, nil, 1, 2)
local yellRayofAnguish								= mod:NewShortPosYell(402253)
--local yellRayofAnguishFades						= mod:NewIconFadesYell(402253)--Maybe used on lower difficulties where duration isn't infinite?
local specWarnHellbeam								= mod:NewSpecialWarningDodgeCount(400430, nil, nil, nil, 2, 2)
local specWarnWindsofExtinction						= mod:NewSpecialWarningCount(403326, nil, nil, nil, 2, 13)
local specWarnTerrorClaws							= mod:NewSpecialWarningDefensive(404744, nil, nil, nil, 1, 2)
local specWarnTerrorClawsTaunt						= mod:NewSpecialWarningTaunt(404744, nil, nil, nil, 1, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(406530, nil, nil, nil, 1, 8)
--
local timerDreadRiftsCD								= mod:NewAITimer(29.9, 406516, nil, nil, nil, 3)
local timerRaysofAnguishCD							= mod:NewAITimer(29.9, 407069, nil, nil, nil, 3)
local timerHellbeamCD								= mod:NewAITimer(28.9, 400430, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerWingsofExtinctionCD						= mod:NewAITimer(28.9, 403326, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerTerrorClawsCD							= mod:NewAITimer(28.9, 404744, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddInfoFrameOption(361651, true)
--mod:AddRangeFrameOption(5, 390715)
mod:AddSetIconOption("SetIconOnDreadRifts", 406516, true, 0, {1, 2, 3, 4, 5})
mod:AddSetIconOption("SetIconOnRayofAnguish", 407069, true, 0, {1, 2, 3, 4, 5})
--mod:AddNamePlateOption("NPAuraOnAscension", 385541)
mod:GroupSpells(406516, 406525)--Group Dread Rifts with Dread Rift
mod:GroupSpells(407069, 402253)--Group Rays with Ray

mod.vb.carnageCount = 0
mod.vb.riftsCount = 0
mod.vb.riftIcon = 1
mod.vb.rayCount = 0
mod.vb.rayIcon = 1
mod.vb.hellCount = 0
mod.vb.wingsCount = 0

function mod:OnCombatStart(delay)
	self.vb.carnageCount = 0
	self.vb.riftsCount = 0
	self.vb.riftIcon = 1
	self.vb.rayCount = 0
	self.vb.rayIcon = 1
	self.vb.hellCount = 0
	self.vb.wingsCount = 0
	timerDreadRiftsCD:Start(1)
	timerRaysofAnguishCD:Start(1)
	timerHellbeamCD:Start(1)
	timerWingsofExtinctionCD:Start(1)
	timerTerrorClawsCD:Start(1)
--	if self.Options.NPAuraOnAscension then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnAscension then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
--end


function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 401319 then
		self.vb.carnageCount = self.vb.carnageCount + 1
		specWarnHellsteelCarnage:Show(self.vb.carnageCount)
		specWarnHellsteelCarnage:Play("watchstep")
	elseif args:IsSpellID(406516, 407198, 407199, 407200) then--1 or 2 rifts, 2 or 3 rifts, 3 or 4 rifts, 4 or 5 rifts
		self.vb.riftsCount = self.vb.riftsCount + 1
		self.vb.riftIcon = 1
		timerDreadRiftsCD:Start()
	elseif spellId == 407069 then
		self.vb.rayCount = self.vb.rayCount + 1
		self.vb.rayIcon = 1
		timerRaysofAnguishCD:Start()
	elseif spellId == 400430 then
		self.vb.hellCount = self.vb.hellCount + 1
		specWarnHellbeam:Show(self.vb.hellCount)
		specWarnHellbeam:Play("watchstep")
		timerHellbeamCD:Start()
	elseif spellId == 403326 then
		self.vb.wingsCount = self.vb.wingsCount + 1
		specWarnWindsofExtinction:Show(self.vb.wingsCount)
		specWarnWindsofExtinction:Play("pushbackincoming")
		timerWingsofExtinctionCD:Start()
	elseif spellId == 404744 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnTerrorClaws:Show()
			specWarnTerrorClaws:Play("defensive")
		end
		timerTerrorClawsCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 394917 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 406525 then
		local icon = self.vb.riftIcon
		if self.Options.SetIconOnDreadRifts then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnDreadRift:Show(self:IconNumToTexture(icon))
			specWarnDreadRift:Play("mm"..icon)
			yellDreadRift:Yell(icon, icon)
			yellDreadRiftFades:Countdown(spellId, nil, icon)
		end
		warnDreadRifts:CombinedShow(0.5, self.vb.riftsCount, args.destName)
		self.vb.riftIcon = self.vb.riftIcon + 1
	elseif spellId == 402253 then
		local icon = self.vb.rayIcon
		if self.Options.SetIconOnRayofAnguish then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRayofAnguish:Show()--self:IconNumToTexture(icon)
			specWarnRayofAnguish:Play("targetyou")--"mm"..icon
			yellRayofAnguish:Yell(icon, icon)
--			yellRayofAnguishFades:Countdown(spellId, nil, icon)
		end
		warnDreadRayofAnguish:CombinedShow(0.5, self.vb.rayCount, args.destName)
		self.vb.rayIcon = self.vb.rayIcon + 1
	elseif spellId == 404743 and not args:IsPlayer() then
		specWarnTerrorClawsTaunt:Show(args.destName)
		specWarnTerrorClawsTaunt:Play("tauntboss")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 406525 then
		if self.Options.SetIconOnDreadRifts then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellDreadRiftFades:Cancel()
		end
	elseif spellId == 402253 then
		if self.Options.SetIconOnRayofAnguish then
			self:SetIcon(args.destName, 0)
		end
--		if args:IsPlayer() then
--			yellRayofAnguishFades:Cancel()
--		end
	end
end


function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 406530 or spellId == 402207 or spellId == 402420) and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 199233 then

	end
end
--]]

--function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
--	if spellId == 396734 then
--
--	end
--end
