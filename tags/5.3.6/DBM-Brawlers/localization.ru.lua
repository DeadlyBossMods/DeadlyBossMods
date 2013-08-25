if GetLocale() ~= "ruRU" then return end

local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: Общее"
})

L:SetWarningLocalization({
	warnQueuePosition	= "Ваша позиция в очереди: %d",
	specWarnYourNext	= "Вы следующие!",
	specWarnYourTurn	= "Ваш выход!"
})

L:SetOptionLocalization({
	warnQueuePosition	= "Показывать вашу текущию позицию в очереди",
	specWarnYourNext	= "Спец-предупреждение, когда подходит ваша очередь сражаться",
	specWarnYourTurn	= "Спец-предупреждение о начале вашего боя",
	SpectatorMode		= "Отображать предупреждения/таймеры во время просмотра боев\n(Персональные 'спец-предупреждения' зрителям не отображаются)",
	SpeakOutQueue		= "Объявлять голосом вашу текущую позицию в очереди"
})

L:SetMiscLocalization({
	Bizmo			= "Бизмо",--Альянс
	Bazzelflange	= "Босси Кософланж",--Орда
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "1-го ранга",
	Rank2			= "2-го ранга",
	Rank3			= "3-го ранга",
	Rank4			= "4-го ранга",
	Rank5			= "5-го ранга",
	Rank6			= "6-го ранга",
	Rank7			= "7-го ранга",
	Rank8			= "8-го ранга",
	Rank9			= "9-го ранга",
	Rank10			= "10-го ранга",
	Proboskus		= "Ух ты!... Мне тебя жаль, но, похоже, тебе придется сразиться с Носатиком.",--Альянс
	Proboskus2		= "Ha ha ha! What bad luck you have! It's Proboskus! Ahhh ha ha ha! I've got twenty five gold that says you die in the fire!"--Орда
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: 1 ранг"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: 2 ранг"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: 3 ранг"
})

L:SetOptionLocalization({
	SetIconOnBlat	= "Устанавливать метку (череп) на настоящего Блэт"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: 4 ранг"
})

L:SetOptionLocalization({
	SetIconOnDominika	= "Устанавливать метку (череп) на настоящую Доминику Иллюзионистку"
})

------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: 5 ранг"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: 6 ранг"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: 7 ранг"
})

------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: 8 ранг"
})

------------
-- Rank 9 --
------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: 9 ранг"
})

-------------
-- Rares 1 --
-------------
L= DBM:GetModLocalization("BrawlRare1")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: Вызовы 1"
})

L:SetOptionLocalization({
	ArrowOnBoxing	= "Показывать стрелку DBM во время $spell:140868, $spell:140862 и $spell:140886"
})

-------------
-- Rares 2 --
-------------
L= DBM:GetModLocalization("BrawlRare2")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: Вызовы 2"
})

L:SetWarningLocalization({
	specWarnRPS			= "Используйте %s!"
})

L:SetOptionLocalization({
	specWarnRPS			= "Спец-предупреждение что использовать для $spell:141206",
	SpeakOutStrikes		= "Отсчитывать количество атак $spell:141190"
})

L:SetMiscLocalization({
	rock			= "Камень",
	paper			= "Бумага",
	scissors		= "Ножницы"
})
