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
	"SPELL_CAST_SUCCESS 157853",
	"SPELL_AURA_APPLIED 157139",
	"SPELL_AURA_APPLIED_DOSE 157139"
)

--TODO, find target scanning for skullcracker. Also, find out how it behaves when it's more than 1 target (just recast?)
--TODO, maybe use http://beta.wowhead.com/spell=154785 for aftershock/Shattered Vertebrae instead?'
--TODO, Figure out how belts work and get timers/warnings if possible.
local warnDisruptingRoar				= mod:NewCountAnnounce(160838, 4)--spell has 4 versions. 10 yard, 20 yard, 30 yard, 40 yard. Count used to convey which one it is.
local warnSkullcracker					= mod:NewSpellAnnounce(153470, 3)
local warnAftershock					= mod:NewSpellAnnounce(157853, 3)
local warnShatteredVertebrae			= mod:NewStackAnnounce(157139, 2, nil, mod:IsTank())
local warnCripplingSuplex				= mod:NewCastAnnounce(156938, 4, nil, nil, mod:IsTank())

local specWarnDisruptingRoar			= mod:NewSpecialWarningCount(160838)--"stop casting" is incorrect, you need to move away from boss for this, not stop casting.
local specWarnAftershock				= mod:NewSpecialWarningSpell(157853, nil, nil, nil, 2)
local specWarnShatteredVertebrae		= mod:NewSpecialWarningStack(157139, nil, 2)--stack guessed
local specWarnShatteredVertebraeOther	= mod:NewSpecialWarningTaunt(157139)
local specWarnCripplingSuplex			= mod:NewSpecialWarningSpell(156938, nil, nil, nil, 3)--pop a cooldown, or die.

--local timerDisruptingRoarCD			= mod:NewNextTimer(30, 160838)
--local timerCripplingSuplexCD			= mod:NewNextTimer(30, 156938, nil, mod:IsTank() or mod:IsHealer())

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 160838 then
		warnDisruptingRoar:Show(10)
		specWarnDisruptingRoar:Show(10)
	elseif spellId == 160845 then
		warnDisruptingRoar:Show(20)
		specWarnDisruptingRoar:Show(20)
	elseif spellId == 160847 then
		warnDisruptingRoar:Show(30)
		specWarnDisruptingRoar:Show(30)
	elseif spellId == 160848 then
		warnDisruptingRoar:Show(40)
		specWarnDisruptingRoar:Show(40)
	elseif spellId == 153470 then
		warnSkullcracker:Show()
	elseif spellId == 156938 then
		warnCripplingSuplex:Show()
		specWarnCripplingSuplex:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 157853 then
		warnAftershock:Show()
		specWarnAftershock:Show()
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
