local mod	= DBM:NewMod(968, "DBM-Party-WoD", 7, 476)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76266)
mod:SetEncounterID(1701)
mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 154055",
	"SPELL_CAST_START 154055",
	"SPELL_PERIODIC_DAMAGE 154043",
	"SPELL_PERIODIC_MISSED 154043",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--On a bad pull you can very much have 3-4 adds.
)

--TODO, had bugged transcriptor so no IEEU events. See if IEEU is better for adds joining fight.
local warnCastDown			= mod:NewTargetAnnounce(153954, 4)
local warnLensFlare			= mod:NewSpellAnnounce(154032, 3)
local warnShielding			= mod:NewTargetAnnounce(154055, 2)

local specWarnCastDownSoon	= mod:NewSpecialWarningSoon(153954)--Everyone, becaus it can grab healer too, which affects healer/tank
local specWarnCastDown		= mod:NewSpecialWarningSwitch(153954, mod:IsDps(), nil, nil, 3)--Only dps, because it's their job to stop it.
local specWarnLensFlareCast	= mod:NewSpecialWarningSpell(154032, nil, nil, nil, 2)--If there is any way to find actual target, like maybe target scanning, this will be changed.
local specWarnLensFlare		= mod:NewSpecialWarningMove(154043)
local specWarnShielding		= mod:NewSpecialWarningInterrupt(154055, mod:IsDps())

local timerLenseFlareCD		= mod:NewCDTimer(38, 154032)
local timerCastDownCD		= mod:NewCDTimer(38, 153954)

mod:AddSetIconOption("SetIconOnCastDown", 153954)

mod.vb.lastGrab = nil

function mod:OnCombatStart(delay)
	self.vb.lastGrab = nil
	timerLenseFlareCD:Start(-delay)
	timerCastDownCD:Start(15-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 154055 then
		warnShielding:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 154055 then
		specWarnShielding:Show(args.sourceName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)
	if spellId == 154043 and destGUID == UnitGUID("player") and self:AntiSpam(2) then
		specWarnLensFlare:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 76267 then--Solar Zealot
		if self.Options.SetIconOnCastDown and self.vb.lastGrab then
			self:SetIcon(0, self.vb.lastGrab)
			self.vb.lastGrab = nil
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 153954 then--Cast Down (4-5 sec before pre warning)
		specWarnCastDownSoon:Show()
	elseif spellId == 165834 then--Force Demon Creator to Ride Me
		--TODO, see if victom detectable here instead
		specWarnCastDown:Show()
		timerCastDownCD:Start()
	elseif spellId == 136522 then--Force Demon Creator to Ride Me
		--TODO, see if vehicle check works here.
		for uId in DBM:GetGroupMembers() do
			if UnitInVehicle(uId) then
				self.vb.lastGrab = UnitName(uId)
				warnCastDown:Show(self.vb.lastGrab)
				if self.Options.SetIconOnCastDown then
					self:SetIcon(1, self.vb.lastGrab)
				end
				return
			end
		end
	elseif spellId == 154032 then--Actual Lens Flare cast. 154043 is not cast, despite SUCCESS event. It only fires if beam makes contact with a player. Then SPELL_CAST_SUCCESS and SPELL_AURA_APPLIED fire
		warnLensFlare:Show()
		specWarnLensFlareCast:Show()
		timerLenseFlareCD:Start()
	end
end
