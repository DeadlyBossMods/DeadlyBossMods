if GetLocale() ~= "ruRU" then return end
local L

-----------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCD		= "Кохром повторяет %s"
})

L:SetOptionLocalization({
	KohcromWarning	= "Предупреждать, когда Кохром повторяет заклинания Морхока",
	KohcromCD		= "Отсчет времени до следующего повторения заклинания"
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame	= "Показывать окно проверки дистанции (10м) для $spell:104601\n(Только на героическом уровне сложности)"
})

L:SetMiscLocalization({
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozes		= "Появляются камли: %s",
	specWarnOozes	= "Появились капли крови!",
})

L:SetTimerLocalization({
	timerOozesCD		= "Следующие капли",
	timerOozesActive	= "Появление капель",
})

L:SetOptionLocalization({
	warnOozes			= "Предупреждение о появлении новых капель крови",
	specWarnOozes		= "Спец-предупреждение о появлении новых капель крови",
	specWarnManaVoid	= "Спец-предупреждение о появлении $spell:105530",
	timerOozesCD		= "Отсчет времени до следующих капель крови",
	timerOozesActive	= "Отсчет времени спавна капель крови",
})

L:SetMiscLocalization({
	Black			= "|cFF424242черная|r",
	Purple			= "|cFF9932CDтеневая|r",
	Red				= "|cFFFF0404алая|r",
	Green			= "|cFF088A08кислотная|r",
	Blue			= "|cFF0080FFкобальтовая|r",
	Yellow			= "|cFFFFA901светящаяся|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	warnFrostTombCast		= "%s через 8 секунл"
})

L:SetTimerLocalization({
	TimerSpecial			= "Первая способность"
})

L:SetOptionLocalization({
	TimerSpecial			= "Отсчет времени до первой особой способности",
	RangeFrame				= "Показывать окно проверки дистанции (3) для $spell:105269",
	AnnounceFrostTombIcons	= "Дублировать рейдовые иконки на целях $spell:104451 в рейд-чат\n(Необходимы права лидера или помощника)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451)
})

L:SetMiscLocalization({
	TombIconSet				= "Ледяная гробница {rt%d} на %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "Начало боя"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Отсчет времени до начала боя"
})

L:SetMiscLocalization({
	Pull				= "Я чувствую приближение Хаоса… Мой разум не в силах этого выдержать!!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "Начало боя",
	TimerSapper			= "Следующий сапёр"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Отсчет времени до начала боя",
	TimerSapper			= "Отсчет времени до появления следующего сапёра"--npc=56923
})

L:SetMiscLocalization({
	SapperEmote			= "Дракон пикирует на палубу, чтобы сбросить на нее сумеречного сапера!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "Закрепитесь!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTendril			= "Спец-предупреждение, когда на вас нет дебаффа $spell:109454",--http://ptr.wowhead.com/npc=56188
	InfoFrame				= "Показывать информационное окно для игроков без $spell:109454",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109459)
})

L:SetMiscLocalization({
	Pull		= "The plates! He's coming apart! Tear up the plates and we've got a shot at bringing him down!",
	NoDebuff	= "Нет %s",
	DRoll		= "about to roll"	-- This emote needs to be confirmed/fixed if it's wrong. (no valid Transcriptor logs :( )
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
	SpecWarnTentacle	= "Раскаленное щупальце - переключитесь!"--Msg too long? maybe just "Blistering Tentacles!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTentacle	= "Спец-предупреждение, когда появляются раскаленные щупальца (и Алекстраза не активна)"--http://ptr.wowhead.com/npc=56188
})

L:SetMiscLocalization({
	Pull				= "You have done NOTHING. I will tear your world APART."
})
