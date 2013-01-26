if GetLocale() ~= "zhTW" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnAttenuation		= "%s在%s(%s)",
	warnEcho			= "回聲出現",
	warnEchoDown		= "回聲已擊殺",
	specwarnAttenuation	= "%s在%s(%s)",
	specwarnPlatform	= "轉換露臺"
})

L:SetOptionLocalization({
	warnAttenuation		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(127834),
	warnEcho			= "提示回聲出現",
	warnEchoDown		= "提示回聲已擊殺",
	specwarnAttenuation	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(127834),
	specwarnPlatform	= "為首領轉換露臺顯示特別警告",
	ArrowOnAttenuation	= "為$spell:127834指示DBM箭頭移動方向",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform			= "飛向他的其中一個露臺!",
	Defeat				= "我們不會居服於黑暗虛空的絕望之下。如果她的意志要我們滅亡，那麼我們就該滅亡。",
	Left				= "往左",
	Right				= "往右"
})


------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "當某人受到$spell:122949影響時顯示DBM箭頭",
	RangeFrame			= "為$spell:123175顯示距離框架(8碼)"
})


-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetWarningLocalization({
	specwarnUnder		= "離開紫色圓圈範圍!"
})

L:SetOptionLocalization({
	specwarnUnder		= "當你在紫色圓圈範圍內顯示特別警告",
	countdownCrush		= DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(122774).." (只有英雄模式)",
	PheromonesIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835)
})

L:SetMiscLocalization({
	UnderHim			= "在他下面",
	Phase2				= "巨大的裝甲開始破裂並粉碎!"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s在>%s<(%d)",
	warnReshapeLifeTutor		= "1:中斷/易傷,, 2:中斷自己, 3:回復體力/意志力, 4:脫離魁儡",
	warnAmberExplosion			= ">%s<正在施放%s",
	warnInterruptsAvailable		= "可使用中斷%s:>%s<",
	warnAmberExplosionAM		= "琥珀巨怪正在施放琥珀爆炸 - 快中斷!",--personal warning.
	warnWillPower				= "目前的意志力:%s",
	specwarnWillPower			= "意志力低落! - 剩下五秒",
	specwarnAmberExplosionYou	= "中斷你自己的%s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s:中斷%s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s:中斷%s!"--Amber Montrosity
})

L:SetTimerLocalization({
	timerDestabalize			= "動搖 (%2$d):%1$s",
	timerAmberExplosionAMCD		= "琥珀爆炸冷卻:琥珀巨怪"
})

L:SetOptionLocalization({
	warnReshapeLife				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(122784),
	warnReshapeLifeTutor		= "顯示突變魁儡的能力說明效果",
	warnAmberExplosion			= "為$spell:122398施放顯示警告(以及來源)",
	warnAmberExplosionAM		= "為琥珀巨怪的$spell:122398顯示個人警告(為了中斷)",
	warnInterruptsAvailable		= "提示誰有琥珀打擊可使用以中斷$spell:122402",
	warnWillPower				= "提示目前意志力在80,50,30,10,和4.",
	specwarnWillPower			= "為在傀儡裡時意志力低落顯示特別警告",
	specwarnAmberExplosionYou	= "為中斷你自己的$spell:122398顯示特別警告",
	specwarnAmberExplosionAM	= "為中斷琥珀巨怪的$spell:122402顯示特別警告",
	specwarnAmberExplosionOther	= "為中斷突變傀儡的$spell:122398顯示特別警告",
	timerDestabalize			= DBM_CORE_AUTO_TIMER_OPTIONS.target:format(123059),
	timerAmberExplosionAMCD		= "為琥珀巨怪下一次的$spell:122402顯示計時器",
	InfoFrame					= "為玩家的意志力顯示訊息框架",
	FixNameplates				= "開戰後自動禁用擾人的名字血條(離開戰鬥後恢復設定)"
})

L:SetMiscLocalization({
	WillPower					= "意志力"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "琥珀陷阱:(%d/5)",
})

L:SetOptionLocalization({
	warnAmberTrap		= "為$spell:125826的製作進度顯示警告", -- maybe bad translation.
	InfoFrame			= "為受到$spell:125390的玩家顯示訊息框架",
	RangeFrame			= "為$spell:123735顯示距離框架(5碼)",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097),
	HeartOfFearIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(123845)
})

L:SetMiscLocalization({
	PlayerDebuffs		= "凝視",
	YellPhase3			= "不要再找藉口了，女皇!消滅這些侏儒，否則我會親自殺了妳!"
})
