local mod	= DBM:NewMod(1147, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76906)--81315 Crack-Shot, 81197 Raider, 77487 Grom'kar Firemender, 80791 Grom'kar Man-at-Arms, 81318 Iron Gunnery Sergeant, 77560 Obliterator Cannon, 81612 Deforester
mod:SetEncounterID(1692)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155864 160140 163753",
	"SPELL_AURA_APPLIED 155921 159481 165195",
	"SPELL_AURA_APPLIED_DOSE 155921",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, maybe range finder for when Man-at_arms is out (reckless Charge)
--TODO, train timers, as well as what mobs get off with each train.
--TODO, mythic "move out of fire" warnings and maybe cast warnings too
--TODO, add audio countdown for trains when the train timers are proven good and support whole fight.
--Operator Thogar
local warnProtoGrenade				= mod:NewSpellAnnounce(155864, 3)
local warnEnkindle					= mod:NewStackAnnounce(155921, 2, nil, mod:IsTank())
local warnTrain						= mod:NewCountAnnounce(176312, 4)--Switch from generic and make informing one when mythicTrains (and non mythic trains too) are more populated.
--Adds
local warnCauterizingBolt			= mod:NewSpellAnnounce(160140, 4)
local warnIronBellow				= mod:NewSpellAnnounce(163753, 3)
local warnDelayedSiegeBomb			= mod:NewTargetAnnounce(159481, 3)

--Operator Thogar
local specWarnProtoGrenade			= mod:NewSpecialWarningMove(165195)--If target scanning works
local specWarnEnkindle				= mod:NewSpecialWarningStack(155921, nil, 2)
local specWarnEnkindleOther			= mod:NewSpecialWarningTaunt(155921)
--Adds
local specWarnCauterizingBolt		= mod:NewSpecialWarningInterrupt(160140, not mod:IsHealer())
local specWarnIronbellow			= mod:NewSpecialWarningSpell(163753, nil, nil, nil, 2)
local specWarnDelayedSiegeBomb		= mod:NewSpecialWarningYou(159481, nil, nil, nil, 3)
local yellDelayedSiegeBomb			= mod:NewYell(159481)
local specWarnManOArms				= mod:NewSpecialWarningSwitch("ej9549", not mod:IsHealer())
--local specWarnObliteration		= mod:NewSpecialWarningMove(156494)--Debuff doesn't show in combat log, and dot persists after moving out of it so warning is pretty useless right now. TODO, see if UNIT_AURA player type check can work.

--Operator Thogar
local timerProtoGrenadeCD			= mod:NewCDTimer(16, 155864)
local timerEnkindleCD				= mod:NewCDTimer(16.5, 155921, nil, mod:IsTank())
local timerTrainCD					= mod:NewNextCountTimer(15, 176312)
--Adds
--local timerCauterizingBoltCD		= mod:NewNextTimer(30, 160140)
local timerIronbellowCD				= mod:NewCDTimer(12, 163753)

mod.vb.trainCount = 0
local Train = GetSpellInfo(174806)
local Cannon = GetSpellInfo(62357)
local Reinforcements = EJ_GetSectionInfo(9537)
local ManOArms = EJ_GetSectionInfo(9549)
local Deforester = EJ_GetSectionInfo(10329)

--Shit code. I lack patience or time to do it cleaner.
local mythicTrains = {
	[1] = ManOArms.." (4)",--+7 after pull
	[2] = Deforester.." (1)",--+5 after 1
	[3] = Train.." ("..UNKNOWN..")",--+5 after 2. I forgot lane, it's a single train drive by
	[4] = Train.." ("..UNKNOWN..")",--+15 after 3. I forgot lane, it's a single train drive by
	[5] = Train..L.threeTrains,--+15 after 4
	[6] = Cannon.." (1, 4)",--+15 after 5
	[7] = Train.." ("..UNKNOWN..")",--+5 after 6. I forgot lane, it's a single train drive by
	[8] = Train.." ("..UNKNOWN..")",--+5 after 7. I forgot lane, it's a single train drive by
	[9] = Train.." ("..UNKNOWN..")",--+15 after 8. I forgot lane, it's a single train drive by
	[10] = Reinforcements.." (2, 3)",--+20 after 9
	[11] = Train.." ("..UNKNOWN..")",--+15 after 10. Don't know this one, just know it's a drive by (1 or 2 lanes)
	[12] = Train..L.threeTrains,--+15 after 11
	[13] = UNKNOWN,--+15 after 12
}
--Trains are either 20, 15 or 5.
--Also be aware that some videos WILL NOT match the above. Blizzard hotfixed order twice during testing. Above is the final order for later pulls. If first train is not manoarms, it's old, if second train is not deforester, it's old.

function mod:OnCombatStart(delay)
	self.vb.trainCount = 0
	timerProtoGrenadeCD:Start(6-delay)
	timerEnkindleCD:Start(15-delay)
	if not self.Options.ShowedThogarMessage then
		DBM:AddMsg(L.helperMessage)
		self.Options.ShowedThogarMessage = true
	end
	if self:IsMythic() then
		timerTrainCD:Start(7, 1)
	else
		--timerTrainCD:Start()
	end
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155864 then
		warnProtoGrenade:Show()
		timerProtoGrenadeCD:Start()
	elseif spellId == 160140 then
		warnCauterizingBolt:Show()
		specWarnCauterizingBolt:Show(args.sourceName)
	elseif spellId == 163753 then
		warnIronBellow:Show()
		specWarnIronbellow:Show()
		timerIronbellowCD:Start(12, args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155921 then
		local amount = args.amount or 1
		warnEnkindle:Show(args.destName, amount)
		timerEnkindleCD:Start()
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnEnkindle:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(155921)) and not UnitIsDeadOrGhost("player") then
					specWarnEnkindleOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 159481 then
		warnDelayedSiegeBomb:Show(args.destName)
		if args:IsPlayer() then
			specWarnDelayedSiegeBomb:Show()
			yellDelayedSiegeBomb:Yell()
		end
	elseif spellId == 165195 and args:IsPlayer() then
		specWarnProtoGrenade:Show()
--[[	elseif spellId == 156494 and args:IsPlayer() and self:AntiSpam() then
		specWarnObliteration:Show()--]]
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 80791 then
		timerIronbellowCD:Cancel(args.destGUID)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if target == Train then
		self.vb.trainCount = self.vb.trainCount + 1
		local count = self.vb.trainCount
		warnTrain:Show(count)
		if self:IsMythic() then
			if count >= 12 then
				print("Train Set: "..count..". DBM has no train data beyond this point. Write down lane(s) this train spawned on and what was on it and train set number and give it to us")
				return
			end
			if count == 1 or count == 2 or count == 6 or count == 7 then
				timerTrainCD:Start(5, count+1)
			elseif count == 9 then
				timerTrainCD:Start(20, count+1)
			else
				timerTrainCD:Start(15, count+1)
			end
			if count == 1 then--I'm sure they spawn again sometime later, find that data
				specWarnManOArms:Show()
			end
		else
			--Non mythic train order stuffs
		end
	end
end
