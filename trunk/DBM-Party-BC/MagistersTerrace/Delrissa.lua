local mod = DBM:NewMod("Delrissa", "DBM-Party-BC", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(24560, 24557, 24558, 24554, 24561, 24559, 24555, 24553, 24556)
mod:RegisterCombat("combat")
--mod:RegisterCombat("yell", L.DelrissaPull)--May need this, need to test first
--mod:RegisterKill("yell", L.DelrissaEnd)--May need this, need to test first.

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local warnFlashHeal		= mod:NewSpellAnnounce(17843)
local warnLHW           = mod:NewSpellAnnounce(46181)
local warnWindFury		= mod:NewSpellAnnounce(27621)
local warnBlizzard		= mod:NewSpellAnnounce(46195)
local warnRenew         = mod:NewSpellAnnounce(46192)
local warnSoC           = mod:NewTargetAnnounce(44141)
local warnPolymorph     = mod:NewTargetAnnounce(13323)
local warnPWShield      = mod:NewTargetAnnounce(44175)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(17843) then                                                      -- Delrissa's Flash Heal
		warnFlashHeal:Show()
	elseif args:IsSpellID(46181, 44256) then                                           -- Apoko's LHW
		warnLHW:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(27621) then                                                      -- Apoko's Windfury Totem
		warnWindFury:Show()
	elseif args:IsSpellID(44178, 46195) then                                           -- Yazzai's Blizzard
		warnBlizzard:Show()
	elseif args:IsSpellID(44174, 46192) and not args:IsDestTypePlayer() then           -- Delrissa's Renew
		warnRenew:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(13323) then                                                      -- Yazzai's Polymorph
		warnPolymorph:Show(args.destName)
	elseif args:IsSpellID(44141) then                                                  -- Ellrys SoC
		warnSoC:Show(args.destName)
	elseif args:IsSpellID(44175, 44291, 46193) and not args:IsDestTypePlayer() then    -- Delrissa's PWShield
		warnPWShield:Show(args.destName)
	end
end