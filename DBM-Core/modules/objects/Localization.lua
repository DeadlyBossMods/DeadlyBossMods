---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L

---@class DBM
local DBM = private:GetPrototype("DBM")

local returnKey = {
	__index = function(_, k)
		return k
	end
}

local defaultCatLocalization = {
	__index = setmetatable({
		timer				= L.OPTION_CATEGORY_TIMERS,
		announce			= L.OPTION_CATEGORY_WARNINGS,
		announceother		= L.OPTION_CATEGORY_WARNINGS_OTHER,
		announcepersonal	= L.OPTION_CATEGORY_WARNINGS_YOU,
		announcerole		= L.OPTION_CATEGORY_WARNINGS_ROLE,
		specialannounce		= L.OPTION_CATEGORY_SPECWARNINGS,
		sound				= L.OPTION_CATEGORY_SOUNDS,
		yell				= L.OPTION_CATEGORY_YELLS,
		icon				= L.OPTION_CATEGORY_ICONS,
		paura				= L.OPTION_CATEGORY_PAURAS,
		nameplate			= L.OPTION_CATEGORY_NAMEPLATES,
		misc				= MISCELLANEOUS
	}, returnKey)
}

local defaultTimerLocalization = {
	__index = setmetatable({
		timer_berserk = L.GENERIC_TIMER_BERSERK,
		timer_combat = L.AUTO_TIMER_TEXTS.combat
	}, returnKey)
}

local defaultAnnounceLocalization = {
	__index = setmetatable({
	}, returnKey)
}

local defaultOptionLocalization = {
	__index = setmetatable({
		timer_berserk = L.OPTION_TIMER_BERSERK,
		timer_combat = L.AUTO_TIMER_OPTIONS.combat,
	}, returnKey)
}

local defaultMiscLocalization = {
	__index = {}
}

---@class ModLocalization
---@field general table<string, string>
---@field warnings table<string, string>
---@field timers table<string, string>
---@field options table<string, string>
---@field cats table<string, string>
---@field miscStrings table<string, string>
local modLocalizationPrototype = private:GetPrototype("ModLocalization")

local mt = {__index = modLocalizationPrototype}

function modLocalizationPrototype:SetGeneralLocalization(t)
	for i, v in pairs(t) do
		self.general[i] = v
	end
end

function modLocalizationPrototype:SetWarningLocalization(t)
	for i, v in pairs(t) do
		self.warnings[i] = v
	end
end

function modLocalizationPrototype:SetTimerLocalization(t)
	for i, v in pairs(t) do
		self.timers[i] = v
	end
end

function modLocalizationPrototype:SetOptionLocalization(t)
	for i, v in pairs(t) do
		self.options[i] = v
	end
end

function modLocalizationPrototype:SetOptionCatLocalization(t)
	for i, v in pairs(t) do
		self.cats[i] = v
	end
end

function modLocalizationPrototype:SetMiscLocalization(t)
	for i, v in pairs(t) do
		self.miscStrings[i] = v
	end
end

local modLocalizations = {}

function DBM:CreateModLocalization(name)
	name = tostring(name)
	local obj = {
		general = setmetatable({}, returnKey),
		warnings = setmetatable({}, defaultAnnounceLocalization),
		options = setmetatable({}, defaultOptionLocalization),
		timers = setmetatable({}, defaultTimerLocalization),
		miscStrings = setmetatable({}, defaultMiscLocalization),
		cats = setmetatable({}, defaultCatLocalization),
	}
	setmetatable(obj, mt)
	modLocalizations[name] = obj
	return obj
end

function DBM:GetModLocalization(name)
	name = tostring(name)
	return modLocalizations[name] or self:CreateModLocalization(name)
end
