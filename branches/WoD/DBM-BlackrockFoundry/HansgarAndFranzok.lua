local mod	= DBM:NewMod(1155, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76974, 76973)
mod:SetEncounterID(1693)
mod:SetZone()
--mod:SetUsedIcons(5, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 160838 160845 160847 160848 153470 156938",
	"SPELL_AURA_APPLIED 157139",
	"SPELL_AURA_APPLIED_DOSE 157139",
	"UNIT_TARGETABLE_CHANGED"
)

--TODO, find target scanning for skullcracker. Also, find out how it behaves when it's more than 1 target (just recast?)
--TODO, maybe use http://beta.wowhead.com/spell=154785 for aftershock/Shattered Vertebrae instead?'
local warnDisruptingRoar				= mod:NewCountAnnounce(160838, 4)--spell has 4 versions. 10 yard, 20 yard, 30 yard, 40 yard. Count used to convey which one it is.
local warnSkullcracker					= mod:NewSpellAnnounce(153470, 3, nil, false)--This seems pretty worthless.
local warnShatteredVertebrae			= mod:NewStackAnnounce(157139, 2, nil, mod:IsTank())
local warnCripplingSuplex				= mod:NewCastAnnounce(156938, 4, nil, nil, mod:IsTank())
local warnSearingPlates					= mod:NewSpellAnnounce(161570, 4)--Types
local warnPulverized					= mod:NewSpellAnnounce(174825, 4)--Types

local specWarnDisruptingRoar			= mod:NewSpecialWarningCount(160838)--"stop casting" is incorrect, you need to move away from boss for this, not stop casting.
local specWarnShatteredVertebrae		= mod:NewSpecialWarningStack(157139, nil, 2)--stack guessed
local specWarnShatteredVertebraeOther	= mod:NewSpecialWarningTaunt(157139)
local specWarnCripplingSuplex			= mod:NewSpecialWarningSpell(156938, nil, nil, nil, 3)--pop a cooldown, or die.
local specWarnEnvironmentalThreads		= mod:NewSpecialWarningSpell("ej10089", nil, nil, nil, 2)
local specWarnEnvironmentalThreadsEnd	= mod:NewSpecialWarningEnd("ej10089")

local timerDisruptingRoarCD				= mod:NewCDTimer(46, 160838)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerDisruptingRoarCD:Start(-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 160838 then
		warnDisruptingRoar:Show(10)
		specWarnDisruptingRoar:Show(10)
		timerDisruptingRoarCD:Start()
	elseif spellId == 160845 then
		warnDisruptingRoar:Show(20)
		specWarnDisruptingRoar:Show(20)
		timerDisruptingRoarCD:Start()
	elseif spellId == 160847 then
		warnDisruptingRoar:Show(30)
		specWarnDisruptingRoar:Show(30)
		timerDisruptingRoarCD:Start()
	elseif spellId == 160848 then
		warnDisruptingRoar:Show(40)
		specWarnDisruptingRoar:Show(40)
		timerDisruptingRoarCD:Start()
	elseif spellId == 153470 then
		warnSkullcracker:Show()
	elseif spellId == 156938 then
		warnCripplingSuplex:Show()
		specWarnCripplingSuplex:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 157139 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") or self:IsTanking(uId, "boss2") then--Assume this can hit non tanks at landing site too, filter them
			local amount = args.amount or 1
			warnShatteredVertebrae:Show(args.destName, amount)
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnShatteredVertebrae:Show(args.amount)
				else
					if not UnitDebuff("player", GetSpellInfo(157139)) and not UnitIsDeadOrGhost("player") then
						specWarnShatteredVertebraeOther:Show(args.destName)
					end
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--This is probably easiest way. But not only way.
function mod:UNIT_TARGETABLE_CHANGED()
	self.vb.phase = self.vb.phase + 1
	if self.vb.phase == 2 then--First belt 85% (15 Energy) (fire plates)
		warnSearingPlates:Show()
		specWarnEnvironmentalThreads:Show()
	elseif self.vb.phase == 3 then--Ended
		specWarnEnvironmentalThreadsEnd:Show()
	elseif self.vb.phase == 4 then--Second belt 55% (45 Energy) (smoosh plates)
		timerDisruptingRoarCD:Cancel()
		warnPulverized:Show()
		specWarnEnvironmentalThreads:Show()
	elseif self.vb.phase == 5 then--Ended
		specWarnEnvironmentalThreadsEnd:Show()
		timerDisruptingRoarCD:Start(7)
	elseif self.vb.phase == 6 then--Third belt 25% (75 Energy) (smoosh plates & fire plates)
		warnSearingPlates:Show()
		warnPulverized:Show()
		specWarnEnvironmentalThreads:Show()
	elseif self.vb.phase == 7 then--Ended
		specWarnEnvironmentalThreadsEnd:Show()
	end
end

--[[
local jumpSlam = GetSpellInfo(157922)
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellId)
	if spellName == jumpSlam then--Spammy debug, but this spell has ridiculous number of events in log and I have NO IDEA which one is the one we need to use without seeing it printed in chat when it happens.
		DBM:Debug(UnitName(uId).." cast "..spellName.."("..spellId..")")
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
