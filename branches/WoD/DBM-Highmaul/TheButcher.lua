local mod	= DBM:NewMod(971, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79538)
mod:SetEncounterID(1706)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 156152 156151 156160 156143",
	"SPELL_AURA_APPLIED_DOSE 156152",
	"SPELL_AURA_REMOVED 156152"
)

local warnCleave					= mod:NewSpellAnnounce(156157, 2, nil, false)
local warnBoundingCleave			= mod:NewSpellAnnounce(156160, 3)

local specWarnTenderizer			= mod:NewSpecialWarningSpell(156151, mod:IsTank())--Like sha of fear's thrash ability. On next melee hit when boss gains buff.
local specWarnCleaver				= mod:NewSpecialWarningSpell(156143, mod:IsTank())--Like sha of fear's thrash ability. On next melee hit when boss gains buff.
local specWarnGushingWounds			= mod:NewSpecialWarningStack(156152, nil, 3)
local specWarnBoundingCleave		= mod:NewSpecialWarningStack(156160, nil, nil, nil, 2)

local timerCleave					= mod:NewCDTimer(5, 156157, nil, false)
local timerGushingWounds			= mod:NewBuffFadesTimer(15, 156152)
local timerBoundingCleaveCD			= mod:NewCDTimer(30, 156160)

local adaptiveLearning1 = 0

function mod:OnCombatStart(delay)
	adaptiveLearning1 = 0
	--timerBoundingCleaveCD:Start(-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156157 then
		warnCleave:Show()
		timerCleave:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156152 and args:IsPlayer() then
		local amount = args.amount or 1
		timerGushingWounds:Start()
		if amount > 2 then
			specWarnGushingWounds:Show(amount)
		end
	elseif spellId == 156151 then
		if UnitExists("boss1") and UnitDetailedThreatSituation("player", "boss1") then--We are highest threat target
			specWarnTenderizer:Show()
		end
	elseif spellId == 156143 then
		if UnitExists("boss1") and UnitDetailedThreatSituation("player", "boss1") then--We are highest threat target
			specWarnCleaver:Show()
		end
	elseif spellId == 156160 then
		timerCleave:Cancel()
		warnBoundingCleave:Show()
		specWarnBoundingCleave:Show()
		if adaptiveLearning1 ~= 0 then
			local guessedTime = GetTime() - adaptiveLearning1
			timerBoundingCleaveCD:Start(guessedTime)
			print(guessedTime.."Seconds since last cast of Bounding Cleave. DBM is creating a CD timer for next cast using this time. This may not be accurate if timing is variable!")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 156152 and args:IsPlayer() then
		timerGushingWounds:Cancel()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 50630 and self:AntiSpam(2, 3) then--Eject All Passengers:
	
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("cFFFF0404") then

	elseif msg:find(L.tower) then

	end
end

function mod:OnSync(msg)
	if msg == "Adds" and self:AntiSpam(20, 4) and self:IsInCombat() then

	end
end--]]
