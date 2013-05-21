local mod	= DBM:NewMod("d499", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 882)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"SCENARIO_UPDATE"
)

--Captain Ook
local warnOrange			= mod:NewTargetAnnounce(121895, 3)

--Captain Ook
local specWarnOrange		= mod:NewSpecialWarningSpell(121895)

--Captain Ook
--local timerOrangeCD		= mod:NewCDTimer(45, 121895)--Not good sample size, could be inaccurate

local timerKegRunner		= mod:NewAchievementTimer(240, 7232)

mod:RemoveOption("HealthFrame")

--[["<398.3 22:41:57> [CHAT_MSG_MONSTER_SAY] CHAT_MSG_MONSTER_SAY#DELICIOUS!#Brewmaster Bo###Omegal##0#0##0#1219#nil#0#false#false", -- [2789]
	"<398.3 22:41:58> [UPDATE_WORLD_STATES] |0#0#false#######0#0#0", -- [2790]
	"<398.3 22:41:58> [CLEU] SPELL_AURA_APPLIED#false#0x04000000035FAB24#Omegal#1297#0#0x04000000035FAB24#Omegal#1297#0#121934#Unga Jungle Brew#1#BUFF", -- [2791]
	"<398.3 22:41:58> [CLEU] SPELL_AURA_APPLIED#false#0x0400000005F7D31A#Zabijak#1298#0#0x0400000005F7D31A#Zabijak#1298#0#121934#Unga Jungle Brew#1#BUFF", -- [2792]
	"<403.0 22:42:02> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#YOU BETTER BE READY TO GET SOME OOK IN YER DOOKER!#Captain Ook#####0#0##0#1222#nil#0#false#false", -- [2806]--]]
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 121934 and self:AntiSpam() then
		self:SendSync("Phase3")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 62465 then--Captain Ook

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 121895 and self:AntiSpam() then
		self:SendSync("Orange")
	end
end

function mod:OnSync(msg)
	if msg == "Phase3" then
		timerKegRunner:Cancel()
--		timerOrangeCD:Start()
	elseif msg == "Orange" then
		warnOrange:Show()
		specWarnOrange:Show()
	end
end

function mod:SCENARIO_UPDATE(newStep)
	local _, currentStage = C_Scenario.GetInfo()
	if currentStage == 2 then
		timerKegRunner:Start()
	end
end
