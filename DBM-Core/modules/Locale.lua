local DBM, L = DBM, DBM_CORE_L
local pairs, setmetatable, tostring = pairs, setmetatable, tostring

local modLocalizationPrototype = {}

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

do
	local returnKey = {
		__index = function(_, k)
			return k
		end
	}

	function DBM:CreateModLocalization(name)
		name = tostring(name)
		local obj = {
			general = setmetatable({}, returnKey),
			warnings = setmetatable({}, {
				__index = setmetatable({
					warning_berserk = L.GENERIC_WARNING_BERSERK
				}, returnKey)
			}),
			options = setmetatable({}, {
				__index = setmetatable({
					timer_berserk = L.OPTION_TIMER_BERSERK,
					timer_combat = L.OPTION_TIMER_COMBAT,
				}, returnKey)
			}),
			timers = setmetatable({}, {
				__index = setmetatable({
					timer_berserk = L.GENERIC_TIMER_BERSERK,
					timer_combat = L.GENERIC_TIMER_COMBAT
				}, returnKey)
			}),
			miscStrings = setmetatable({}, {
				__index = {}
			}),
			cats = setmetatable({}, {
				__index = setmetatable({
					timer				= L.OPTION_CATEGORY_TIMERS,
					announce			= L.OPTION_CATEGORY_WARNINGS,
					announceother		= L.OPTION_CATEGORY_WARNINGS_OTHER,
					announcepersonal	= L.OPTION_CATEGORY_WARNINGS_YOU,
					announcerole		= L.OPTION_CATEGORY_WARNINGS_ROLE,
					sound				= L.OPTION_CATEGORY_SOUNDS,
					yell				= L.OPTION_CATEGORY_YELLS,
					icon				= L.OPTION_CATEGORY_ICONS,
					nameplate			= L.OPTION_CATEGORY_NAMEPLATES,
					misc				= MISCELLANEOUS
				}, returnKey)
			}),
		}
		setmetatable(obj, {
			__index = modLocalizationPrototype
		})
		modLocalizations[name] = obj
		return obj
	end
end

function DBM:GetModLocalization(name)
	name = tostring(name)
	return modLocalizations[name] or self:CreateModLocalization(name)
end
