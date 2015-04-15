if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

L:SetOptionLocalization({
	MythicSoakBehavior	= "為神話模式團隊設置分傷戰術的團隊警告",
	ThreeGroup			= "三小隊一層的戰術",
	TwoGroup			= "兩小隊兩層的戰術" 
})

---------------------------
-- Oregorger, The Devourer --
---------------------------
L= DBM:GetModLocalization(1202)

L:SetOptionLocalization({
	InterruptBehavior	= "設定中斷警告的行為模式",
	Smart				= "基於首領黑石彈幕層數發出中斷警告",
	Fixed				= "持續3中斷或5中斷警告"
})

---------------------------
-- The Blast Furnace --
---------------------------
L= DBM:GetModLocalization(1154)

L:SetWarningLocalization({
	warnRegulators			= "熱能調節閥剩餘:%d",
	warnBlastFrequency		= "爆炸施放頻率增加：大約每%d秒一次",
	specWarnTwoVolatileFire	= "你中了兩個烈性之火!"
})

L:SetOptionLocalization({
	warnRegulators			= "提示熱能調節閥還剩多少體力",
	warnBlastFrequency		= "提示$spell:155209施放頻率增加",
	specWarnTwoVolatileFire	= "當你中了兩個$spell:176121顯示特別警告",
	InfoFrame				= "為$spell:155192和$spell:155196顯示訊息框架",
	VFYellType2				= "設定烈性之火的大喊方式 (只有傳奇模式)",
	Countdown				= "倒數直到消失",
	Apply					= "只有中了時候"
})

L:SetMiscLocalization({
	heatRegulator		= "熱能調節閥",
	Regulator			= "調節閥%d",
	bombNeeded			= "%d炸彈"
})

------------------
-- Hans'gar And Franzok --
------------------
L= DBM:GetModLocalization(1155)

--------------
-- Flamebender Ka'graz --
--------------
L= DBM:GetModLocalization(1123)

--------------------
--Kromog, Legend of the Mountain --
--------------------
L= DBM:GetModLocalization(1162)

L:SetMiscLocalization({
	ExRTNotice		= "%s發送ExRT的符文位置分配。你的位置為:%s"
})

--------------------------
-- Beastlord Darmac --
--------------------------
L= DBM:GetModLocalization(1122)

--------------------------
-- Operator Thogar --
--------------------------
L= DBM:GetModLocalization(1147)

L:SetWarningLocalization({
	specWarnSplitSoon	= "10秒後團隊分開"
})

L:SetOptionLocalization({
	specWarnSplitSoon	= "團隊分開10秒前顯示特別警告",
	InfoFrameSpeed		= "設定何時訊息框架顯示下一次列車的資訊",
	Immediately			= "車門一開後立即顯示此班列車",
	Delayed				= "在此班列車出站之後",
	HudMapUseIcons		= "為HudMap使用團隊圖示而非綠圈",
	TrainVoiceAnnounce	= "設定列車的語音警告模式",
	LanesOnly			= "只提示即將來的軌道",
	MovementsOnly		= "只提示軌道走位 (只有傳奇模式)",
	LanesandMovements	= "提示即將來的軌道和軌道走位 (只有傳奇模式)"
})

L:SetMiscLocalization({
	Train			= GetSpellInfo(174806),
	lane			= "車道",
	oneTrain		= "一個隨機列車道",
	oneRandom		= "出現一個隨機列車道",
	threeTrains		= "三個隨機列車道",
	threeRandom		= "出現三個隨機列車道",
	helperMessage	= "在這戰鬥推薦搭配協力插件'Thogar Assist'或是新版本的DBM語音包。可從Curse下載 "
})

--------------------------
-- The Iron Maidens --
--------------------------
L= DBM:GetModLocalization(1203)

L:SetWarningLocalization({
	specWarnReturnBase	= "快回到碼頭！"
})

L:SetOptionLocalization({
	specWarnReturnBase	= "當船上玩家可以安全回到碼頭時顯示特別警告",
	filterBladeDash3	= "不要為$spell:155794顯示特別警告當中了$spell:170395",
	filterBloodRitual3	= "不要為$spell:158078顯示特別警告當中了$spell:170405"
})

L:SetMiscLocalization({
	shipMessage		= "準備裝填無畏號的主砲了！"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

L:SetWarningLocalization({
	specWarnMFDPosition		= "死亡標記站位：%s",
	specWarnSlagPosition	= "裝置熔渣彈站位: %s"
})

L:SetOptionLocalization({
	PositionsAllPhases	= "讓所有階段大喊$spell:156096 (這選項使用於測試確保功能正常，不推薦使用)",
	InfoFrame			= "為$spell:155992和$spell:156530顯示訊息框架"
})

L:SetMiscLocalization({
	customMFDSay	= "%2$s中了死亡標記(%1$s)",
	customSlagSay	= "%2$s中了裝置熔渣彈(%1$s)"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"黑石鑄造場小怪"
})
