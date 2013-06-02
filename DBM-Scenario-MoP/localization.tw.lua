if GetLocale() ~= "zhTW" then return end
local L

---------------------
-- A Brewing Storm --
---------------------
L= DBM:GetModLocalization("d517")

L:SetTimerLocalization{
	timerEvent			= "釀酒完成(大約的時間)"
}

L:SetOptionLocalization{
	timerEvent			= "為釀酒完成顯示大約時間的計時器"
}

L:SetMiscLocalization{
	BrewStart			= "風暴開始了!準備好。",
	BorokhulaPull		= "該死了，你這個舌頭分岔的滑溜爬蟲!",
	BorokhulaAdds		= "呼叫援助!"
}

-----------------------
-- A Little Patience --
-----------------------
L= DBM:GetModLocalization("d589")

L:SetMiscLocalization{
	ScargashPull		= "你們這些聯盟太弱了!"
}

---------------------------
-- Arena Of Annihilation --
---------------------------
L= DBM:GetModLocalization("d511")

-------------------------
-- Assault on Zan'vess --
-------------------------
L= DBM:GetModLocalization("d593")

L:SetMiscLocalization{
	TelvrakPull			= "贊斐斯永遠不會倒下!"
}

------------------------------
-- Battle on the High Seas ---
------------------------------
L= DBM:GetModLocalization("d652")

-----------------------
-- Blood in the Snow --
-----------------------
L= DBM:GetModLocalization("d646")

-----------------------
-- Brewmoon Festival --
-----------------------
L= DBM:GetModLocalization("d539")

L:SetTimerLocalization{
	timerBossCD		= "%s接近"
}

L:SetOptionLocalization{
	timerBossCD		= "為下一次首領重生顯示計時器"
}

L:SetMiscLocalization{
	RatEngage	= "小心，",
	BeginAttack	= "我們必須保衛村莊!",
	Yeti		= "巴塔利戰爭雪人",
	Qobi		= "戰爭使者闊畢"
}

------------------------------
-- Crypt of Forgotten Kings --
------------------------------
L= DBM:GetModLocalization("d504")

-----------------------
-- Dagger in the Dark --
-----------------------
L= DBM:GetModLocalization("d616")

L:SetTimerLocalization{
	timerAddsCD		= "呼叫小兵冷卻"
}

L:SetOptionLocalization{
	timerAddsCD		= "為暗孵蜥蜴王呼叫小兵顯示冷卻計時器"
}

L:SetMiscLocalization{
	LizardLord		= "那些薩烏洛克在守護洞穴，我們來對付他們。"
}

----------------------------
-- Dark Heart of Pandaria --
----------------------------
L= DBM:GetModLocalization("d647")

L:SetMiscLocalization{
	summonElemental		= "Minions, destroy these insects!"
}

------------------------
-- Greenstone Village --
------------------------
L= DBM:GetModLocalization("d492")

--------------
-- Landfall --
--------------
L = DBM:GetModLocalization("Landfall")

local landfall
if UnitFactionGroup("player") == "Alliance" then
	landfall = GetDungeonInfo(590)
else
	landfall = GetDungeonInfo(595)
end

L:SetGeneralLocalization{
	name = landfall
}

L:SetWarningLocalization{
	WarnAchFiveAlive	= "成就\"五小福\"失敗"
}

L:SetOptionLocalization{
	WarnAchFiveAlive	= "為成就\"五小福\"失敗顯示警告."
}

----------------------------
-- The Secret of Ragefire --
----------------------------
L= DBM:GetModLocalization("d649")

L:SetMiscLocalization{
	XorenthPull		= "所有低等種族都是正統部落的敵人。",
	ElagloPull		= "Fools! The true horde cannot be stopped by the likes of you."
}

----------------------
-- Theramore's Fall --
----------------------
L= DBM:GetModLocalization("d566")

--------------------------------
-- Troves of the Thunder King --
--------------------------------
L= DBM:GetModLocalization("d620")

----------------
-- Unga Ingoo --
----------------
L= DBM:GetModLocalization("d499")

------------------------
-- Warlock Green Fire --
------------------------
L= DBM:GetModLocalization("d594")

L:SetWarningLocalization{
	specWarnLostSouls		= "靈魂迷失!",
	specWarnEnslavePitLord	= "深淵領主 - 快奴役惡魔!"
}

L:SetTimerLocalization{
	timerCombatStarts		= "戰鬥開始",
	timerLostSoulsCD		= "靈魂迷失冷卻"
}

L:SetOptionLocalization{
	specWarnLostSouls		= "為靈魂迷失重生顯示特別警告",
	specWarnEnslavePitLord	= "為需對深淵領主使用奴役惡魔時顯示特別警告",
	timerCombatStarts		= "為戰鬥開始顯示時間",
	timerLostSoulsCD		= "為下一次靈魂迷失重生顯示冷卻計時器"
}

L:SetMiscLocalization{
	LostSouls				= "面對注定滅亡的同儕靈魂，術士!"
}