local mod = DBM:NewMod("IronCouncil", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:SetZone()

--mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START"
)

mod:AddBoolOption("HealthFrame", true)

mod:SetBossHealthInfo(
	0, L.Steelbreaker,
	0, L.RunemasterMolgeim,
	0, L.StormcallerBrundir
)

local timerSupercharge	= mod:NewTimer(10, "TimerSupercharge", 61920)

local warnSupercharge	= mod:NewAnnounce("WarningSupercharge", 1, 61920)

local enrageTimer	= mod:NewEnrageTimer(600) -- don't realy know


--[[
Fight (List of abilities taken from the StratsFu Strategy Guide)
Each time you kill a member of the council, he will cast Supercharge and the remaining monsters will gain extra abilities and gain 25% damage.

    * http://thottbot.com/test/s61920 Supercharge - Unleashes one last burst of energy as the caster dies, increasing all allies damage by 25% and granting them an additional ability.


Steelbreaker - 10M HP (Heroic) / 3M HP (Normal)

    * http://thottbot.com/test/s63493 Fusion Punch - An attack infused with energy that inflicts 100% weapon damage and an additional 8000 Nature damage per second. - He casts Fusion Punch on a ten second cooldown (but we saw it as late as 25 seconds.) If he is in a Rune of Power he will hit far harder, so it's vitally important that he's never standing in them.
    * http://thottbot.com/test/s63498 High Voltage - This is an aura that inflicts 2500 Nature damage every 3 sec. When he dies the aura disappears.
    * http://thottbot.com/test/s63494 Static Disruption (1 Mob Down) - Deals 7500 Nature damage to enemies in an area and increases Nature damage taken by 50% for 20 sec. (12 Yards radius)


Runemaster Molgeim - 10M HP (Heroic) / 3M HP (Normal)

    * http://thottbot.com/test/s61974 Rune of Power - Runemaster Molgeim casts Rune of Power on a target NPC periodically -- there's a few seconds with no rune and then another appears. It will buff anyone standing in it, including a mob.
    * http://thottbot.com/test/s63490 Rune of Death (1 Mob Down) - Summons a Rune of Death at a random enemy target's location. This rune deals 3000 Shadow damage every half-second to anyone within 13 yards of that location. - This will be casted on a target player and inflict anyone within 13 yards of this player.
    * http://thottbot.com/test/s62273 Rune of Summoning (2 Mob Down) - Runemaster Moldeim gains Rune of Summoning which summons Lightning Elementals. These chase after players and appear to explode and deal damage. Their melee attack is Lightning Blast: deals 14-15.8k nature damage to everyone within 30 yards and kills the elemental in the process. 


Stormcaller Brundir - 10M HP (Heroic) / 3M HP (Normal)

    * http://thottbot.com/test/s63479 Chain Lightning - Strikes an enemy with a lightning bolt that arcs to another nearby enemy. The spell affects up to 5 targets, causing Nature damage to each. - Stormcaller Brundir casts Chain Lightning which chains through the raid. It can be interrupted, and he can have his cast time slowed (e.g. with Curse of Tongues.)
    * http://thottbot.com/test/s63481 Overload - He emotes "PEASANT HAS CROSSED THE LINE" as he cast this spell (10 seconds cast time): it's vitally important that everyone gets out of range (it deals 25000 nature damage to everyone within 30 yards.)
    * http://thottbot.com/test/s63483 Lightning Whirl - Spins around throwing off bolts of lightning at random enemy targets. Each bolt deals 6598 to 7402 Nature damage. Lasts 5 sec. - Stormcaller Brundir gains Lightning Whirl, which does AE lightning bolts. It's interruptable.
    * http://thottbot.com/test/s63485 Lightning Tendrils (Screenshot) - Tendrils of lightning shoot out of the caster's chest, lifting them into the air. These lightning tendrils deal 4000 Nature damage to all enemies around the caster every second. - Stormcaller Brundir gains Lightning Tendrils, where he launches into the area and chases after players, AE'ing everyone in his path.

--]]

local phase = 1
function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	phase = 1
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 61920 then -- Supercharge - Unleashes one last burst of energy as the caster dies, increasing all allies damage by 25% and granting them an additional ability.	
		phase = phase + 1
		timerSupercharge:Start()
		warnSupercharge:Show()
	end
end




