if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Hellfire Assault --
---------------
L= DBM:GetModLocalization(1426)

L:SetTimerLocalization({
	timerSiegeVehicleCD		= "下一個載具%s",
})

L:SetOptionLocalization({
	timerSiegeVehicleCD =	"為下一個攻城載具重生顯示計時器"
})

L:SetMiscLocalization({
	AddsSpawn1		=	"火力全開！",
	AddsSpawn2		=	"開火！",
	BossLeaving		=	"我會回來的…"
})

---------------------------
-- Iron Reaver --
---------------------------
L= DBM:GetModLocalization(1425)

---------------------------
-- Hellfire High Council --
---------------------------
L= DBM:GetModLocalization(1432)

L:SetWarningLocalization({
	reapDelayed =	"收割在夢魘幻貌結束之後"
})

------------------
-- Kormrok --
------------------
L= DBM:GetModLocalization(1392)

L:SetMiscLocalization({
	ExRTNotice		= "%s 送出ExRT的位置分配。你的位置：橘:%s, 綠:%s, 紫:%s"
})

--------------
-- Kilrogg Deadeye --
--------------
L= DBM:GetModLocalization(1396)

L:SetMiscLocalization({
	BloodthirstersSoon	= "都給我上！盡你們的責任！"
})

--------------------
--Gorefiend --
--------------------
L= DBM:GetModLocalization(1372)

L:SetTimerLocalization({
	SoDDPS2		= "下一次死亡之影(%s)",
	SoDTank2	= "下一次死亡之影(%s)",
	SoDHealer2	= "下一次死亡之影(%s)"
})

L:SetOptionLocalization({
	SoDDPS2		= "為下一個傷害職中了$spell:179864顯示計時器",
	SoDTank2	= "為下一個坦克職中了$spell:179864顯示計時器",
	SoDHealer2	= "為下一個治療職中了$spell:179864顯示計時器",
	ShowOnlyPlayer	= "只顯示HudMap在當你參與到$spell:179909時"
	
})

--------------------------
-- Shadow-Lord Iskar --
--------------------------
L= DBM:GetModLocalization(1433)

L:SetWarningLocalization({
	specWarnThrowAnzu =	"把安祖之眼丟給%s！"
})

L:SetOptionLocalization({
	specWarnThrowAnzu =	"當你需要把$spell:179202丟給其他人顯示特別警告"
})

--------------------------
-- Fel Lord Zakuun --
--------------------------
L= DBM:GetModLocalization(1391)

L:SetOptionLocalization({
	SeedsBehavior		= "設定團隊的種子大喊行為(需要團隊隊長)",
	Iconed				= "星星,圈圈,鑽石,三角,月亮。適用於用於分散站位",
	Numbered			= "1, 2, 3, 4, 5。適用於分區站位",
	DirectionLine		= "左, 中偏左, 中間, 中偏右, 右。適用於直線站位",
	FreeForAll			= "自由模式。不指定佔位，只使用普通的大喊"
})

L:SetMiscLocalization({
	DBMConfigMsg		= "種子設定已設定為%s以符合團隊隊長設定。",
	BWConfigMsg			= "團隊隊長使用Bigwigs中，設定DBM為編號以符合Bigwigs的種子大喊。"
})

--------------------------
-- Xhul'horac --
--------------------------
L= DBM:GetModLocalization(1447)

L:SetOptionLocalization({
	ChainsBehavior		= "設定魔化鎖鍊警告行為",
	Cast				= "只給原始目標施放開始時警告。計時器同步在施放開始時。",
	Applied				= "只會中招目標施放結束時警告。計時器同步在施放結束時。",
	Both				= "原始目標施放開始時和中招目標施放結束時警告。"
})

--------------------------
-- Socrethar the Eternal --
--------------------------
L= DBM:GetModLocalization(1427)

L:SetOptionLocalization({
	InterruptBehavior	= "設置團隊的中斷模式(需要團隊隊長)",
	Count3Resume		= "3人持續計數循環中斷當護盾消失時",--Default
	Count3Reset			= "3人重置計數循環中斷當護盾消失時",
	Count4Resume		= "4人持續計數循環中斷當護盾消失時",
	Count4Reset			= "4人重置計數循環中斷當護盾消失時"
})

--------------------------
-- Tyrant Velhari --
--------------------------
L= DBM:GetModLocalization(1394)

--------------------------
-- Mannoroth --
--------------------------
L= DBM:GetModLocalization(1395)

L:SetMiscLocalization({
	felSpire		=	"開始強化惡魔尖塔！"
})

--------------------------
-- Archimonde --
--------------------------
L= DBM:GetModLocalization(1438)

L:SetWarningLocalization({
	specWarnBreakShackle	= "束縛折磨：%s拉斷!"
})

L:SetOptionLocalization({
	specWarnBreakShackle	= "當中了$spell:184964時顯示特別警告。此警告會自動分配拉斷順序去最小化承受傷害。",
	ExtendWroughtHud3		= "把HUB連線延伸到$spell:185014目標 (可能會降低連線精準度)",
	AlternateHudLine		= "為$spell:185014之間的目標HUD連線使用替代連線材質",
	NamesWroughtHud			= "為$spell:185014目標顯示HUD的玩家名稱",
	FilterOtherPhase		= "過濾掉與你不同階段的警告",
	MarkBehavior			= "設置燃燒軍團印記大喊方式(需要團隊隊長)",
	Numbered				= "星星、圈圈、鑽石、三角。適用任何站位的打法。",--Default
	LocSmallFront			= "近戰(左星星、右圈圈)、遠程(左鑽石、右三角)。 短時間減益在近戰。",
	LocSmallBack			= "近戰(左鑽石、右三角)、遠程(左星星、右圈圈)。 短時間減益在遠程。",
	NoAssignment			= "為整個團隊禁用所有站位大喊/訊息，還有HUD指示。"
})

L:SetMiscLocalization({
	phase2point5		= "看看燃燒軍團的軍容有多壯盛，就知道你們無謂的抵抗有多愚蠢。",
	First				= "第一個",
	Second				= "第二個",
	Third				= "第三個",
	Fourth				= "第四個",
	Fifth				= "第五個",
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HellfireCitadelTrash")

L:SetGeneralLocalization({
	name =	"地獄火堡壘小怪"
})
