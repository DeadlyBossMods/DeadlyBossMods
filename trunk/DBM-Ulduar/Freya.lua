local mod = DBM:NewMod("Freya", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:SetCreatureID(32906)
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)
mod:SetUsedIcons(6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

-- Trash: 33430 Guardian Lasher (flower)
-- 33355 (nymph)
-- 33354 (tree)

--
-- Elder Stonebark (ground tremor / fist of stone)
-- Elder Brightleaf (unstable sunbeam)

local warnPhase2		= mod:NewPhaseAnnounce(2, 3)
local warnSimulKill		= mod:NewAnnounce("WarnSimulKill", 1)
local warnFury			= mod:NewTargetAnnounce(63571, 2)
local warnRoots			= mod:NewAnnounce("WarnRoots", 2, 63601)

local specWarnFury		= mod:NewSpecialWarning("SpecWarnFury")
local specWarnTremor	= mod:NewSpecialWarning("WarningTremor")	-- Hard mode
local specWarnBeam		= mod:NewSpecialWarning("UnstableEnergy")	-- Hard mode

local enrage 				= mod:NewEnrageTimer(600)
local timerAlliesOfNature	= mod:NewNextTimer(60, 62678)
local timerSimulKill		= mod:NewTimer(12, "TimerSimulKill")
local timerFury				= mod:NewTargetTimer(10, 63571)
local timerTremorCD 		= mod:NewCDTimer(28, 62859)

mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("PlaySoundOnFury")

local adds = {}


function mod:OnCombatStart(delay)
	enrage:Start()
	table.wipe(adds)
end

function mod:OnCombatEnd(wipe)
	DBM.BossHealth:Hide()
	if not wipe then
		if DBM.Bars:GetBar(L.TrashRespawnTimer) then
			DBM.Bars:CancelBar(L.TrashRespawnTimer) 
		end	
	end
end


function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62519 then
		warnPhase2:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62437, 62859) then
		specWarnTremor:Show()
		timerTremorCD:Start()
	end
end 


local altIcon = true
function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(62678) then -- Summon Allies of Nature
		timerAlliesOfNature:Start()
	elseif args:IsSpellID(63571, 62589) then -- Nature's Fury
		altIcon = not altIcon	--Alternates between Skull and X
		self:SetIcon(args.destName, altIcon and 7 or 8, 10)
		warnFury:Show(args.destName)
		if args:IsPlayer() then -- only cast on players; no need to check destFlags
			if self.Options.PlaySoundOnFury then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
			specWarnFury:Show()
		end
		timerFury:Start(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SpawnYell then
		if self.Options.HealthFrame then
			if not adds[33202] then DBM.BossHealth:AddBoss(33202, L.WaterSpirit) end -- ancient water spirit
			if not adds[32916] then DBM.BossHealth:AddBoss(32916, L.Snaplasher) end  -- snaplasher
			if not adds[32919] then DBM.BossHealth:AddBoss(32919, L.StormLasher) end -- storm lasher
		end
		adds[33202] = true
		adds[32916] = true
		adds[32919] = true
	end
end

local killTime = 0
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 33202 or cid == 32916 or cid == 32919 then
		if self.Options.HealthFrame then
			DBM.BossHealth:RemoveBoss(cid)
		end
		if (GetTime() - killTime) > 20 then
			killTime = GetTime()
			timerSimulKill:Start()
			warnSimulKill:Show()
		end
		adds[cid] = nil
		local counter = 0
		for i, v in pairs(adds) do
			counter = counter + 1
		end
		if counter == 0 then
			timerSimulKill:Stop()
		end
	end

end


local rootedPlayers = {}
local function showRootWarning()
	warnRoots:Show(table.concat(rootedPlayers, "< >"))
	table.wipe(rootedPlayers)
end

local iconId = 6
function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62861, 62438) then
		iconId = iconId - 1
		self:SetIcon(args.destName, iconId, 15)
		table.insert(rootedPlayers, args.destName)
		self:Unschedule(showRootWarning)
		if #rootedPlayers >= 3 then
			showRootWarning()
		else
			self:Schedule(0.5, showRootWarning)
		end

	elseif args:IsSpellID(62451, 62865) and args:IsPlayer() then
		specWarnBeam:Show()
	end 
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(62861, 62438) then
		self:RemoveIcon(args.destName)
		iconId = iconId + 1
	end
end



