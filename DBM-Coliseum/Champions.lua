local mod	= DBM:NewMod("Champions", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(34458, 34451, 34459, 34448, 34449, 34445, 34456, 34447, 34441, 34454, 34444, 34455, 34450, 34453, 34461)
-- 34460, 34469, 34467, 34468, 34471, 34465, 34466, 34473, 34472, 34470, 34463, 34474, 34475

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_AURA_APPLIED"
)


if UnitFactionGroup("player") == "Alliance" then
	mod:SetBossHealthInfo(
	-- Horde
		34458, L.Gorgrim,
		34451, L.Birana,
		34459, L.Erin,
		34448, L.Rujkah,
		34449, L.Ginselle,
		34445, L.Liandra,
		34456, L.Malithas,
		34447, L.Caiphus,
		34441, L.Vivienne,
		34454, L.Mazdinah,
		34444, L.Thrakgar,
		34455, L.Broln,
		34450, L.Harkzog,
		34453, L.Narrhok
	)
else
	mod:SetBossHealthInfo(
	-- Alliance
		34461, L.Tyrius,
		34460, L.Kavina,
		34469, L.Melador,
		34467, L.Alyssia,
		34468, L.Noozle,
		34471, L.Baelnor,
		34465, L.Velanaa,
		34466, L.Anthar,
		34473, L.Brienna,
		34472, L.Irieth,
		34470, L.Saamul,
		34463, L.Shaabad,
		34474, L.Serissa,
		34475, L.Shocuul
	)
end

local isDispeller = select(2, UnitClass("player")) == "WARRIOR"
              or select(2, UnitClass("player")) == "PRIEST"
              or select(2, UnitClass("player")) == "SHAMAN"

local warnHellfire			= mod:NewSpellAnnounce(68147, 1)
local warnBladestorm		= mod:NewSpellAnnounce(65947, 1)
local specWarnHellfire		= mod:NewSpecialWarning("SpecWarnHellfire")
local warnHeroism			= mod:NewSpellAnnounce(65983, 2)
local warnBloodlust			= mod:NewSpellAnnounce(65980, 2)
local warnHandofProt		= mod:NewSpellAnnounce(66009, 2)
local warnDivineShield		= mod:NewSpellAnnounce(66010, 2)
local warnIceBlock  		= mod:NewSpellAnnounce(65802, 2)
local warnShadowstep		= mod:NewSpellAnnounce(66178, 2)
local warnDeathgrip  		= mod:NewTargetAnnounce(66017, 2)
local warnCyclone           = mod:NewTargetAnnounce(65859, false)
local warnSheep             = mod:NewTargetAnnounce(65801, false)

local timerBladestorm		= mod:NewBuffActiveTimer(8, 65947)
local timerShadowstep		= mod:NewCDTimer(30, 66178)
local timerDeathgrip  		= mod:NewCDTimer(35, 66017)


local specWarnHandofProt	= mod:NewSpecialWarning("SpecWarnHandofProt", isDispeller)
local specWarnDivineShield	= mod:NewSpecialWarning("SpecWarnDivineShield", isDispeller) 
local specWarnIceBlock  	= mod:NewSpecialWarning("specWarnIceBlock", isDispeller) 


function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(65816, 68145, 68146, 68147) then		-- Warlock Hellfire
		warnHellfire:Show()
	elseif args:IsSpellID(65947) then						-- Warrior Bladestorm
		warnBladestorm:Show()
		timerBladestorm:Start()
	elseif args:IsSpellID(65983) then						-- Shamen Heroism
		warnHeroism:Show()
	elseif args:IsSpellID(65980) then						-- Shamen Blood lust
		warnBloodlust:Show()
	elseif args:IsSpellID(66009) then						-- Paladin Hand of Protection on <mobname>
		warnHandofProt:Show(args.destName)
		specWarnHandofProt:Show(args.destName)
	elseif args:IsSpellID(66178, 68759, 68760, 68761) then	-- Rogue Shadowstep
		warnShadowstep:Show()
        if mod:IsDifficulty("heroic25") then                -- 3 out of 4 difficulties have 30 second cooldown, but on 25 heroic, it's 20sec
            timerShadowstep:Start(20)
        else
            timerShadowstep:Start()
        end
	elseif args:IsSpellID(66017, 68753, 68754, 68755) then	-- DeathKnight DeathGrip
		warnDeathgrip:Show(args.destName)
        if mod:IsDifficulty("heroic25") then                -- 3 out of 4 difficulties have 35 second cooldown, but on 25 heroic, it's 20sec
            timerDeathgrip:Start(20)
        else
            timerDeathgrip:Start()
        end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(66010) then                                      -- Divine Shield on <mobname>
		warnDivineShield:Show(args.destName)
		specWarnDivineShield:Show(args.destName)
	elseif args:IsSpellID(65802) then                                  -- Iceblock on <mobname>
		warnIceBlock:Show(args.destName)
		specWarnIceBlock:Show(args.destName)
	elseif args:IsSpellID(65859) and args:IsDestTypePlayer() then      -- Cyclone on <playername>
		warnCyclone:Show(args.destName)
	elseif args:IsSpellID(65801) and args:IsDestTypePlayer() then      -- Sheep on <playername>
		warnSheep:Show(args.destName)
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsPlayer() and args:IsSpellID(65817, 68142, 68143, 68144) then
		specWarnHellfire:Show()
	end
end

