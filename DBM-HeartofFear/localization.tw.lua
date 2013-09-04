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
	warnEcho			= "提示回聲出現",
	warnEchoDown		= "提示回聲已擊殺",
	specwarnPlatform	= "為首領轉換露臺顯示特別警告",
	ArrowOnAttenuation	= "為$spell:127834指示DBM箭頭移動方向"
})

L:SetMiscLocalization({
	Platform			= "飛向他的其中一個露臺!",
	Defeat				= "我們不會居服於黑暗虛空的絕望之下。如果她的意志要我們滅亡，那麼我們就該滅亡。"
})


------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "當某人中了$spell:122949時顯示DBM箭頭"
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
	countdownCrush		= DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(122774).." (只有英雄模式)"
})

L:SetMiscLocalization({
	UnderHim			= "在他下面",
	Phase2				= "巨大的裝甲開始破裂並粉碎!"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s在>%s<(%d)",
	warnReshapeLifeTutor		= "1:中斷/易傷(使用這招堆疊易傷), 2:中斷自己所施放的琥珀爆炸, 3:回復意志力當意志力低落(主要是P3使用), 4:脫離魁儡(P1和P2使用)",
	warnAmberExplosion			= ">%s<正在施放%s",
	warnAmberExplosionAM		= "琥珀巨怪正在施放琥珀爆炸 - 快中斷!",
	warnInterruptsAvailable		= "可為%s使用中斷:>%s<",
	warnWillPower				= "目前的意志力:%s",
	specwarnWillPower			= "意志力低落! - 離開變身或是吃黃水",
	specwarnAmberExplosionYou	= "中斷你自己的%s!",
	specwarnAmberExplosionAM	= "%s:中斷%s!",
	specwarnAmberExplosionOther	= "%s:中斷%s!"
})

L:SetTimerLocalization({
	timerDestabalize			= "動搖 (%2$d):%1$s",
	timerAmberExplosionAMCD		= "琥珀爆炸冷卻:琥珀巨怪"
})

L:SetOptionLocalization({
	warnReshapeLifeTutor		= "顯示突變魁儡的能力說明效果",
	warnAmberExplosion			= "為$spell:122398施放顯示警告(以及來源)",
	warnAmberExplosionAM		= "為琥珀巨怪的$spell:122398顯示個人警告(為了中斷)",
	warnInterruptsAvailable		= "提示誰有琥珀打擊可使用以中斷$spell:122402",
	warnWillPower				= "提示目前意志力在80,50,30,10,和4.",
	specwarnWillPower			= "為在傀儡裡時意志力低落顯示特別警告",
	specwarnAmberExplosionYou	= "為中斷你自己的$spell:122398顯示特別警告",
	specwarnAmberExplosionAM	= "為中斷琥珀巨怪的$spell:122402顯示特別警告",
	specwarnAmberExplosionOther	= "為中斷突變傀儡的$spell:122398顯示特別警告",
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
	warnAmberTrap		= "琥珀陷阱:(%d/5)"
})

L:SetOptionLocalization({
	warnAmberTrap		= "為$spell:125826的製作進度顯示警告",
	InfoFrame			= "為受到$spell:125390的玩家顯示訊息框架"
})

L:SetMiscLocalization({
	PlayerDebuffs		= "凝視",
	YellPhase3			= "不要再找藉口了，女皇!消滅這些侏儒，否則我會親自殺了妳!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HoFTrash")

L:SetGeneralLocalization({
	name =	"恐懼之心小怪"
})

L:SetOptionLocalization({
	UnseenStrikeArrow	= "當某人中了$spell:122949顯示DBM箭頭"
})
