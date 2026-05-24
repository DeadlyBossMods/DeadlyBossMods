---@class DBMLocaleCommon
local CL = {}

DBM_COMMON_L = CL

--General
CL.ALLIES							= "Allies"--Such as "Move to Allies"
CL.ALLY								= "Ally"--Such as "Move to Ally"
CL.ALPHABETICAL                     = "Alphabetical"
CL.CLEAR							= "Clear"
CL.COOLDOWN							= "%s CD"
CL.DURATION                         = "Duration"
CL.FULLENERGY						= "Full Energy"
CL.INCOMING							= "%s Incoming"
CL.INTERMISSION						= "Intermission"--No blizz global for this, and will probably be used in most end tier fights with intermission phases
CL.NEXT								= "Next %s"
CL.NONE								= "None"
CL.NO_DEBUFF						= "Not %s"--For use in places like info frame where you put "Not Spellname"
CL.NOTSAFE							= "Not Safe"
CL.RANDOM							= "Random"
CL.SAFE								= "Safe"
CL.SEASONAL							= "Seasonal"--Used for option headers to label options that apply to seasonal mechanics (Such as season of mastery on classic era)
CL.SORTING                          = "Sorting"
CL.TANK								= "Tank"--Such as "Move to Tank"
CL.UNKNOWN							= "Unknown"--UNKNOWN which is "Unknown" (does u vs U matter?)
--Movements/Places
CL.BACK								= "Back"--Back as in back of the room, not back as in body part
CL.BEHIND							= "Behind"
CL.BOTH								= "Both"
CL.BOTTOM							= "Bottom"
CL.CENTER							= "Center"
CL.DOWN								= "Down"
CL.EAST								= "East"
CL.EDGE								= "Room Edge"
CL.FAR_AWAY							= "Far Away"
CL.FRONT							= "Front"
CL.HORIZONTAL						= "Horizontal"
CL.INSIDE							= "Inside"
CL.LEFT								= "Left"
CL.MIDDLE							= "Middle"
CL.NORTH							= "North"
CL.NORTHEAST						= "North-East"
CL.NORTHWEST						= "North-West"
CL.OUTSIDE							= "Outside"
CL.PILLAR							= "Pillar"
CL.PIT								= "Pit"--Pit, as in hole in ground
CL.RIGHT							= "Right"
CL.SHIELD							= "Shield"--Usually auto localized but kept around in case it needs to be used in a place that's not auto localized such as MoveTo or Use alert
CL.SHELTER							= "Shelter"
CL.SIDE								= "Side"--Side as in move to the side
CL.SOUTH							= "South"
CL.SOUTHEAST						= "South-East"
CL.SOUTHWEST						= "South-West"
CL.TOP								= "Top"
CL.TOTEM							= "Totem"
CL.TOTEMS							= "Totems"
CL.UP								= "Up"
CL.VERTICAL							= "Vertical"
CL.WEST								= "West"
--Mechanics
CL.ADD								= "Add"--A fight Add as in "boss spawned extra adds"
CL.ADDS								= "Adds"
CL.ADDCOUNT							= "Add %s"
CL.AOEDAMAGE						= "AOE Damage"
CL.AVOID						    = "Avoid"
CL.BALLS							= "Balls"
CL.BIG_ADD							= "Big Add"
CL.BIG_ADDS							= "Big Adds"
CL.BOMB								= "Bomb"--Usually auto localized but kept around in case it needs to be used in a place that's not auto localized such as MoveTo or Use alert
CL.BOMBS							= "Bombs"--Usually auto localized but kept around in case it needs to be used in a place that's not auto localized such as MoveTo or Use alert
CL.BOSS								= "Boss"
CL.BOSSAPART						= "Bosses Apart"
CL.BOSSTOGETHER						= "Bosses Together"
CL.BREAK_LOS						= "Break LOS"
CL.CHARGES							= "Charges"--Context, this is plural of boss "charging to players" and NOT bomb charges
CL.CHEST							= "Chest"--As in Treasure 'Chest'. Not Chest as in body part.
CL.CIRCLES							= "Circles"--As in circles on ground that players need to move out of or need to drop off
CL.CURSE							= "Curse"
CL.CURSES							= "Curses"
CL.DEBUFF							= "Debuff"
CL.DEBUFFS							= "Debuffs"
CL.DISPELS							= "Dispels"
CL.DODGES							= "Dodges"
CL.ENEMIES							= "Enemies"
CL.FRONTAL							= "Frontal"
CL.GROUPSOAK						= "Soak"
CL.GROUPSOAKS						= "Soaks"
CL.HEALABSORB						= "Heal Absorb"
CL.HEALABSORBS						= "Heal Absorbs"
CL.INTERRUPT						= "Interrupt"
CL.INTERRUPTS						= "Interrupts"
CL.KNOCKUP							= "Knock up"
CL.LASER							= "Laser"
CL.LASERS							= "Lasers"
CL.LINE								= "Line"
CL.LINES							= "Lines"
CL.MARK								= "Mark"--As in short text for all the encounter mechanics that start or end in "Mark"
CL.MARKS							= "Marks"--Plural of above
CL.MINDCONTROL						= "Mind Control"
CL.NEGATIVE							= "Negative"
CL.ORB								= "Orb"--Usually auto localized but kept around in case it needs to be used in a place that's not auto localized such as MoveTo or Use alert
CL.ORBS								= "Orbs"--Doesn't have a direct auto localize so has to be manually localized, unlike non plural version
CL.PLAYERSWAPS						= "Player Swaps"
CL.POOL								= "Pool"
CL.POOLS							= "Pools"
CL.POSITIVE							= "Positive"
CL.PUSHBACK							= "Pushback"
CL.RESTORE_LOS						= "Maintain LOS"
CL.RIFT								= "Rift"--Often has auto localized alternatives, but still translated for BW aura matching when needed
CL.RIFTS							= "Rifts"--Often has auto localized alternatives, but still translated for BW aura matching when needed
CL.RING								= "Ring"
CL.RINGS							= "Rings"
CL.ROOTS							= "Roots"
CL.RUNAWAY							= "Run Away"
CL.SPREAD							= "Spread"
CL.SPREADDEBUFF						= "Spread Debuff"
CL.SPREADDEBUFFS					= "Spread Debuffs"
CL.SPREADS							= "Spreads"
CL.SWIRLS							= "Swirls"--Plural of Swirl
CL.TANKBUSTER						= "Tank Buster"
CL.TANKCOMBO						= "Tank Combo"
CL.TANKDEBUFF						= "Tank Debuff"
CL.TRAPS							= "Traps"--Doesn't have a direct auto localize so has to be manually localized, unlike non plural version
--NOTE, many common locals are auto localized:
--Bomb (37859), Bombs (167180), Scream (31295), Breath (17088), Beam (173303), Beams (207544), Charge (100), Knockback (28405), Portal (161722), Portals (109400)
--Fixate (12021), Trap (181341), Meteor (28884), Shield (151702), Teleport (4801), Fear (5782), Roar (140459), Leap (47482), Orb (265315), Tornados (86189)
--Pull (193997), Pull in (395745), Push (359132), Swirl (143413), Web (389280), Webs (157317), Tentacle (285205), Tentacles (61618), Grip (56689), Slam (182557), Stomp (247733)

--Journal Icons should not be copied to non english locals, do not include this section
local EJIconPath = "AddOns\\DBM-Core\\textures"
--Role Icons
CL.TANK_ICON						= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:20:20:0:0:512:256:265:297:103:135|t" -- NO TRANSLATE
CL.DAMAGE_ICON						= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:20:20:0:0:512:256:133:165:199:231|t" -- NO TRANSLATE
CL.HEALER_ICON						= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:20:20:0:0:512:256:333:365:1:33|t" -- NO TRANSLATE

CL.TANK_ICON_SMALL					= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:12:12:0:0:512:256:265:297:103:135|t" -- NO TRANSLATE
CL.DAMAGE_ICON_SMALL				= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:12:12:0:0:512:256:133:165:199:231|t" -- NO TRANSLATE
CL.HEALER_ICON_SMALL				= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:12:12:0:0:512:256:333:365:1:33|t" -- NO TRANSLATE
--Importance Icons
CL.HEROIC_ICON						= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:22:22:0:0:512:256:367:399:1:33|t" -- NO TRANSLATE
CL.DEADLY_ICON						= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:22:22:0:0:512:256:199:231:199:231|t" -- NO TRANSLATE
CL.IMPORTANT_ICON					= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:20:20:0:0:512:256:401:433:1:33|t" -- NO TRANSLATE
CL.MYTHIC_ICON						= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:22:22:0:0:512:256:265:297:35:67|t" -- NO TRANSLATE

CL.HEROIC_ICON_SMALL				= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:14:14:0:0:512:256:367:399:1:33|t" -- NO TRANSLATE
CL.DEADLY_ICON_SMALL				= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:14:14:0:0:512:256:199:231:199:231|t" -- NO TRANSLATE
CL.IMPORTANT_ICON_SMALL				= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:12:12:0:0:512:256:401:433:1:33|t" -- NO TRANSLATE
--Type Icons
CL.INTERRUPT_ICON					= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:20:20:0:0:512:256:435:467:1:33|t" -- NO TRANSLATE
CL.MAGIC_ICON						= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:20:20:0:0:512:256:469:501:1:33|t" -- NO TRANSLATE
CL.CURSE_ICON						= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:20:20:0:0:512:256:67:99:199:231|t" -- NO TRANSLATE
CL.POISON_ICON						= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:20:20:0:0:512:256:265:297:69:101|t" -- NO TRANSLATE
CL.DISEASE_ICON						= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:20:20:0:0:512:256:265:297:1:33|t" -- NO TRANSLATE
CL.ENRAGE_ICON						= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:20:20:0:0:512:256:299:331:1:33|t" -- NO TRANSLATE
CL.BLEED_ICON						= "|TInterface\\" .. EJIconPath .. "\\uicombattimelinewarningicons.blp:20:20:0:0:512:256:1:33:199:231|t" -- NO TRANSLATE

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

-- Conjunctions, used to join words, e.g., "Spell1 *and* Spell2 on you!"
CL.AND		= "and"
CL.OR		= "or"
