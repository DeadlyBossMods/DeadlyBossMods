local mod	= DBM:NewMod(2093, "DBM-Party-BfA", 2, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(126845, 126847, 126848)--Captain Jolly, Captain Raoul, Captain Eudora
mod:SetEncounterID(2094)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 258338 256589 257117",
	"SPELL_CAST_SUCCESS 258381"
)

--TODO: Is scanCaptains an over complication? Is the only one we can flip always Jolly?
--TODO: target scan Blackout Barrel?
--(ability.id = 258338 or ability.id = 256589 or ability.id = 257117) and type = "begincast" or ability.id = 258381 and type = "cast"
local warnLuckySevens				= mod:NewSpellAnnounce(257117, 2)

local specWarnBarrelSmash			= mod:NewSpecialWarningRun(256589, "Melee", nil, nil, 4, 2)
local specWarnBlackoutBarrel		= mod:NewSpecialWarningSwitch(258338, nil, nil, nil, 1, 2)
local specWarnGrapeShot				= mod:NewSpecialWarningDodge(258381, nil, nil, nil, 3, 2)
--local yellSwirlingScythe			= mod:NewYell(195254)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerBarrelSmashCD			= mod:NewCDTimer(22.9, 256589, nil, "Melee", nil, 3)--22.9-24.5
local timerBlackoutBarrelCD			= mod:NewCDTimer(49.7, 258338, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)
local timerGrapeShotCD				= mod:NewNextTimer(30.3, 258381, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerLuckySevensCD			= mod:NewNextTimer(29.1, 257117, nil, nil, nil, 5)

--mod.vb.Jolly = false
--mod.vb.Raoul = false
--mod.vb.Eudora = false

local function scanCaptains(self, setCaptains)
	local foundOne, foundTwo, foundThree
	for i = 1, 3 do
		local unitID = "boss"..i
		if UnitExists(unitID) and not UnitIsFriend("player", unitID) then
			local cid = self:GetUnitCreatureId(unitID)
			if not foundOne then foundOne = cid
			elseif not foundTwo then foundTwo = cid
			else foundThree = cid end
			--[[if setCaptains then--Only do on pull, if recovery, these will be synced when vb table sent
				if cid == 126845 then 
					self.vb.Jolly = true
				elseif cid == 126847 then self.vb.Raoul = true
				else self.vb.Eudora = true end
			end--]]
		end
	end
	if foundTwo and not foundThree then
		self:SetCreatureID(foundOne, foundTwo)
	else
		self:SetCreatureID(126845, 126847, 126848)
	end
end

function mod:OnCombatStart(delay)
	scanCaptains(self, true)
	timerBarrelSmashCD:Start(7.1-delay)
	timerGrapeShotCD:Start(9.5-delay)
	timerLuckySevensCD:Start(10.8-delay)
	timerBlackoutBarrelCD:Start(21.7-delay)
end

function mod:OnTimerRecovery()
	scanCaptains(self)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 258338 then
		specWarnBlackoutBarrel:Show()
		specWarnBlackoutBarrel:Play("changetarget")
		timerBlackoutBarrelCD:Start()
	elseif spellId == 256589 then
		specWarnBarrelSmash:Show()
		specWarnBarrelSmash:Play("justrun")
		timerBarrelSmashCD:Start()
	elseif spellId == 257117 then
		warnLuckySevens:Show()
		timerLuckySevensCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 258381 then
		specWarnGrapeShot:Show()
		specWarnGrapeShot:Play("stilldanger")
		timerGrapeShotCD:Start()
	end
end
