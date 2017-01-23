if GetLocale() ~= "zhTW" then return end
local L

-----------------------
-- Brawlers --
-----------------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:一般"
})

L:SetWarningLocalization({
	warnQueuePosition	= "你的目前順位為:%d",
	specWarnYourNext	= "你是下一位!",
	specWarnYourTurn	= "輪到你上場了!"
})

L:SetOptionLocalization({
	warnQueuePosition	= "提示你目前的順位",
	specWarnYourNext	= "當你下一個上場時顯示特別警告",
	specWarnYourTurn	= "輪到你上時顯示特別警告",
	SpectatorMode		= "當旁觀戰鬥時顯示警告/計時器<br/>(旁觀者不會顯示個人的特別警告訊息)",
	SpeakOutQueue		= "當順位更新數出你的順位",
	NormalizeVolume		= "在鬥陣俱樂部時自動地標準化對話聲道音量去符合主要聲道音量讓歡呼聲不會太大聲。"
})

L:SetMiscLocalization({
	Bizmo			= "畢茲摩",--Alliance
	Bazzelflange	= "老闆貝索佛蘭吉",--Horde
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "第1階",
	Rank2			= "第2階",
	Rank3			= "第3階",
	Rank4			= "第4階",
	Rank5			= "第5階",
	Rank6			= "第6階",
	Rank7			= "第7階",
	Rank8			= "第8階",
	Rank9			= "第9階",
	Rank10			= "第10階",
	Proboskus		= "嗚，真不妙... 抱歉啦，看來要跟你打的就是普羅伯斯庫!",--Alliance
	Proboskus2		= "哈哈哈!你的運氣真的有夠背的!是普羅伯斯庫!哈哈哈哈，我出二十五金賭你會被火燒死!"--Horde
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第1階"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第2階"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第3階"
})

L:SetOptionLocalization({
	SetIconOnBlat	= "在真正的吞齧怪上設置圖示(骷髏)"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第4階"
})

L:SetOptionLocalization({
	SetIconOnDominika	= "在真正的幻術師多明妮卡上設置圖示(骷髏)"
})


------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第5階"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第6階"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第7階"
})

--[[
------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第8階"
})

------------
-- Rank 9 --
------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第9階"
})
--]]

-------------
-- Brawlers: Legacy --
-------------
L= DBM:GetModLocalization("BrawlLegacy")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:傳統"
})

L:SetOptionLocalization({
	SpeakOutStrikes		= "數出$spell:141190的攻擊次數"
})

-------------
-- Brawlers: Challenges --
-------------
L= DBM:GetModLocalization("BrawlChallenges")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:挑戰"
})

L:SetWarningLocalization({
	specWarnRPS			= "出%s!"
})

L:SetOptionLocalization({
	ArrowOnBoxing		= "為$spell:140868和$spell:140862和$spell:140886顯示DBM箭頭",
	specWarnRPS			= "為$spell:141206該出什麼的時候顯示特別警告"
})

L:SetMiscLocalization({
	rock			= "石頭",
	paper			= "布",
	scissors		= "剪刀"
})

-------------
-- Brawlers: Brumble --
-------------
L= DBM:GetModLocalization("BrawlRumble")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部: Rumble"
})
