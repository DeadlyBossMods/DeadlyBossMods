local mod	= DBM:NewMod(318, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(53879)
mod:SetModelID(35268)
mod:SetZone()
mod:SetUsedIcons(3, 2, 1)

mod:RegisterCombat("combat")--May need to use a diff engage trigger, probably chat message.

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"RAID_BOSS_EMOTE"
--	"UNIT_DIED"
)

local warnAbsorbedBlood		= mod:NewStackAnnounce(105248, 2)
local warnGrip				= mod:NewTargetAnnounce(109459, 4)
local warnNuclearBlast		= mod:NewCastAnnounce(105845, 4)

local specWarnTendril		= mod:NewSpecialWarning("SpecWarnTendril")
local specWarnGrip			= mod:NewSpecialWarningSpell(109459, mod:IsDps())
local specWarnNuclearBlast	= mod:NewSpecialWarningRun(105845, mod:IsMelee())

local soundNuclearBlast		= mod:NewSound(105845, nil, mod:IsMelee())

mod:AddBoolOption("InfoFrame", true)
mod:AddBoolOption("SetIconOnGrip", true)

local gripTargets = {}
local gripIcon = 3

local function checkTendrils()
	if not UnitDebuff("player", GetSpellInfo(109454)) and not UnitIsDeadOrGhost("player") then
		specWarnTendril:Show()
	end
	if mod.Options.InfoFrame then
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
	gripIcon = 3
end

function mod:OnCombatStart(delay)
	table.wipe(gripTargets)
	gripIcon = 3
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
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(105248) then
		warnAbsorbedBlood:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(105490, 109457, 109458, 109459) then--This ability is not used in LFR, so if you add a CD bar for this, make sure you exclude LFR.
		gripTargets[#gripTargets + 1] = args.destName
		if self.Options.SetIconOnGrip then
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
		--self:Schedule(3, checkTendrils)--Check more then once?
		self:Schedule(8, clearTendrils)--Clearing 3 seconds after the roll should be sufficent.
	end
end
