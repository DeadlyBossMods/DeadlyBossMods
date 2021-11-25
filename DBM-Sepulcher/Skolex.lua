local mod	= DBM:NewMod(2465, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(175730)
mod:SetEncounterID(2542)
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(20210902000000)
--mod:SetMinSyncRevision(20210706000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 359770 359829 360448 364778",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 359778 364522 359976",
	"SPELL_AURA_APPLIED_DOSE 359778",
	"SPELL_AURA_REMOVED 359778",
	"SPELL_AURA_REMOVED_DOSE 359778",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_SPELLCAST_START boss1"
)

--TODO, probably use https://ptr.wowhead.com/spell=359777/unending-hunger to resume timers at REMOVED, if it's in combat log
--TODO, do timers estart when raid triggers a hunger, or do they pause?
--TODO, maybe go all out with some ra-den level shit and calculate who's tank
--then calculate 3 furhtest targets from tank (which assumes they're also 3 furthest from boss
--which then enables showing them on infoframe, marking them, and even auto rangecheck opening if player is one of the 3, for Dust Blast mechanic
--TODO, verify Retch target scan
--TODO, properly detecting devouring blood nd pre warning for it?
--TODO, fix tank combo if spellids wrong or if better way to reset count
--TODO, fix rend bsaed on who it targets and whether or not tank can dodge it. can't imagine they are meant to eat 179863 damage though
--TODO, is https://ptr.wowhead.com/spell=359913/wormhole-jaws persistant on all melee swings or a buff boss gains periodically that should have timer/alert?
local warnDustFlail								= mod:NewCountAnnounce(359829, 2)
local warnRetch									= mod:NewTargetNoFilterAnnounce(360448, 3)
local warnRend									= mod:NewCountAnnounce(359979, 2, nil, "Tank|Healer")
local warnRift									= mod:NewCountAnnounce(359976, 2, nil, "Tank|Healer")
local warnDestroy								= mod:NewCastAnnounce(364778, 4)

local specWarnUnendingHunger					= mod:NewSpecialWarningCount(359770, nil, nil, nil, 2, 2)
local specWarnDustFlail							= mod:NewSpecialWarningCount(359829, "Healer", nil, nil, 2, 2)
local specWarnRetch								= mod:NewSpecialWarningYou(360448, nil, nil, nil, 1, 2)
local yellRetch									= mod:NewYell(360448)
local specWarnRetchNear							= mod:NewSpecialWarningClose(360448, nil, nil, nil, 1, 2)
local specWarnDevouringBlood					= mod:NewSpecialWarningDispel(364522, "RemoveMagic", nil, nil, 1, 2)
--local specWarnRend							= mod:NewSpecialWarningDodge(359979, "Tank", nil, nil, 2, 2)--Does this target tank or random player?
local specWarnRiftmaw							= mod:NewSpecialWarningTaunt(359976, nil, nil, nil, 1, 2)
--local yellRetchFades							= mod:NewShortFadesYell(360448)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerDustflailCD							= mod:NewAITimer(28.8, 359829, nil, nil, nil, 2)
local timerRetchCD								= mod:NewAITimer(28.8, 360448, nil, nil, nil, 3)
local timerDevouringBloodCD						= mod:NewAITimer(28.8, 364522, nil, nil, nil, 3)
local timerDustBlastCD							= mod:NewAITimer(28.8, 359904, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--used for tank combo and blast, it's all together

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(359778, true)
mod:AddSetIconOption("SetIconOnRetch", 360448, true, false, {1})
--mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)

mod.vb.hungerCount = 0
mod.vb.dustCount = 0
mod.vb.comboCount = 0
local EphemeraDustStacks = {}

function mod:RetchTarget(targetname, uId)
	if not targetname then return end
	if self.Options.SetIconOnRetch then
		self:SetIcon(targetname, 1, 4)--So icon clears 1 second after
	end
	if targetname == UnitName("player") then
		specWarnRetch:Show()
		specWarnRetch:Play("targetyou")
		yellRetch:Yell()
--		yellRetchFades:Countdown(2.97)--This scan method doesn't support scanningTime, but should be about right
	elseif self:CheckNearby(10, targetname) then
		specWarnRetchNear:Show(targetname)
		specWarnRetchNear:Play("runaway")
	else
		warnRetch:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(EphemeraDustStacks)
	self.vb.hungerCount = 0
	self.vb.dustCount = 0
	self.vb.comboCount = 0
	timerDustflailCD:Start(1-delay)
	timerRetchCD:Start(1-delay)
	timerDevouringBloodCD:Start(1-delay)
	timerDustBlastCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(359778))
		DBM.InfoFrame:Show(20, "table", EphemeraDustStacks, 1)
	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

--[[
function mod:OnTimerRecovery()

end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 359770 then
		self.vb.hungerCount = self.vb.hungerCount + 1
		specWarnUnendingHunger:Show(self.vb.hungerCount)
		specWarnUnendingHunger:Play("specialsoon")
		--Reset other spell counts
		self.vb.dustCount = 0
		--Stop/restart timers (or pause/resume them?
		timerDustflailCD:Stop()
		timerRetchCD:Stop()
		timerDevouringBloodCD:Stop()
		timerDustBlastCD:Stop()
		timerDustflailCD:Start(2)
		timerRetchCD:Start(2)
		timerDevouringBloodCD:Start(2)
		timerDustBlastCD:Start(2)
	elseif spellId == 359829 then
		self.vb.dustCount = self.vb.dustCount + 1
		if self.Options.SpecWarn359829count then
			specWarnDustFlail:Show(self.vb.dustCount)
			specWarnDustFlail:Play("aesoon")
		else
			warnDustFlail:Show(self.vb.dustCount)
		end
		timerDustflailCD:Start()
	elseif spellId == 360448 then
		--Warnings handled in UNIT event handler, unless that doesn't work
		timerRetchCD:Start()
	elseif args:IsSpellID(359979, 359975) then--Rend, Riftmaw
		if self:AntiSpam(20, 1) then
			self.vb.comboCount = 0
			timerDustBlastCD:Start()
		end
		self.vb.comboCount = self.vb.comboCount + 1
		if spellId == 359979 then
			warnRend:Show(self.vb.comboCount)
		else
			warnRift:Show(self.vb.comboCount)
		end
	elseif spellId == 364778 then
		warnDestroy:Show()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 353931 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 359778 then
		local amount = args.amount or 1
		EphemeraDustStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(EphemeraDustStacks)
		end
	elseif spellId == 364522 and args:IsDestTypePlayer() and self:CheckDispelFilter() then
		specWarnDevouringBlood:CombinedShow(0.5, args.destName)
		specWarnDevouringBlood:ScheduleVoice(0.5, "helpdispel")
	elseif spellId == 359976 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) and not args:IsPlayer() and not UnitIsDeadOrGhost("player") then
			specWarnRiftmaw:Show(args.destName)
			specWarnRiftmaw:Play("tauntboss")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 359778 then
		EphemeraDustStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(EphemeraDustStacks)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 359778 then
		EphemeraDustStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(EphemeraDustStacks)
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 180323 then

	end
end
-]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 364511 then--Devouring Blood
		timerDevouringBloodCD:Start()
	end
end


function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 360448 then
		self:BossUnitTargetScanner(uId, "RetchTarget", 1)
	end
end

