local mod	= DBM:NewMod("ForgemasterGarfrost", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36494)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CREATE",
	"CHAT_MSG_RAID_BOSS_WHISPER"
)

local warnForgeWeapon			= mod:NewSpellAnnounce(70335)
local warnDeepFreeze			= mod:NewTargetAnnounce(70384)
local warnSaroniteRock			= mod:NewAnnounce("warnSaroniteRock")
local specWarnSaroniteRock		= mod:NewSpecialWarning("specWarnSaroniteRock")
local specWarnSaroniteRockNear	= mod:NewSpecialWarning("specWarnSaroniteRockNear")
local specWarnPermafrost		= mod:NewSpecialWarning("specWarnPermafrost", false)

mod:AddBoolOption("SetIconOnSaroniteRockTarget", true)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70380, 70384) then						-- Deep Freeze
		warnDeepFreeze:Show(args.destName)
	elseif args:IsSpellID(68785, 70335) then					-- Forge Frostborn Mace
		warnForgeWeapon:Show()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(68786, 70336) and args:IsPlayer() then
		if args.amount >= 11 then --11 stacks is what's needed for achievement I believe.
			specWarnPermafrost:Show(args.spellName, args.amount)
		end
	end
end

function mod:SPELL_CREATE(args)
	if args:IsSpellID(68789, 70851) then						-- Saronite Rock
		warnSaroniteRock:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)
	local target = msg and msg:match(L.SaroniteRockThrow)
	if target then
		self:SendSync("SaroniteRock: "..target)
	end
end

function mod:OnSync(msg, target)
	if target == UnitName("player") then
		specWarnSaroniteRock:Show()
	elseif target then
		local uId = DBM:GetRaidUnitID(target)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnSaroniteRockNear:Show()
			end
		end
	end
	if self.Options.SetIconOnSaroniteRockTarget then
		self:SetIcon(target, 8, 5)
	end
end