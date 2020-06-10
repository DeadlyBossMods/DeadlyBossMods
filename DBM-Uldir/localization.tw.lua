if GetLocale() ~= "zhTW" then return end
local L

---------------------------
-- Taloc the Corrupted --
---------------------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"有仇恨"
})

---------------------------
-- MOTHER --
---------------------------
--L= DBM:GetModLocalization(2167)

---------------------------
-- Fetid Devourer --
---------------------------
L= DBM:GetModLocalization(2146)

L:SetWarningLocalization({
	addsSoon		= "滑道已開啟 - 小怪來了"
})

L:SetTimerLocalization({
	chuteTimer		= "下一次滑道(%s)"
})

L:SetOptionLocalization({
	addsSoon		= "為滑道開啟和開始小怪準備出現顯示預先警告",
	chuteTimer		= "為何時滑道開啟顯示計時器"
})

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

L:SetTimerLocalization({
	timerOrbLands	= "腐化之球落地"
})

L:SetOptionLocalization({
	timerOrbLands	 =	"為腐化之球落地顯示計時器",
	EarlyTankSwap	 =	"碎擊斬後馬上顯示換坦警告而不是等到第二個虛無鞭笞"
})

L:SetMiscLocalization({
	CThunDisc	 =	"Disc accessed. C'thun data loading.",
	YoggDisc	 =	"Disc accessed. Yogg-Saron data loading.",
	CorruptedDisc =	"Disc accessed. Corrupted data loading."
})

---------------------------
-- Vectis --
---------------------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst3	 =	"在訊息框架中從最高層數開始排序慢性感染(而非從最低)",
	ShowOnlyParty		 =	"只顯示你隊伍中的慢性感染",
	SetIconsRegardless	 =	"無論Bigwig使用者是否為助理成員皆去標記團隊圖示(進階選項)"
})

L:SetMiscLocalization({
	BWIconMsg			 =	"DBM交給Bigwig的助理成員去標記團隊圖示避免圖示混亂，確定他們有啟用或是降級他們去開啟DBM的標記，或在維克提斯的選項中啟用覆蓋選項"
})

---------------
-- Mythrax the Unraveler --
---------------
--L= DBM:GetModLocalization(2194)

---------------------------
-- Zul --
---------------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerCallofCrawgCD		= "下一次粉碎者鮮血池(%s)",
	timerCallofHexerCD 		= "下一次血咒師鮮血池(%s)",
	timerCallofCrusherCD	= "下一次克洛格鮮血池(%s)",
	timerAddIncoming		= DBM_CORE_L.INCOMING
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "為粉碎者鮮血池開始成形顯示計時器",
	timerCallofHexerCD 		= "為血咒師鮮血池開始成形顯示計時器",
	timerCallofCrusherCD	= "為克洛格鮮血池開始成形顯示計時器",
	timerAddIncoming		= "為小怪可被攻擊時顯示計時器",
	TauntBehavior			= "設置換坦的嘲諷模式",
	TwoHardThreeEasy		= "在英雄/傳奇下兩層換坦，其他難度三層換坦",--Default
	TwoAlways				= "無論任何難度都兩層換坦",
	ThreeAlways				= "無論任何難度都三層換坦"
})

L:SetMiscLocalization({
	Crusher			=	"納茲曼粉碎者",
	Bloodhexer		=	"納茲曼血咒師",
	Crawg			=	"嗜血克洛格"
})

------------------
-- G'huun --
------------------
L= DBM:GetModLocalization(2147)

L:SetWarningLocalization({
	warnMatrixFail		= "能量矩陣掉落"
})

L:SetOptionLocalization({
	warnMatrixFail		= "當能量矩陣掉落顯示警告"
})

L:SetMiscLocalization({
	CurrentMatrix		=	"目前矩陣:",--Mythic
	NextMatrix			=	"下次矩陣:",--Mythic
	CurrentMatrixLong	=	"目前矩陣(%s):",--Non Mythic
	NextMatrixLong		=	"下次矩陣(%s):"--Non Mythic
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"奧迪爾小怪"
})
