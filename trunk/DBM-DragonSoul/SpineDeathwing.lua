local mod	= DBM:NewMod(318, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(53879)
mod:SetModelID(35268)
mod:SetZone()
mod:SetUsedIcons(6, 5, 4, 3, 2, 1)

mod:RegisterCombat("yell", L.Pull)--Engage trigger comes 30 seconds after encounter starts, because of this, the mod can miss the first round of ability casts such as first grip targets. have to use yell

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

local warnAbsorbedBlood		= mod:NewStackAnnounce(105248, 2)
local warnGrip				= mod:NewTargetAnnounce(109459, 4)
local warnNuclearBlast		= mod:NewCastAnnounce(105845, 4)
local warnSealArmor			= mod:NewCastAnnounce(105847, 4)--Cast by Burning Tendons when they spawn after you break a plate

local specWarnTendril		= mod:NewSpecialWarning("SpecWarnTendril")
local specWarnGrip			= mod:NewSpecialWarningSpell(109459, mod:IsDps())
local specWarnNuclearBlast	= mod:NewSpecialWarningRun(105845, mod:IsMelee())
local specWarnSealArmor		= mod:NewSpecialWarningSpell(105847, mod:IsDps())

local timerSealArmor		= mod:NewCastTimer(23, 105847)
local timerGripCD			= mod:NewCDTimer(25, 109457)

local soundNuclearBlast		= mod:NewSound(105845, nil, mod:IsMelee())

mod:AddBoolOption("InfoFrame", true)
mod:AddBoolOption("SetIconOnGrip", true)

local gripTargets = {}
local gripIcon = 6

local function checkTendrils()
	if not UnitDebuff("player", GetSpellInfo(109454)) and not UnitIsDeadOrGhost("player") then
		specWarnTendril:Show()
	end
	if mod.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
		DBM.InfoFrame:SetHeader(L.NoDebuff:format(GetSpellInfo(109454)))
		DBM.InfoFrame:Show(5, "playergooddebuff", 109454)
	end
end

local function clearTendrils()
	if mod.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

local function showGripWarning()
	warnGrip:Show(table.concat(gripTargets, "<, >"))
	specWarnGrip:Show()
	table.wipe(gripTargets)
end

function mod:OnCombatStart(delay)
	table.wipe(gripTargets)
	gripIcon = 6
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(105845) and args.sourceGUID == UnitGUID("target") then--Only warn if it's your target, if it isn't you're probably not by the one exploding.
		warnNuclearBlast:Show()
		specWarnNuclearBlast:Show()
		soundNuclearBlast:Play()
	elseif args:IsSpellID(105847) then
		warnSealArmor:Show()
		specWarnSealArmor:Show()
		timerSealArmor:Start(args.sourceGUID)--Super rare, but 2 of these might be out at same time too.
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(105490, 109457, 109458, 109459) then
		timerGripCD:Start(args.sourceGUID)--args.sourceGUID is to support multiple cds when more then 1 is up at once
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(105248) then
		warnAbsorbedBlood:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(105490, 109457, 109458, 109459) then--This ability is not used in LFR, so if you add a CD bar for this, make sure you exclude LFR.
		gripTargets[#gripTargets + 1] = args.destName
		if self.Options.SetIconOnGrip then
			if gripIcon == 0 then
				gripIcon = 6
			end
			self:SetIcon(args.destName, gripIcon)
			gripIcon = gripIcon - 1
		end
		self:Unschedule(showGripWarning)
		self:Schedule(0.3, showGripWarning)
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(105490, 109457, 109458, 109459) then
		if self.Options.SetIconOnGrip then
			self:SetIcon(args.destName, 0)
		end
	end
end	

function mod:RAID_BOSS_EMOTE(msg)--No one had any logs that were any good, so I don't have the emotes for this. NOT ALL RAID BOSS EMOTSE SHOW IN THE CHAT LOGS. there is a reason i ask for transcriptor logs
	if msg == L.DRoll or msg:find(L.DRoll) then
		self:Unschedule(checkTendrils)--In case you manage to spam spin him, we don't want to get a bunch of extra stuff scheduled.
		self:Unschedule(clearTendrils)
		checkTendrils()
		self:Schedule(3, checkTendrils)--Check more then once?
		self:Schedule(8, clearTendrils)--Clearing 3 seconds after the roll should be sufficent? Need to perfect this timing later.
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 53891 then
		timerGripCD:Cancel(args.sourceGUID)
	elseif cid == 56341 then
		timerSealArmor:Cancel(args.sourceGUID)
	end
end