---@class DBMCoreNamespace
local private = select(2, ...)

--Hard code STANDARD_TEXT_FONT since skinning mods like to taint it (or worse, set it to nil, wtf?)
if LOCALE_koKR then
	private.standardFont = "Fonts\\2002.TTF"
elseif LOCALE_zhCN then
	private.standardFont = "Fonts\\ARKai_T.ttf"
elseif LOCALE_zhTW then
	private.standardFont = "Fonts\\blei00d.TTF"
elseif LOCALE_ruRU then
	private.standardFont = "Fonts\\FRIZQT___CYR.TTF"
else
	private.standardFont = "Fonts\\FRIZQT__.TTF"
end
