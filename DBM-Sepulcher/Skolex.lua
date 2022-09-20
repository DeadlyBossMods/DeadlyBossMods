local mod	= DBM:NewMod(2465, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181395)
mod:SetEncounterID(2542)
mod:SetHotfixNoticeRev(20220301000000)
mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 359770 359829 364778 359979 359975 360451",
	"SPELL_CAST_SUCCESS 360092",--364893
	"SPELL_AURA_APPLIED 359778 359976 359981",
	"SPELL_AURA_APPLIED_DOSE 359778 359976 359981",
	"SPELL_AURA_REMOVED 359778",
	"SPELL_AURA_REMOVED_DOSE 359778",
	"SPELL_PERIODIC_DAMAGE 366070",
	"SPELL_PERIODIC_MISSED 366070",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 359770 or ability.id = 359829 or ability.id = 359979 or ability.id = 359975 or ability.id = 364778) and type = "begincast"
 or (ability.id = 360092 or ability.id = 364893) and type = "cast"
--]]
local warnDustFlail								= mod:NewCountAnnounce(359829, 2)
local warnRend									= mod:NewStackAnnounce(359979, 2, nil, "Tank|Healer")
local warnRift									= mod:NewStackAnnounce(359976, 2, nil, "Tank|Healer")
local warnDestroy								= mod:NewCastAnnounce(364778, 4)

local specWarnRaveningBurrow					= mod:NewSpecialWarningCount(359770, nil, nil, nil, 2, 2)
local specWarnDustFlail							= mod:NewSpecialWarningCount(359829, "Healer", nil, nil, 2, 2)
local specWarnRetch								= mod:NewSpecialWarningDodgeCount(360448, nil, nil, nil, 2, 2)
local specWarnRiftmaw							= mod:NewSpecialWarningTaunt(359976, nil, nil, nil, 1, 2)
local specWarnRend								= mod:NewSpecialWarningTaunt(359979, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(366070, nil, nil, nil, 1, 8)

local timerDustflailCD							= mod:NewCDCountTimer(16.4, 359829, nil, nil, nil, 2)--16.4-17.5
local timerRetchCD								= mod:NewCDCountTimer(32.9, 360448, nil, nil, nil, 3)--32.9-35
local timerComboCD								= mod:NewTimer(33.9, "timerComboCD", 359976, nil, nil, 5, DBM_COMMON_L.TANK_ICON)
local timerBurrowCD								= mod:NewCDCountTimer(75, 359770, nil, nil, nil, 3)--LFR Only

local berserkTimer								= mod:NewBerserkTimer(420)--Final Consumption

mod:AddInfoFrameOption(359778, true, nil, 5)

mod.vb.burrowCount = 0
mod.vb.retchCount = 0
mod.vb.dustCount = 0
mod.vb.comboCount = 0
mod.vb.comboCast = 0
local EphemeraDustStacks = {}

function mod:OnCombatStart(delay)
	table.wipe(EphemeraDustStacks)
	self.vb.burrowCount = 0
	self.vb.retchCount = 0
	self.vb.dustCount = 0
	self.vb.comboCount = 0
	self.vb.comboCast = 0
	timerDustflailCD:Start(2-delay, 1)
	if self:IsHard() then
		timerComboCD:Start(7.2-delay, 1)
		timerRetchCD:Start(24.2-delay, 1)
	else
		timerComboCD:Start(8.2-delay, 1)
		timerRetchCD:Start(26.4-delay, 1)
		if self:IsLFR() then
			timerBurrowCD:Start(63.9-delay, 1)
		end
	end
	if not self:IsLFR() then -- Cannot verify for LFR, seen 10 minute+ pulls.
		berserkTimer:Start((self:IsEasy() and 420 or 360)-delay) -- 7 minutes on Normal, 6 minutes on Heroic/Mythic
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(359778))
		DBM.InfoFrame:Show(20, "table", EphemeraDustStacks, 5)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 359770 then
		self.vb.burrowCount = self.vb.burrowCount + 1
		specWarnRaveningBurrow:Show(self.vb.burrowCount)
		specWarnRaveningBurrow:Play("specialsoon")
		--Reset other spell counts
		self.vb.dustCount = 0
		--Boss energy doesn't reset, Timers continue but just get queued up and then unqueud after
		--TODO, maybe time to any timers if < 5 seconds remaining on them, but first want to see if they make changes to bosses enery, it has some bugs
		if self:IsLFR() then--Time based in LFR and only LFR
			timerBurrowCD:Start(75, self.vb.burrowCount+1)
		end
		timerComboCD:AddTime(8.5)--Only one that seems to pause/add time, the other abilities queue up
	elseif spellId == 359829 then
		self.vb.dustCount = self.vb.dustCount + 1
		if self.Options.SpecWarn359829count then
			specWarnDustFlail:Show(self.vb.dustCount)
			specWarnDustFlail:Play("aesoon")
		else
			warnDustFlail:Show(self.vb.dustCount)
		end
		timerDustflailCD:Start(self:IsHard() and 16.4 or 19.4, self.vb.dustCount+1)
	elseif args:IsSpellID(359979, 359975) then--Rend, Riftmaw
--		if self:AntiSpam(20, 1) then--In case unit event stops working
--			self.vb.comboCast = 0
--			timerComboCD:Start()
--		end
		self.vb.comboCast = self.vb.comboCast + 1
		if self.vb.comboCast > 1 then
			local targetName = self:GetBossTarget(181395)
			if targetName then
				if self:IsTanking("player", "boss1", nil, true) then
					--Do nothing
				else
					if spellId == 359975 then--Rift
						--If you aren't dead and not debuffed and not first cast in combo, taunt boss.
						if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", 359976) then
							specWarnRiftmaw:Show(targetName)
							specWarnRiftmaw:Play("tauntboss")
						end
					else
						--If you aren't dead and not debuffed and not first cast in combo, taunt boss.
						if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", 359981) then
							specWarnRend:Show(targetName)
							specWarnRend:Play("tauntboss")
						end
					end
				end
			end
		end
	elseif spellId == 364778 then
		warnDestroy:Show()
	elseif spellId == 360451 then
		self.vb.retchCount = self.vb.retchCount + 1
		specWarnRetch:Show(self.vb.retchCount)
		specWarnRetch:Play("shockwave")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 360092 then
		timerRetchCD:Start(self:IsHard() and 34 or self:IsNormal() and 37.6 or 64.4, self.vb.retchCount+1)--64-90, and maybe it can go lower or higher in LFR
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 359778 then
		local amount = args.amount or 1
		EphemeraDustStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(EphemeraDustStacks, 0.2)
		end
	elseif spellId == 359976 then--Riftmaw
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			warnRift:Show(args.destName, amount)
		end
	elseif spellId == 359981 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			warnRend:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 359778 then
		EphemeraDustStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(EphemeraDustStacks, 0.2)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 359778 then
		EphemeraDustStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(EphemeraDustStacks, 0.2)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 366070 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 360079 then--[DNT] Tank Combo
		self.vb.comboCount = self.vb.comboCount + 1
		self.vb.comboCast = 0
		timerComboCD:Start(self:IsHard() and 33.9 or 37.6, self.vb.comboCount+1)
	end
end
