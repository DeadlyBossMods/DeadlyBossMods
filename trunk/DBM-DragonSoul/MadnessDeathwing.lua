local mod	= DBM:NewMod(333, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56173)--Will this work? does he die?
mod:SetModelID(40087)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("yell", L.Pull)
mod:SetMinCombatTime(20)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--local warnImpale				= mod:NewStackAnnounce(109633, 3, nil, mod:IsTank() or mod:IsHealer())
local warnElementiumBolt		= mod:NewSpellAnnounce(105651, 4)
local warnTentacle				= mod:NewSpellAnnounce(105551, 3)
local warnHemorrhage			= mod:NewSpellAnnounce(105863, 3)
local warnCataclysm				= mod:NewCastAnnounce(106523, 4)

local specWarnImpale			= mod:NewSpecialWarningYou(109632)
--local specWarnImpaleOther		= mod:NewSpecialWarningTarget(109632, mod:IsTank())
local specWarnElementiumBolt	= mod:NewSpecialWarningSpell(105651, nil, nil, nil, true)
local specWarnTentacle			= mod:NewSpecialWarning("SpecWarnTentacle", mod:IsDps())--Maybe add healer to defaults too?
local specWarnHemorrhage		= mod:NewSpecialWarningSpell(105863, mod:IsDps())

--local timerImpale				= mod:NewTargetTimer(45, 109633, nil, mod:IsTank() or mod:IsHealer())
local timerImpaleCD				= mod:NewCDTimer(30, 109633, nil, mod:IsTank() or mod:IsHealer())
local timerElementiumBlast		= mod:NewCastTimer(10, 109600)--Variable depending on nozdormu
local timerElementiumBoltCD		= mod:NewNextTimer(56, 105651)
local timerHemorrhageCD			= mod:NewNextTimer(100, 105863)
local timerCataclysm			= mod:NewCastTimer(60, 106523)
local timerCataclysmCD			= mod:NewNextTimer(130, 106523)

local lastBlistering = 0
local firstAspect = true

function mod:OnCombatStart(delay)
	lastBlistering = 0
	firstAspect = true
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(107018) then
		if firstAspect then--The abilities all come 15seconds earlier for first one only
			firstAspect = false
			timerElementiumBoltCD:Start(40)
			timerHemorrhageCD:Start(85)
			timerCataclysmCD:Start(115)
		else
			timerElementiumBoltCD:Start()
			timerHemorrhageCD:Start()
			timerCataclysmCD:Start()
		end
	elseif args:IsSpellID(106523, 110042, 110043, 110044) then
		timerCataclysmCD:Cancel()--Just in case it comes early from another minor change like firstAspect change which wasn't on PTR, don't want to confuse peope with two cata bars.
		warnCataclysm:Show()
		timerCataclysm:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(105651) then
		warnElementiumBolt:Show()
		specWarnElementiumBolt:Show()
		--timerElementiumBoltCD:Start()--Cast more then once if you're very slow?
		if not UnitBuff("player", GetSpellInfo(109624)) and not UnitIsDeadOrGhost("player") then--Check for Nozdormu's Presence
			timerElementiumBlast:Start()--Not up, explosion in 10 seconds
		else	
			timerElementiumBlast:Start(20)--Slowed by Nozdormu, explosion in 20 seconds
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(105444, 109588, 109589, 109590) and GetTime() - lastBlistering > 3 then--Tenticle spawn
		lastBlistering = GetTime()
		if not UnitBuff("player", GetSpellInfo(106028)) and not UnitIsDeadOrGhost("player") then--Check for Alexstrasza's Presence
			warnTentacle:Show()
			specWarnTentacle:Show()--It's not up so give special warning for these Tentacles.
		end
	elseif args:IsSpellID(106444, 109631, 109632, 109633) then
--		warnImpale:Show(args.destName)
--		timerImpale:Start(args.destName)
		timerImpaleCD:Start()
		if args:IsPlayer() then
			specWarnImpale:Show()
		else
--			specWarnImpaleOther:Show(args.destName)
		end
	end
end		
--[[mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(106444, 109631, 109632, 109633) then
		timerImpale:Cancel(args.destName)
	end
end--]]


function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56167 or cid == 56168 or cid == 56846 then--Wings and Arms. Why only 3 IDs? 1 missing?
		timerElementiumBoltCD:Cancel()
		timerHemorrhageCD:Cancel()--Does this one cancel in event you super overgear this and stomp his ass this fast?
		timerCataclysm:Cancel()
		timerCataclysmCD:Cancel()
	elseif cid == 56262 then--Elementium Bolt/Meteor
		timerElementiumBlast:Cancel()--Does it dying actually cancel blast? assuming so. Logs i have they never actually killed it to see.
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellID)
	if uId ~= "boss1" then return end--Anti spam to ignore all other args (like target/focus/mouseover)
	if spellName == GetSpellInfo(105853) then
		warnHemorrhage:Show()
		specWarnHemorrhage:Show()
	end
end