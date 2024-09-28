---@class DBMLocaleCommon
local CL = {}

DBM_COMMON_L = CL

--General
CL.NONE								= "None"
CL.RANDOM							= "Random"
CL.UNKNOWN							= "Unknown"--UNKNOWN which is "Unknown" (does u vs U matter?)
CL.NEXT								= "Next %s"
CL.COOLDOWN							= "%s CD"
CL.INCOMING							= "%s Incoming"
CL.INTERMISSION						= "Intermission"--No blizz global for this, and will probably be used in most end tier fights with intermission phases
CL.NO_DEBUFF						= "Not %s"--For use in places like info frame where you put "Not Spellname"
CL.ALLY								= "Ally"--Such as "Move to Ally"
CL.ALLIES							= "Allies"--Such as "Move to Allies"
CL.TANK								= "Tank"--Such as "Move to Tank"
CL.CLEAR							= "Clear"
CL.SAFE								= "Safe"
CL.NOTSAFE							= "Not Safe"
CL.SEASONAL							= "Seasonal"--Used for option headers to label options that apply to seasonal mechanics (Such as season of mastery on classic era)
CL.FULLENERGY						= "Full Energy"
--Movements/Places
CL.UP								= "Up"
CL.DOWN								= "Down"
CL.LEFT								= "Left"
CL.RIGHT							= "Right"
CL.CENTER							= "Center"
CL.BOTH								= "Both"
CL.BEHIND							= "Behind"
CL.BACK								= "Back"--Back as in back of the room, not back as in body part
CL.SIDE								= "Side"--Side as in move to the side
CL.TOP								= "Top"
CL.BOTTOM							= "Bottom"
CL.MIDDLE							= "Middle"
CL.FRONT							= "Front"
CL.EAST								= "East"
CL.WEST								= "West"
CL.NORTH							= "North"
CL.SOUTH							= "South"
CL.NORTHEAST						= "North-East"
CL.SOUTHEAST						= "South-East"
CL.SOUTHWEST						= "South-West"
CL.NORTHWEST						= "North-West"
CL.OUTSIDE							= "Outside"
CL.INSIDE							= "Inside"
CL.SHIELD							= "Shield"--Usually auto localized but kept around in case it needs to be used in a place that's not auto localized such as MoveTo or Use alert
CL.PILLAR							= "Pillar"
CL.SHELTER							= "Shelter"
CL.EDGE								= "Room Edge"
CL.FAR_AWAY							= "Far Away"
CL.PIT								= "Pit"--Pit, as in hole in ground
CL.TOTEM							= "Totem"
CL.TOTEMS							= "Totems"
CL.HORIZONTAL						= "Horizontal"
CL.VERTICAL							= "Vertical"
--Mechanics
CL.BOMB								= "Bomb"--Usually auto localized but kept around in case it needs to be used in a place that's not auto localized such as MoveTo or Use alert
CL.BOMBS							= "Bombs"--Usually auto localized but kept around in case it needs to be used in a place that's not auto localized such as MoveTo or Use alert
CL.ORB								= "Orb"--Usually auto localized but kept around in case it needs to be used in a place that's not auto localized such as MoveTo or Use alert
CL.ORBS								= "Orbs"--Doesn't have a direct auto localize so has to be manually localized, unlike non plural version
CL.RING								= "Ring"
CL.RINGS							= "Rings"
CL.CHEST							= "Chest"--As in Treasure 'Chest'. Not Chest as in body part.
CL.ADD								= "Add"--A fight Add as in "boss spawned extra adds"
CL.ADDS								= "Adds"
CL.ADDCOUNT							= "Add %s"
CL.BIG_ADD							= "Big Add"
CL.BIG_ADDS							= "Big Adds"
CL.BOSS								= "Boss"
CL.ENEMIES							= "Enemies"
CL.BREAK_LOS						= "Break LOS"
CL.RESTORE_LOS						= "Maintain LOS"
CL.BOSSTOGETHER						= "Bosses Together"
CL.BOSSAPART						= "Bosses Apart"
CL.MINDCONTROL						= "Mind Control"
CL.TANKCOMBO						= "Tank Combo"
CL.TANKDEBUFF						= "Tank Debuff"
CL.AOEDAMAGE						= "AOE Damage"
CL.AVOID						    = "Avoid"
CL.GROUPSOAK						= "Soak"
CL.GROUPSOAKS						= "Soaks"
CL.HEALABSORB						= "Heal Absorb"
CL.HEALABSORBS						= "Heal Absorbs"
CL.DODGES							= "Dodges"
CL.POOL								= "Pool"
CL.POOLS							= "Pools"
CL.DEBUFFS							= "Debuffs"
CL.DISPELS							= "Dispels"
CL.PUSHBACK							= "Pushback"
CL.FRONTAL							= "Frontal"
CL.RUNAWAY							= "Run Away"
CL.SPREAD							= "Spread"
CL.SPREADS							= "Spreads"
CL.LASER							= "Laser"
CL.LASERS							= "Lasers"
CL.RIFT								= "Rift"--Often has auto localized alternatives, but still translated for BW aura matching when needed
CL.RIFTS							= "Rifts"--Often has auto localized alternatives, but still translated for BW aura matching when needed
CL.TRAPS							= "Traps"--Doesn't have a direct auto localize so has to be manually localized, unlike non plural version
CL.ROOTS							= "Roots"
CL.MARK								= "Mark"--As in short text for all the encounter mechanics that start or end in "Mark"
CL.MARKS							= "Marks"--Plural of above
CL.CURSE							= "Curse"
CL.CURSES							= "Curses"
CL.SWIRLS							= "Swirls"--Plural of Swirl
CL.CHARGES							= "Charges"--Context, this is plural of boss "charging to players" and NOT bomb charges
CL.CIRCLES							= "Circles"--As in circles on ground that players need to move out of or need to drop off
--NOTE, many common locals are auto localized:
--Bomb (37859), Bombs (167180), Scream (31295), Breath (17088), Beam (173303), Beams (207544), Charge (100), Knockback (28405), Portal (161722), Portals (109400)
--Fixate (12021), Trap (181341), Meteor (28884), Shield (151702), Teleport (4801), Fear (5782), Roar (140459), Leap (47482), Orb (265315), Tornados (86189)
--Pull (193997), Push (359132), Swirl (143413), Web (389280), Webs (157317), Tentacle (285205), Tentacles (61618), Grip (56689), Slam (182557)

--Journal Icons should not be copied to non english locals, do not include this section
local EJIconPath = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1) and "EncounterJournal" or "AddOns\\DBM-Core\\textures"
--Role Icons
CL.TANK_ICON						= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:20:20:0:0:255:66:6:21:7:27|t" -- NO TRANSLATE
CL.DAMAGE_ICON						= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:20:20:0:0:255:66:39:55:7:27|t" -- NO TRANSLATE
CL.HEALER_ICON						= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:20:20:0:0:255:66:70:86:7:27|t" -- NO TRANSLATE

CL.TANK_ICON_SMALL					= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:12:12:0:0:255:66:6:21:7:27|t" -- NO TRANSLATE
CL.DAMAGE_ICON_SMALL				= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:12:12:0:0:255:66:39:55:7:27|t" -- NO TRANSLATE
CL.HEALER_ICON_SMALL				= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:12:12:0:0:255:66:70:86:7:27|t" -- NO TRANSLATE
--Importance Icons
CL.HEROIC_ICON						= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:22:22:0:0:255:66:102:118:7:27|t" -- NO TRANSLATE
CL.DEADLY_ICON						= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:22:22:0:0:255:66:133:153:7:27|t" -- NO TRANSLATE
CL.IMPORTANT_ICON					= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:20:20:0:0:255:66:168:182:7:27|t" -- NO TRANSLATE
CL.MYTHIC_ICON						= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:22:22:0:0:255:66:133:153:40:58|t" -- NO TRANSLATE

CL.HEROIC_ICON_SMALL				= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:14:14:0:0:255:66:102:118:7:27|t" -- NO TRANSLATE
CL.DEADLY_ICON_SMALL				= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:14:14:0:0:255:66:133:153:7:27|t" -- NO TRANSLATE
CL.IMPORTANT_ICON_SMALL				= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:12:12:0:0:255:66:168:182:7:27|t" -- NO TRANSLATE
--Type Icons
CL.INTERRUPT_ICON					= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:20:20:0:0:255:66:198:214:7:27|t" -- NO TRANSLATE
CL.MAGIC_ICON						= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:20:20:0:0:255:66:229:247:7:27|t" -- NO TRANSLATE
CL.CURSE_ICON						= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:20:20:0:0:255:66:6:21:40:58|t" -- NO TRANSLATE
CL.POISON_ICON						= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:20:20:0:0:255:66:39:55:40:58|t" -- NO TRANSLATE
CL.DISEASE_ICON						= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:20:20:0:0:255:66:70:86:40:58|t" -- NO TRANSLATE
CL.ENRAGE_ICON						= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:20:20:0:0:255:66:102:118:40:58|t" -- NO TRANSLATE
CL.BLEED_ICON						= "|TInterface\\" .. EJIconPath .. "\\UI-EJ-Icons.blp:20:20:0:0:255:66:168:182:40:58|t" -- NO TRANSLATE

CL.STAR_ICON						= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:20:20:0:0:64:64:0:16:0:16|t" -- NO TRANSLATE
CL.CIRCLE_ICON						= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:20:20:0:0:64:64:16:32:0:16|t" -- NO TRANSLATE
CL.DIAMOND_ICON						= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:20:20:0:0:64:64:32:48:0:16|t" -- NO TRANSLATE
CL.TRIANGLE_ICON					= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:20:20:0:0:64:64:48:64:0:16|t" -- NO TRANSLATE
CL.MOON_ICON						= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:20:20:0:0:64:64:0:16:16:32|t" -- NO TRANSLATE
CL.SQUARE_ICON						= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:20:20:0:0:64:64:16:32:16:32|t" -- NO TRANSLATE
CL.CROSS_ICON						= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:20:20:0:0:64:64:32:48:16:32|t" -- NO TRANSLATE
CL.SKULL_ICON						= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:20:20:0:0:64:64:48:64:16:32|t" -- NO TRANSLATE

CL.STAR_ICON_SMALL					= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t" -- NO TRANSLATE
CL.CIRCLE_ICON_SMALL				= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t" -- NO TRANSLATE
CL.DIAMOND_ICON_SMALL				= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t" -- NO TRANSLATE
CL.TRIANGLE_ICON_SMALL				= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t" -- NO TRANSLATE
CL.MOON_ICON_SMALL					= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t" -- NO TRANSLATE
CL.SQUARE_ICON_SMALL				= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t" -- NO TRANSLATE
CL.CROSS_ICON_SMALL					= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t" -- NO TRANSLATE
CL.SKULL_ICON_SMALL					= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t" -- NO TRANSLATE

-- Colors
CL.BLACK	= "Black"
CL.BLUE		= "Blue"
CL.GREEN	= "Green"
CL.RED		= "Red"
CL.BRONZE	= "Bronze"
