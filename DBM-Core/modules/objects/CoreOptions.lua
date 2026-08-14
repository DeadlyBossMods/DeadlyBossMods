---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L
local CL = DBM_COMMON_L

---@class DBM
local DBM = private:GetPrototype("DBM")

-- dual profile setup
local _, playerClass = UnitClass("player")
if DBM_UseDualProfile == nil then
	DBM_UseDualProfile = true
	if playerClass == "MAGE" or playerClass == "WARLOCK" or playerClass == "ROGUE" or (not private.isRetail and playerClass == "HUNTER") then
		DBM_UseDualProfile = false
	end
end
if DBM_CharSavedRevision == nil then DBM_CharSavedRevision = 2 end
local locale = GetLocale()
local countdownVoiceRenames = {
	["Jérémy"] = "Jeremy",
	["Élise"] = "Elise",
	["도현원"] = "Dohyunwon",
	["하민지"] = "Haminji",
	["Александр"] = "Alexander",
	["Надежда"] = "Nadezhda",
	["瑞辰"] = "Ruichen",
	["纯如"] = "Chunru",
	["浩"] = "Hao",
	["玲"] = "Ling"
}

local function MigrateCountVoiceOption(options, optionName)
	local currentValue = options[optionName]
	if type(currentValue) == "string" and countdownVoiceRenames[currentValue] then
		options[optionName] = countdownVoiceRenames[currentValue]
	end
end

local function HasLegacyCountVoiceOption(options)
	return (type(options.CountdownVoice) == "string" and countdownVoiceRenames[options.CountdownVoice]) or
		(type(options.CountdownVoice2) == "string" and countdownVoiceRenames[options.CountdownVoice2]) or
		(type(options.CountdownVoice3) == "string" and countdownVoiceRenames[options.CountdownVoice3]) or
		(type(options.PullVoice) == "string" and countdownVoiceRenames[options.PullVoice])
end

DBM.DefaultOptions = {
	WarningColors = {
		{r = 0.41, g = 0.80, b = 0.94}, -- Color 1 - #69CCF0 - Turquoise
		{r = 0.95, g = 0.95, b = 0.00}, -- Color 2 - #F2F200 - Yellow
		{r = 1.00, g = 0.50, b = 0.00}, -- Color 3 - #FF8000 - Orange
		{r = 1.00, g = 0.10, b = 0.10}, -- Color 4 - #FF1A1A - Red
	},
	RaidWarningSound = 566558,--"Sound\\Doodad\\BellTollNightElf.ogg"
	SpecialWarningSound = 569200,--"Sound\\Spells\\PVPFlagTaken.ogg"
	SpecialWarningSound2 = private.isRetail and 543587 or "Interface\\AddOns\\DBM-Core\\sounds\\ClassicSupport\\UR_Algalon_BHole01.ogg",--"Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.ogg"
	SpecialWarningSound3 = "Interface\\AddOns\\DBM-Core\\sounds\\AirHorn.ogg",
	SpecialWarningSound4 = not private.isClassic and 552035 or "Interface\\AddOns\\DBM-Core\\sounds\\ClassicSupport\\HoodWolfTransformPlayer01.ogg",--"Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg"
	SpecialWarningSound5 = 554236,--"Sound\\Creature\\Loathstare\\Loa_Naxx_Aggro02.ogg"
	ModelSoundValue = "Short",
	CountdownVoice = ((locale == "enUS" or locale == "enGB") and "Corsica") or
					(locale == "deDE" and "Karl") or
					(locale == "esES" and "Mateo") or
					(locale == "esMX" and "Juan") or
					(locale == "frFR" and "Jeremy") or
					(locale == "koKR" and "Dohyunwon") or
					(locale == "ptBR" and "Anshlun") or
					(locale == "ruRU" and "Alexander") or
					(locale == "zhCN" and "Ruichen") or
					(locale == "zhTW" and "Hao"),
	CountdownVoice2 = ((locale == "enUS" or locale == "enGB") and "Kolt") or
					(locale == "deDE" and "Franziska") or
					(locale == "esES" and "Fernanda") or
					(locale == "esMX" and "Isabel") or
					(locale == "frFR" and "Elise") or
					(locale == "koKR" and "Haminji") or
					(locale == "ptBR" and "Neryssa") or
					(locale == "ruRU" and "Nadezhda") or
					(locale == "zhCN" and "Chunru") or
					(locale == "zhTW" and "Ling"),
	CountdownVoice3 = ((locale == "enUS" or locale == "enGB") and "Smooth") or
					(locale == "deDE" and "Franziska") or
					(locale == "esES" and "Fernanda") or
					(locale == "esMX" and "Isabel") or
					(locale == "frFR" and "Elise") or
					(locale == "koKR" and "Haminji") or
					(locale == "ptBR" and "Neryssa") or
					(locale == "ruRU" and "Nadezhda") or
					(locale == "zhCN" and "Chunru") or
					(locale == "zhTW" and "Ling"),
	CountSize = 5,
	PullVoice = ((locale == "enUS" or locale == "enGB") and "Corsica") or
					(locale == "deDE" and "Karl") or
					(locale == "esES" and "Mateo") or
					(locale == "esMX" and "Juan") or
					(locale == "frFR" and "Jeremy") or
					(locale == "koKR" and "Dohyunwon") or
					(locale == "ptBR" and "Anshlun") or
					(locale == "ruRU" and "Alexander") or
					(locale == "zhCN" and "Ruichen") or
					(locale == "zhTW" and "Hao"),
	CountdownVoiceNamesMigrated = false,
	ChosenVoicePack2 = (locale == "enUS" or locale == "enGB") and "VEM" or "None",
	VPReplacesAnnounce = true,
	VPReplacesSADefault = true,
	EventSoundVictory2 = "Interface\\AddOns\\DBM-Core\\sounds\\Victory\\SmoothMcGroove_Fanfare.ogg",
	EventSoundWipe = "None",
	EventSoundPullTimer = "None",
	EventSoundEngage2 = "None",
	EventSoundMusic = "None",
	EventSoundDungeonBGM = "None",
	EventSoundMusicCombined = false,
	EventMusicNoBuiltIn = false,
	EventDungMusicMythicFilter = true,
	EventMusicMythicFilter = true,
	Enabled = true,
	ShowWarningsInChat = true,
	ShowSWarningsInChat = true,
	WarningIconLeft = true,
	WarningIconRight = true,
	WarningIconChat = true,
	WarningAlphabetical = true,
	WarningShortText = true,
	StripServerName = true,
	ShowAllVersions = true,
	ShowReminders = true,
	ShowPizzaMessage = true,
	ShowEngageMessage = true,
	ShowDefeatMessage = true,
	ShowGuildMessages = true,
	ShowGuildMessagesPlus = false,
	AutoRespond = true,
	EnableWBSharing = true,
	WhisperStats = false,
	DisableStatusWhisper = false,
	DisableGuildStatus = false,
	DisableRaidIcons = false,
	DisableChatBubbles = false,
	OverrideBossAnnounce = false,
	OverrideBossTimer = false,
	OverrideBossIcon = false,
	OverrideBossSay = false,
	NoAnnounceOverride = true,
	NoTimerOverridee = true,
	ReplaceMyConfigOnOverride = false,
	HideBossEmoteFrame2 = true,
	HideBlizzardTimeline = true,
	HideDBMBars = false,
	HideDBMWarnings = false,
	SWarningAlphabetical = true,
	SWarnNameInNote = true,
	CustomSounds = 0,
	FilterBTargetFocus = true,
	FilterBInterruptCooldown = true,
	FilterBInterruptHealer = false,
	FilterInterruptNoteName = false,
	FilterTTargetFocus = true,
	FilterTInterruptCooldown = true,
	FilterTInterruptHealer = false,
	FilterDispel = true,
	FilterCrowdControl = true,
	FilterTrashWarnings2 = true,
	FilterVoidFormSay2 = false,
	AutologBosses = false,
	AdvancedAutologBosses = false,
	RecordOnlyBosses = false,
	DoNotLogLFG = true,
	LogCurrentMythicRaids = true,
	LogCurrentRaids = true,
	LogCurrentMPlus = true,
	LogCurrentMythicZero = false,
	LogCurrentHeroic = false,
	LogTrivialRaids = false,
	LogTWRaids = false,
	LogTrivialDungeons = false,
	LogTWDungeons = false,
	LogDelves = false,
	LogChallenges = false,
	UseSoundChannel = "Master",
	LFDEnhance = true,
	WorldBossNearAlert = false,
	RLReadyCheckSound = true,
	AFKHealthWarning2 = private.isHardcoreServer and true or false,
	HealthWarningLow = private.isHardcoreServer and true or false,
	EnteringCombatAlert = false,
	LeavingCombatAlert = false,
	RaidDifficultyChangedAlert = true,
	RaidDifficultyChangedAlertRaidOnly = true,
	DungeonDifficultyChangedAlert = false,
	AutoReplySound = true,
	HideObjectivesFrame = true,
	HideGarrisonToasts = true,
	HideGuildChallengeUpdates = true,
	DisableSFX = false,
	DisableAmbiance = false,
	DisableMusic = false,
	EnableModels = true,
	GUIWidth = 1000,
	GUIHeight = 700,
	GUIResizeMigrated_1000x700 = false,
	GroupOptionsExcludeIcon = false,
--	GroupOptionsExcludePA = false,
	AutoExpandSpellGroups2 = true,
	ShowWAKeys = true,
	--ShowSpellDescWhenExpanded = false,
	RangeFrameFrames = "radar",
	RangeFrameUpdates = "Average",
	RangeFramePoint = "CENTER",
	RangeFrameX = 50,
	RangeFrameY = -50,
	RangeFrameSound1 = "none",
	RangeFrameSound2 = "none",
	RangeFrameLocked = false,
	RangeFrameRadarPoint = "CENTER",
	RangeFrameRadarX = 100,
	RangeFrameRadarY = -100,
	InfoFramePoint = "CENTER",
	InfoFrameX = 75,
	InfoFrameY = -75,
	InfoFrameShowSelf = false,
	InfoFrameLines = 0,
	InfoFrameCols = 0,
	InfoFrameStrata = "DIALOG",
	InfoFrameFont = "standardFont",
	InfoFrameFontSize = 12,
	InfoFrameFontStyle = "None",
	WarningDuration2 = 1.5,
	WarningPoint = "CENTER",
	WarningX = 0,
	WarningY = 260,
	WarningFont = "standardFont",
	WarningFontSize = 20,
	WarningFontStyle = "None",
	WarningFontShadow = true,
	SpecialWarningDuration2 = 1.5,
	SpecialWarningPoint = "CENTER",
	SpecialWarningX = 0,
	SpecialWarningY = 75,
	SpecialWarningFont = "standardFont",
	SpecialWarningFontSize2 = 35,
	SpecialWarningFontStyle = "THICKOUTLINE",
	SpecialWarningFontShadow = false,
	SpecialWarningIcon = true,
	SpecialWarningShortText = true,
	SpecialWarningFontCol = {1.0, 0.7, 0.0},--Yellow, with a tint of orange
	SpecialWarningFlashCol1 = {1.0, 1.0, 0.0},--Yellow
	SpecialWarningFlashCol2 = {1.0, 0.5, 0.0},--Orange
	SpecialWarningFlashCol3 = {1.0, 0.0, 0.0},--Red
	SpecialWarningFlashCol4 = {1.0, 0.0, 1.0},--Purple
	SpecialWarningFlashCol5 = {0.2, 1.0, 1.0},--Tealish
	SpecialWarningFlashDura1 = 0.3,
	SpecialWarningFlashDura2 = 0.4,
	SpecialWarningFlashDura3 = 1,
	SpecialWarningFlashDura4 = 0.7,
	SpecialWarningFlashDura5 = 1,
	SpecialWarningFlashAlph1 = 0.3,
	SpecialWarningFlashAlph2 = 0.3,
	SpecialWarningFlashAlph3 = 0.4,
	SpecialWarningFlashAlph4 = 0.4,
	SpecialWarningFlashAlph5 = 0.5,
	SpecialWarningFlash1 = true,
	SpecialWarningFlash2 = true,
	SpecialWarningFlash3 = true,
	SpecialWarningFlash4 = true,
	SpecialWarningFlash5 = true,
	SpecialWarningFlashCount1 = 1,
	SpecialWarningFlashCount2 = 1,
	SpecialWarningFlashCount3 = 3,
	SpecialWarningFlashCount4 = 2,
	SpecialWarningFlashCount5 = 3,
	SpecialWarningVibrate1 = false,
	SpecialWarningVibrate2 = false,
	SpecialWarningVibrate3 = true,
	SpecialWarningVibrate4 = true,
	SpecialWarningVibrate5 = true,
	SWarnClassColor = true,
	ArrowPosX = 0,
	ArrowPosY = -150,
	ArrowPoint = "TOP",
	GearPosition = {"RIGHT", -150, 0},
	DurabilityPosition = {"RIGHT", -150, 0},
	LatencyPosition = {"RIGHT", -150, 0},
	KeystonesPosition = {"LEFT", 30, 0},
	-- global boss mod settings (overrides mod-specific settings for some options)
	DontShowBossAnnounces = false,
	DontShowTargetAnnouncements = true,
	DontShowSpecialWarningText = false,
	DontShowSpecialWarningFlash = false,
	DontDoSpecialWarningVibrate = false,
	DontPlaySpecialWarningSound = false,
	DontPlayPrivateAuraSound = false,
	DontShowPrivateAuraFrame = false,
	DontPlayTrivialSpecialWarningSound = true,
	DontShowBossTimers = false,
	DontShowTrashTimers = false,
	DontShowEventTimers = false,
	DontShowUserTimers = false,
	DontShowFarWarnings = true,
	DontSetIcons = false,
	DontRestoreIcons = false,
	DontShowRangeFrame = false,
	DontRestoreRange = false,
	DontShowInfoFrame = false,
	DontShowHudMap2 = false,
	UseNameplateHandoff = true,--Power user setting, no longer shown in GUI
	DontShowNameplateIcons = false,
	DontShowNameplateIconsCD = false,
	DontShowNameplateIconsCast = false,
	DontSendBossGUIDs = false,
	AlwaysKeepNPs = true,
	NPAuraText = true,
	NPIconSize = 30,
	NPIconOffsetX = 0,
	NPIconOffsetY = 20,--20 used to default offset is no longer covering buff/debuff icons on blizzard nameplates
	NPIconSpacing = 0,
	NPIconGrowthDirection = "CENTER",
	NPIconAnchorPoint = "TOP",
	NPIconTimerEnabled = true,
	NPIconTimerFont = "standardFont",
	NPIconTimerFontStyle = "None",
	NPIconTimerFontSize = 18,
	NPIconTextEnabled = true,
	NPIconTextFont = "standardFont",
	NPIconTextFontStyle = "None",
	NPIconTextFontSize = 10,
	NPIconTextMaxLen = 7,
	NPIconGlowBehavior = 1,
	CDNPIconGlowType = 1,--Pixel Default
	CastNPIconGlowBehavior = 1,
	CastNPIconGlowType2 = 4,--Button Default
	DontPlayCountdowns = false,
	DontSetTimelineColors = false,
	DontSendYells = false,
	BlockNoteShare = false,
	DontAutoGossip = false,
	DontShowPT2 = false,
	DontPlayPTCountdown = false,
	DontShowPTText = false,
	DontShowPTNoID = false,
	PTCountThreshold2 = 5,
	LatencyThreshold = 250,
	--AnnounceConsumables = false,
	SettingsMessageShown = false,
	NewsMessageShown2 = 2,--Apparently variable without 2 can still exist in some configs (config cleanup of no longer existing variables not working?)
	AlwaysShowSpeedKillTimer2 = false,
	ShowBrezFrame = false,
	ShowKeystoneOnComplete = true,
	OverrideKeystoneSlash = false,
	BrezFont = "standardFont",
	BrezFontSize = 18,
	BattleRezPosition = {"TOPLEFT", 214, -29},
	ShowRespawn = true,
	ShowQueuePop = true,
	ShowBerserkWarnings = true,
	HelpMessageVersion = 3,
	MoviesSeen = {},
	HideMovieDuringFight = true,
	HideMovieInstanceAnywhere = true,
	HideMovieNonInstanceAnywhere = false,
	HideMovieOnlyAfterSeen = true,
	LastRevision = 0,
	DebugMode = false,
	DebugLevel = 1,
	DebugSound = true,
	RoleSpecAlert = true,
	CheckGear = true,
	WorldBossAlert = not private.isRetail,
	WorldBuffAlert = not private.isRetail,
	BadTimerAlert = false,
	AutoAcceptFriendInvite = false,
	AutoAcceptGuildInvite = false,
	FakeBWVersion = false,
	ShortTimerText = true,
	HardcodedTimer = true,
	ChatFrame = "DEFAULT_CHAT_FRAME",
	SpellRenames = false,-- Reserved key for user spell rename overrides (actual table initialized per-profile in LoadOptions)
	CoreSavedRevision = 1,
	SilentMode = false,
	NoCombatScanningFeatures = false,
	ZoneCombatSyncing = false,--HIDDEN power user feature to improve zone scanning accuracy in niche cases
	HasShownMidnightPopup = false,
	IgnoreBlizzAPI = false,
	fixBlizzApi = false,
	DisableSWSound = false,
	--Aura Frame Options
	--Player
	PrivateAurasPlayerEnabled2 = true,
	PrivateAurasPlayerHideBorder = false,
	PrivateAurasPlayerHideTooltip = false,
	PrivateAurasPlayerSpacing2 = 1,
	PrivateAurasPlayerLimit = 5,
	PrivateAurasPlayerGrowDirection = "RIGHT",
	PrivateAurasPlayerSortMode = "Default",
	PrivateAurasPlayerWidth = 65,
	PrivateAurasPlayerHeight = 65,
	PrivateAurasPlayerTextFont = "standardFont",
	PrivateAurasPlayerTextFontStyle = "OUTLINE",
	PrivateAurasPlayerDurationFontSize = 32,
	PrivateAurasPlayerShowDecimalSeconds = true,
	PrivateAurasPlayerDecimalThreshold = 3,
	PrivateAurasPlayerStackFontSize = 25,
	PrivateAurasPlayerStackColor = {r = 1, g = 1, b = 1},
	PrivateAurasPlayerStackXOffset = -1,
	PrivateAurasPlayerStackYOffset = 1,
	PrivateAurasPlayerShowStacks = true,
	PrivateAurasPlayerShowDispelBorder = true,
	PrivateAurasPlayerAnchor = "CENTER",--NYI
	PrivateAurasPlayerRelativeTo = "CENTER",--NYI
	PrivateAurasPlayerXOffset = 185,--Partial (drag and drop only, no UI slider/editbox)
	PrivateAurasPlayerYOffset = 154,--Partial (drag and drop only, no UI slider/editbox)
	--Co-Tank
	PrivateAurasCoTankEnabled3 = "Auto",
	PrivateAurasCoTankHideBorder = false,
	PrivateAurasCoTankHideTooltip = false,
	PrivateAurasCoTankSpacing2 = 1,
	PrivateAurasCoTankLimit = 5,
	PrivateAurasCoTankGrowDirection = "LEFT",
	PrivateAurasCoTankSortMode = "Default",
	PrivateAurasCoTankWidth = 65,
	PrivateAurasCoTankHeight = 65,
	PrivateAurasCoTankTextFont = "standardFont",
	PrivateAurasCoTankTextFontStyle = "OUTLINE",
	PrivateAurasCoTankDurationFontSize = 32,
	PrivateAurasCoTankShowDecimalSeconds = false,
	PrivateAurasCoTankDecimalThreshold = 3,
	PrivateAurasCoTankStackFontSize = 25,
	PrivateAurasCoTankStackColor = {r = 1, g = 1, b = 1},
	PrivateAurasCoTankStackXOffset = -1,
	PrivateAurasCoTankStackYOffset = 1,
	PrivateAurasCoTankShowStacks = true,
	PrivateAurasCoTankShowDispelBorder = true,
	PrivateAurasCoTankAnchor = "CENTER",--NYI
	PrivateAurasCoTankRelativeTo = "CENTER",--NYI
	PrivateAurasCoTankXOffset = -196,--Partial (drag and drop only, no UI slider/editbox)
	PrivateAurasCoTankYOffset = 154,--Partial (drag and drop only, no UI slider/editbox)
	PrivateAurasCoTankShowSecond = false,
	PrivateAurasCoTankShowName = false,
	PrivateAurasCoTankNameFontSize = 16,
	PrivateAurasCoTankNameXOffset = 4,
	PrivateAurasCoTankNameYOffset = 0,
	PrivateAurasCoTankUseHealerInFiveMan = true,
	PrivateAurasCoTankSlot1Player = "",
	PrivateAurasCoTankSlot2Player = "",
	AurasMaxDuration = 120,
	AlwaysShowPlayerAuras = false,
}


local usedProfile = "Default"

---------------
--  Profile  --
---------------
---@param name string Profile save key.
---@return string Localized display name for the profile.
function DBM:GetLocalizedProfileName(name)
	if name == "Default" then
		return DEFAULT
	end
	return name
end

function DBM:CreateProfile(name)
	if not name or name == "" or name:find(" ") then
		self:AddMsg(L.PROFILE_CREATE_ERROR)
		return
	end
	if DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_CREATE_ERROR_D:format(self:GetLocalizedProfileName(name)))
		return
	end
	-- create profile
	usedProfile = name
	DBM_UsedProfile = usedProfile
	DBM_AllSavedOptions[usedProfile] = DBM_AllSavedOptions[usedProfile] or {}
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	if type(self.Options.SpellRenames) ~= "table" then
		self.Options.SpellRenames = {}
	end
	self:RefreshSpellRenames()
	-- rearrange position
	DBT:CreateProfile("DBM")
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_CREATED:format(self:GetLocalizedProfileName(name)))
end

function DBM:ApplyProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_APPLY_ERROR:format(self:GetLocalizedProfileName(name) or CL.UNKNOWN))
		return
	end
	usedProfile = name
	DBM_UsedProfile = usedProfile
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	if type(self.Options.SpellRenames) ~= "table" then
		self.Options.SpellRenames = {}
	end
	self:RefreshSpellRenames()
	-- rearrange position
	DBT:ApplyProfile("DBM", true)
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_APPLIED:format(self:GetLocalizedProfileName(name)))
end

function DBM:CopyProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_COPY_ERROR:format(self:GetLocalizedProfileName(name) or CL.UNKNOWN))
		return
	elseif name == usedProfile then
		self:AddMsg(L.PROFILE_COPY_ERROR_SELF)
		return
	end
	DBM_AllSavedOptions[usedProfile] = CopyTable(DBM_AllSavedOptions[name])
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	if type(self.Options.SpellRenames) ~= "table" then
		self.Options.SpellRenames = {}
	end
	self:RefreshSpellRenames()
	-- rearrange position
	DBT:CopyProfile(name, "DBM", true)
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_COPIED:format(self:GetLocalizedProfileName(name)))
end

function DBM:DeleteProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_DELETE_ERROR:format(self:GetLocalizedProfileName(name) or CL.UNKNOWN))
		return
	elseif name == "Default" then-- Default profile cannot be deleted.
		self:AddMsg(L.PROFILE_CANNOT_DELETE:format(DEFAULT))
		return
	end
	--Delete
	DBM_AllSavedOptions[name] = nil
	usedProfile = "Default"--Restore to default
	DBM_UsedProfile = usedProfile
	self.Options = DBM_AllSavedOptions[usedProfile]
	if not self.Options then
		-- the default profile got lost somehow (maybe WoW crashed and the saved variables file got corrupted)
		self:CreateProfile("Default")
	else
		if type(self.Options.SpellRenames) ~= "table" then
			self.Options.SpellRenames = {}
		end
		self:RefreshSpellRenames()
	end
	-- rearrange position
	DBT:DeleteProfile(name, "DBM")
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_DELETED:format(self:GetLocalizedProfileName(name), DEFAULT))
end

function DBM:RepositionFrames()
	-- rearrange position
	self:UpdateWarningOptions()
	self:UpdateSpecialWarningOptions()
	self.Arrow:LoadPosition()
	local rangeCheck = _G["DBMRangeCheck"]
	if rangeCheck then
		rangeCheck:ClearAllPoints()
		rangeCheck:SetPoint(self.Options.RangeFramePoint, UIParent, self.Options.RangeFramePoint, self.Options.RangeFrameX, self.Options.RangeFrameY)
	end
	local rangeCheckRadar = _G["DBMRangeCheckRadar"]
	if rangeCheckRadar then
		rangeCheckRadar:ClearAllPoints()
		rangeCheckRadar:SetPoint(self.Options.RangeFrameRadarPoint, UIParent, self.Options.RangeFrameRadarPoint, self.Options.RangeFrameRadarX, self.Options.RangeFrameRadarY)
	end
	local infoFrame = _G["DBMInfoFrame"]
	if infoFrame then
		infoFrame:ClearAllPoints()
		infoFrame:SetPoint(self.Options.InfoFramePoint, UIParent, self.Options.InfoFramePoint, self.Options.InfoFrameX, self.Options.InfoFrameY)
	end
end

---------------
--  Options  --
---------------
function DBM:AddDefaultOptions(t1, t2)
	for i, v in pairs(t2) do
		if t1[i] == nil then
			t1[i] = v
		elseif type(v) == "table" and type(t1[i]) == "table" then
			self:AddDefaultOptions(t1[i], v)
		end
	end
end

do
	local soundMigrationtable = {
		[8174] = 569200,--PVPFlagTaken
		[15391] = 543587,--UR_Algalon_BHole01
		[9278] = 552035,--HoodWolfTransformPlayer01
		[6674] = 566558,--BellTollNightElf
		[11742] = 566558,--BellTollNightElf
		[11965] = 551703,--Horseman_Laugh_01
		[37666] = 876098,--Blizzard Raid Emote
		[11466] = 552503,--BLACK_Illidan_04
		[68563] = 1412178,--VO_703_Illidan_Stormrage_03
		[11052] = 553050,--CAV_Kaz_Mark02
		[12506] = 553193,--KILJAEDEN02
		[11482] = 553566,--BLCKTMPLE_LadyMal_Aggro01
		[8826] = 554236,--Loa_Naxx_Aggro02
		[128466] = 554236,--Loa_Naxx_Aggro02
		[49764] = 555337,--TEMPEST_Millhouse_Pyro01
		[11213] = 563787,--TEMPEST_VoidRvr_Aggro01
		[15757] = 564859,--UR_YoggSaron_Slay01
		[25780] = 572130,--VO_BH_ALIZABAL_RESET_01
		[109293] = 2016732,--VO_801_Bwonsamdi_35_M
		[109295] = 2016734,--VO_801_Bwonsamdi_37_M
		[109296] = 2016735,--VO_801_Bwonsamdi_38_M
		[109308] = 2016747,--VO_801_Bwonsamdi_50_M
		[15588] = 553345,--UR_Kologarn_Slay02
		[15553] = 552023,--UR_Hodir_Slay01
		[109069] = 2015891,--VO_801_Scrollsage_Nola_34_F
		[15742] = 562111,--UR_Thorim_P1Wipe01
		[17067] = 563333,--IC_Valithria_Berserk01
		[16971] = 555967,--IC_Muradin_Saurfang02
	}
	function DBM:GetSoundMigration(sound)
		return soundMigrationtable[sound]
	end
end

function DBM:GetProfileID()
	local playerName, _, playerRealm = self:GetMyPlayerInfo()
	local _, currentSpecName, currentSpecGroup = self:GetCurrentSpecInfo()

	-- variable init
	local fullname = playerName .. "-" .. playerRealm
	local profileNum = private.playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0

	return fullname, profileNum, currentSpecName
end

function DBM:LoadModOptions(modId, inCombat, first)
	local oldSavedVarsName = modId:gsub("-", "") .. "_SavedVars"
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local savedStatsName = modId:gsub("-", "") .. "_SavedStats"
	local fullname, profileNum, currentSpecName = self:GetProfileID()

	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	local savedOptions = _G[savedVarsName][fullname] or {}
	local savedStats = _G[savedStatsName] or {}
	local existId = {}
	local modInstance = nil
	for _, id in ipairs(self.ModLists[modId]) do
		existId[id] = true
		-- init
		if not savedOptions[id] then savedOptions[id] = {} end
		---@class DBMMod
		local mod = self:GetModByName(id)
		modInstance = mod
		mod.showTestUI = DBM_ModsToLoadWithFullTestSupport.bossModsWithTests[id]
		-- migrate old option
		if _G[oldSavedVarsName] and _G[oldSavedVarsName][id] then
			self:Debug("LoadModOptions: Found old options, importing", 2)
			local oldTable = _G[oldSavedVarsName][id]
			_G[oldSavedVarsName][id] = nil
			savedOptions[id][profileNum] = oldTable
		end
		if not savedOptions[id][profileNum] and not first then--previous profile not found. load defaults
			self:Debug("LoadModOptions: No saved options, creating defaults for profile " .. profileNum, 2)
			local defaultOptions = {}
			for option, optionValue in pairs(mod.DefaultOptions) do
				if type(optionValue) == "table" then
					optionValue = optionValue.value
				elseif type(optionValue) == "string" then
					optionValue = mod:GetRoleFlagValue(optionValue)
				end
				defaultOptions[option] = optionValue
			end
			savedOptions[id][profileNum] = defaultOptions
		else
			savedOptions[id][profileNum] = savedOptions[id][profileNum] or mod.Options
			--check new option
			for option, optionValue in pairs(mod.DefaultOptions) do
				if savedOptions[id][profileNum][option] == nil then
					if type(optionValue) == "table" then
						optionValue = optionValue.value
					elseif type(optionValue) == "string" then
						optionValue = mod:GetRoleFlagValue(optionValue)
					end
					savedOptions[id][profileNum][option] = optionValue
				end
			end
			--clean unused saved variables (do not work on combat load)
			--Why are saved options cleaned twice?
			if not inCombat then
				for option, _ in pairs(savedOptions[id][profileNum]) do
					if type(option) == "number" then
						self:Debug("|cffff0000Option type invalid: |r" .. option)
					end
					if (mod.DefaultOptions[option] == nil) and (type(option) == "number" or not (option:find("talent") or option:find("FastestClear") or option:find("CVAR") or option:find("RestoreSetting") or option:find("MoviesSeen"))) then
						savedOptions[id][profileNum][option] = nil
					elseif mod.DefaultOptions[option] and (type(mod.DefaultOptions[option]) == "table") then--recover broken dropdown option
						if savedOptions[id][profileNum][option] and (type(savedOptions[id][profileNum][option]) == "boolean") then
							savedOptions[id][profileNum][option] = mod.DefaultOptions[option].value
						end
					--Fix default options for colored bar by type that were set to 0 because no defaults existed at time they were created, but do now.
					elseif option:find("TColor") then
						if savedOptions[id][profileNum][option] and savedOptions[id][profileNum][option] == 0 and mod.DefaultOptions[option] and mod.DefaultOptions[option] ~= 0 then
							savedOptions[id][profileNum][option] = mod.DefaultOptions[option]
							self:Debug("Migrated " .. option .. " to option defaults")
						end
					--Fix options for custom special warning sounds not in addons folder that are using soundkit Ids not and File Data Ids
					elseif option:find("SWSound") then
						local checkedOption = savedOptions[id][profileNum][option]
						if checkedOption and (type(checkedOption) == "number") and self:GetSoundMigration(checkedOption) then
							savedOptions[id][profileNum][option] = self:GetSoundMigration(checkedOption)
							self:Debug("Migrated " .. option .. " to file data Id")
						end
					end
				end
			end
		end
		--apply saved option to actual option table
		mod["Options"] = savedOptions[id][profileNum]
		--stats init (only first load)
		if first then
			savedStats[id] = savedStats[id] or {}
			local stats = savedStats[id]
			stats.followerKills = stats.followerKills or 0
			stats.followerPulls = stats.followerPulls or 0
			stats.storyKills = stats.storyKills or 0
			stats.storyPulls = stats.storyPulls or 0
			stats.normalKills = stats.normalKills or 0
			stats.normalPulls = stats.normalPulls or 0
			stats.normalBestRank = stats.normalBestRank or 0
			stats.heroicKills = stats.heroicKills or 0
			stats.heroicPulls = stats.heroicPulls or 0
			stats.challengeKills = stats.challengeKills or 0
			stats.challengePulls = stats.challengePulls or 0
			stats.challengeBestRank = stats.challengeBestRank or 0
			stats.mythicKills = stats.mythicKills or 0
			stats.mythicPulls = stats.mythicPulls or 0
			stats.normal25Kills = stats.normal25Kills or 0
			stats.normal25Pulls = stats.normal25Pulls or 0
			stats.heroic25Kills = stats.heroic25Kills or 0
			stats.heroic25Pulls = stats.heroic25Pulls or 0
			stats.lfr25Kills = stats.lfr25Kills or 0
			stats.lfr25Pulls = stats.lfr25Pulls or 0
			stats.timewalkerKills = stats.timewalkerKills or 0
			stats.timewalkerPulls = stats.timewalkerPulls or 0
			mod["stats"] = stats
			--run OnInitialize function
			if mod.OnInitialize then mod:OnInitialize(mod) end
		end
	end
	--clean unused saved variables (do not work on combat load)
	--Why are saved options cleaned twice?
	if not inCombat then
		for id, _ in pairs(savedOptions) do
			if not existId[id] and not (id:find("talent") or id:find("FastestClear") or id:find("CVAR") or id:find("RestoreSetting") or id:find("MoviesSeen")) then
				savedOptions[id] = nil
			end
		end
		for id, _ in pairs(savedStats) do
			if not existId[id] then
				savedStats[id] = nil
			end
		end
	end
	_G[savedVarsName][fullname] = savedOptions
	if profileNum > 0 then
		_G[savedVarsName][fullname]["talent" .. profileNum] = currentSpecName
		self:Debug("LoadModOptions: Finished loading " .. (_G[savedVarsName][fullname]["talent" .. profileNum] or CL.UNKNOWN))
	end
	_G[savedStatsName] = savedStats
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if not first and DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
	if modInstance and modInstance.WipeDuplicateOptions then
		modInstance:WipeDuplicateOptions()
	end
end

function DBM:SpecChanged(force)
	if not force and not DBM_UseDualProfile then return end
	--Load Options again.
	self:Debug("SpecChanged fired", 2)
	for modId, _ in pairs(self.ModLists) do
		self:LoadModOptions(modId)
	end
end

function DBM:LoadAllModDefaultOption(modId)
	-- modId is string like "DBM-Highmaul"
	if not modId or not self.ModLists[modId] then return end

	-- variable init
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local fullname, profileNum, currentSpecName = self:GetProfileID()

	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	if not _G[savedVarsName][fullname] then _G[savedVarsName][fullname] = {} end
	for _, id in ipairs(self.ModLists[modId]) do
		-- prevent nil table error
		if not _G[savedVarsName][fullname][id] then _G[savedVarsName][fullname][id] = {} end
		-- actual do load default option
		local mod = self:GetModByName(id)
		local defaultOptions = {}
		for option, optionValue in pairs(mod.DefaultOptions) do
			if type(optionValue) == "table" then
				optionValue = optionValue.value
			elseif type(optionValue) == "string" then
				optionValue = mod:GetRoleFlagValue(optionValue)
			end
			defaultOptions[option] = optionValue
		end
		mod["Options"] = {}
		mod["Options"] = defaultOptions
		_G[savedVarsName][fullname][id][profileNum] = {}
		_G[savedVarsName][fullname][id][profileNum] = mod.Options
	end
	self:AddMsg(L.ALLMOD_DEFAULT_LOADED)
	-- update gui if showing
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

---@param mod DBMMod
function DBM:LoadModDefaultOption(mod)
	-- mod must be table
	if not mod then return end

	-- variable init
	local savedVarsName = (mod.modId):gsub("-", "") .. "_AllSavedVars"
	local fullname, profileNum, currentSpecName = self:GetProfileID()

	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	if not _G[savedVarsName][fullname] then _G[savedVarsName][fullname] = {} end
	if not _G[savedVarsName][fullname][mod.id] then _G[savedVarsName][fullname][mod.id] = {} end
	-- do load default
	local defaultOptions = {}
	for option, optionValue in pairs(mod.DefaultOptions) do
		if type(optionValue) == "table" then
			optionValue = optionValue.value
		elseif type(optionValue) == "string" then
			optionValue = mod:GetRoleFlagValue(optionValue)
		end
		defaultOptions[option] = optionValue
	end
	mod["Options"] = {}
	mod["Options"] = defaultOptions
	_G[savedVarsName][fullname][mod.id][profileNum] = {}
	_G[savedVarsName][fullname][mod.id][profileNum] = mod.Options
	self:AddMsg(L.MOD_DEFAULT_LOADED)
	-- update gui if showing
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:CopyAllModOption(modId, sourceName, sourceProfile)
	-- modId is string like "DBM-Highmaul"
	if not modId or not sourceName or not sourceProfile or not DBM.ModLists[modId] then return end

	-- variable init
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local targetName, targetProfile, currentSpecName = self:GetProfileID()

	-- do not copy setting itself
	if targetName == sourceName and targetProfile == sourceProfile then
		self:AddMsg(L.MPROFILE_COPY_SELF_ERROR)
		return
	end
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	-- check source is exist
	if not _G[savedVarsName][sourceName] then
		self:AddMsg(L.MPROFILE_COPY_S_ERROR)
		return
	end
	if not _G[savedVarsName][targetName] then _G[savedVarsName][targetName] = {} end
	for _, id in ipairs(self.ModLists[modId]) do
		-- check source is exist
		if not _G[savedVarsName][sourceName][id] then
			self:AddMsg(L.MPROFILE_COPY_S_ERROR)
			return
		end
		if not _G[savedVarsName][sourceName][id][sourceProfile] then
			self:AddMsg(L.MPROFILE_COPY_S_ERROR)
			return
		end
		-- prevent nil table error
		if not _G[savedVarsName][targetName][id] then _G[savedVarsName][targetName][id] = {} end
		-- copy table
		_G[savedVarsName][targetName][id][targetProfile] = CopyTable(_G[savedVarsName][sourceName][id][sourceProfile])
		--check new option
		local mod = self:GetModByName(id)
		for option, optionValue in pairs(mod.Options) do
			if _G[savedVarsName][targetName][id][targetProfile][option] == nil then
				_G[savedVarsName][targetName][id][targetProfile][option] = optionValue
			end
		end
		-- apply to options table
		mod["Options"] = {}
		mod["Options"] = _G[savedVarsName][targetName][id][targetProfile]
	end
	if targetProfile > 0 then
		_G[savedVarsName][targetName]["talent" .. targetProfile] = currentSpecName
	end
	self:AddMsg(L.MPROFILE_COPY_SUCCESS:format(sourceName, sourceProfile))
	-- update gui if showing
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:CopyAllModTypeOption(modId, sourceName, sourceProfile, Type)
	-- modId is string like "DBM-Highmaul"
	if not modId or not sourceName or not sourceProfile or not self.ModLists[modId] or not Type then return end

	-- variable init
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local targetName, targetProfile, currentSpecName = self:GetProfileID()

	-- do not copy setting itself
	if targetName == sourceName and targetProfile == sourceProfile then
		self:AddMsg(L.MPROFILE_COPYS_SELF_ERROR)
		return
	end
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	-- check source is exist
	if not _G[savedVarsName][sourceName] then
		self:AddMsg(L.MPROFILE_COPYS_S_ERROR)
		return
	end
	if not _G[savedVarsName][targetName] then _G[savedVarsName][targetName] = {} end
	for _, id in ipairs(self.ModLists[modId]) do
		-- check source is exist
		if not _G[savedVarsName][sourceName][id] then
			self:AddMsg(L.MPROFILE_COPYS_S_ERROR)
			return
		end
		if not _G[savedVarsName][sourceName][id][sourceProfile] then
			self:AddMsg(L.MPROFILE_COPYS_S_ERROR)
			return
		end
		-- prevent nil table error
		if not _G[savedVarsName][targetName][id] then _G[savedVarsName][targetName][id] = {} end
		if not _G[savedVarsName][targetName][id][targetProfile] then _G[savedVarsName][targetName][id][targetProfile] = {} end
		-- copy table
		for option, optionValue in pairs(_G[savedVarsName][sourceName][id][sourceProfile]) do
			if option:find(Type) then
				_G[savedVarsName][targetName][id][targetProfile][option] = optionValue
			end
		end
		-- apply to options table
		local mod = self:GetModByName(id)
		mod["Options"] = {}
		mod["Options"] = _G[savedVarsName][targetName][id][targetProfile]
	end
	if targetProfile > 0 then
		_G[savedVarsName][targetName]["talent" .. targetProfile] = currentSpecName
	end
	self:AddMsg(L.MPROFILE_COPYS_SUCCESS:format(sourceName, sourceProfile))
	-- update gui if showing
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:DeleteAllModOption(modId, name, profile)
	-- modId is string like "DBM-Highmaul"
	if not modId or not name or not profile or not self.ModLists[modId] then return end

	-- variable init
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local fullname, profileNum, currentSpecName = self:GetProfileID()

	-- cannot delete current profile.
	if fullname == name and profileNum == profile then
		self:AddMsg(L.MPROFILE_DELETE_SELF_ERROR)
		return
	end
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	if not _G[savedVarsName][name] then
		self:AddMsg(L.MPROFILE_DELETE_S_ERROR)
		return
	end
	for _, id in ipairs(self.ModLists[modId]) do
		-- prevent nil table error
		if not _G[savedVarsName][name][id] then
			self:AddMsg(L.MPROFILE_DELETE_S_ERROR)
			return
		end
		-- delete
		_G[savedVarsName][name][id][profile] = nil
	end
	_G[savedVarsName][name]["talent" .. profile] = nil
	self:AddMsg(L.MPROFILE_DELETE_SUCCESS:format(name, profile))
end

function DBM:CreateDefaultModStats()
	---@class ModStats
	local defaultStats = {}
	defaultStats.followerKills = 0
	defaultStats.followerPulls = 0
	defaultStats.storyKills = 0
	defaultStats.storyPulls = 0
	defaultStats.normalKills = 0
	defaultStats.normalPulls = 0
	defaultStats.normalBestRank = 0
	defaultStats.heroicKills = 0
	defaultStats.heroicPulls = 0
	defaultStats.challengeKills = 0
	defaultStats.challengePulls = 0
	defaultStats.challengeBestRank = 0
	defaultStats.mythicKills = 0
	defaultStats.mythicPulls = 0
	defaultStats.normal25Kills = 0
	defaultStats.normal25Pulls = 0
	defaultStats.heroic25Kills = 0
	defaultStats.heroic25Pulls = 0
	defaultStats.lfr25Kills = 0
	defaultStats.lfr25Pulls = 0
	defaultStats.timewalkerKills = 0
	defaultStats.timewalkerPulls = 0
	return defaultStats
end

function DBM:ClearAllStats(modId)
	-- modId is string like "DBM-Highmaul"
	if not modId or not self.ModLists[modId] then return end
	-- variable init
	local savedStatsName = modId:gsub("-", "") .. "_SavedStats"
	-- prevent nil table error
	if not _G[savedStatsName] then _G[savedStatsName] = {} end
	for _, id in ipairs(self.ModLists[modId]) do
		local mod = self:GetModByName(id)
		local defaultStats = DBM:CreateDefaultModStats()
		mod["stats"] = defaultStats or {}
		_G[savedStatsName][id] = defaultStats or {}
	end
	self:AddMsg(L.ALLMOD_STATS_RESETED)
	DBM_GUI:UpdateModList()
end

do
	local gsub = string.gsub

	local function FixElv(optionName)
		if DBM.Options[optionName]:lower():find("interface\\addons\\elvui\\media\\") then
			DBM.Options[optionName] = gsub(DBM.Options[optionName], gsub("Interface\\AddOns\\ElvUI\\Media\\", "(%a)", function(v)
				return "[" .. v:upper() .. v:lower() .. "]"
			end), "Interface\\AddOns\\ElvUI\\Core\\Media\\")
		end
	end

	---@param self DBM
	function DBM:LoadOptions()
		--init
		if not DBM_AllSavedOptions then DBM_AllSavedOptions = {} end
		usedProfile = DBM_UsedProfile or usedProfile
		if not usedProfile or (usedProfile ~= "Default" and not DBM_AllSavedOptions[usedProfile]) then
			-- DBM.Option is not loaded. so use print function
			print(L.PROFILE_NOT_FOUND:format(DEFAULT))
			usedProfile = "Default"
		end
		DBM_UsedProfile = usedProfile
		self.Options = DBM_AllSavedOptions[usedProfile] or {}
		self:Enable()
		self:SetCurrentSpecInfo()
		self:AddDefaultOptions(self.Options, self.DefaultOptions)
		-- Reset the old load-time role-derived setting so the new live Auto setting is used instead.
		self.Options.PrivateAurasCoTankEnabled2 = nil
		if not self.Options.GUIResizeMigrated_1000x700 then
			if self.Options.GUIWidth == 800 and self.Options.GUIHeight == 600 then
				self.Options.GUIWidth = 1000
				self.Options.GUIHeight = 700
			end
			self.Options.GUIResizeMigrated_1000x700 = true
		end
		if type(self.Options.SpellRenames) ~= "table" then
			self.Options.SpellRenames = {}
		end
		self:RefreshSpellRenames()
		if not self.Options.CountdownVoiceNamesMigrated and HasLegacyCountVoiceOption(self.Options) then
			MigrateCountVoiceOption(self.Options, "CountdownVoice")
			MigrateCountVoiceOption(self.Options, "CountdownVoice2")
			MigrateCountVoiceOption(self.Options, "CountdownVoice3")
			MigrateCountVoiceOption(self.Options, "PullVoice")
			self.Options.CountdownVoiceNamesMigrated = true
		end
		DBM_AllSavedOptions[usedProfile] = self.Options

		-- force enable dual profile (change default)
		if DBM_CharSavedRevision < 12976 then
			if playerClass ~= "MAGE" and playerClass ~= "WARLOCK" and playerClass ~= "ROGUE" then
				DBM_UseDualProfile = true
			end
		end
		DBM_CharSavedRevision = self.Revision
		-- load special warning options
		self:UpdateWarningOptions()
		self:UpdateSpecialWarningOptions()
		self.Options.CoreSavedRevision = self.Revision
		--Fix fonts if they are nil
		if not self.Options.WarningFont then
			self.Options.WarningFont = "standardFont"
		end
		if not self.Options.SpecialWarningFont then
			self.Options.SpecialWarningFont = "standardFont"
		end
		--If users previous voice pack was not set to none, don't force change it to VEM, honor whatever it was set to before
		if self.Options.ChosenVoicePack and not self:IsNoneValue(self.Options.ChosenVoicePack) then
			self.Options.ChosenVoicePack2 = self.Options.ChosenVoicePack
			self.Options.ChosenVoicePack = nil
		end

		for _, setting in ipairs({
			-- Sounds
			"RaidWarningSound", "SpecialWarningSound", "SpecialWarningSound2", "SpecialWarningSound3", "SpecialWarningSound4", "SpecialWarningSound5", "EventSoundVictory2",
			"EventSoundWipe", "EventSoundEngage2", "EventSoundMusic", "EventSoundDungeonBGM", "RangeFrameSound1", "RangeFrameSound2",
			-- Fonts
			"InfoFrameFont", "WarningFont", "SpecialWarningFont"
		}) do
			-- Migrate ElvUI changes
			if type(self.Options[setting]) == "string" and not self:IsNoneValue(self.Options[setting]) then
				FixElv(setting)
			end
			-- Migrate soundkit to FileData ID changes
			if type(self.Options[setting]) == "number" and self:GetSoundMigration(self.Options[setting]) then
				self.Options[setting] = self:GetSoundMigration(self.Options[setting])
			end
		end
		--Inject build in media after options have loaded
		if not DBM.Options.EventMusicNoBuiltIn then
			if private.isRetail then
				DBM:AddDungeonMusic("Anduin Part 1 B", 1417242, 140)--"sound\\music\\Legion\\MUS_70_AnduinPt1_B.mp3" Soundkit: 68230
				DBM:AddBattleMusic("Anduin Part 2 B", 1417248, 111)--"sound\\music\\Legion\\MUS_70_AnduinPt2_B.mp3" Soundkit: 68230
				DBM:AddBattleMusic("Invincible", 1100052, 197)--"Sound\\Music\\Draenor\\MUS_Invincible.mp3" Soundkit: 49536
				--Duplicate entries to the all music Table
				DBM:AddMusic("Anduin Part 1 B", 1417242, 140)--"sound\\music\\Legion\\MUS_70_AnduinPt1_B.mp3" Soundkit: 68230
				DBM:AddMusic("Anduin Part 2 B", 1417248, 111)--"sound\\music\\Legion\\MUS_70_AnduinPt2_B.mp3" Soundkit: 68230
				DBM:AddMusic("Invincible", 1100052, 197)--"Sound\\Music\\Draenor\\MUS_Invincible.mp3" Soundkit: 49536
			end
			if private.isWrath or private.isCata or private.isMop or private.isRetail then
				DBM:AddBattleMusic("Bronze Jam", 350021, 116)--"Sound\\Music\\ZoneMusic\\IcecrownRaid\\IR_BronzeJam.mp3" Soundkit: 118800
				DBM:AddDungeonMusic("Ulduar: Titan Orchestra", 298910, 102)--"Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanOrchestraIntro.mp3" Soundkit: 15873
				--Duplicate entries to the all music Table
				DBM:AddMusic("Bronze Jam", 350021, 116)--"Sound\\Music\\ZoneMusic\\IcecrownRaid\\IR_BronzeJam.mp3" Soundkit: 118800
				DBM:AddMusic("Ulduar: Titan Orchestra", 298910, 102)--"Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanOrchestraIntro.mp3" Soundkit: 15873
				if not private.isWrath then
					DBM:AddDungeonMusic("Nightsong", 441705, 160)--"Sound\\Music\\cataclysm\\MUS_NightElves_GU01.mp3" Soundkit: 71181
					--Duplicate entries to the all music Table
					DBM:AddMusic("Nightsong", 441705, 160)--"Sound\\Music\\cataclysm\\MUS_NightElves_GU01.mp3" Soundkit: 71181
				end
			end
		end
	end
end

