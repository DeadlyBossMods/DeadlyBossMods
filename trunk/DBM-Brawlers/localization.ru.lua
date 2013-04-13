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
	specWarnYourTurn	= "Ваш выход!"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "Спец-предупреждение о начале вашего боя",
	SpectatorMode		= "Отображать предупреждения/таймеры во время просмотра боев\n(Персональные 'спец-предупреждения' зрителям не отображаются)"
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
	name = "Бойцовская гильдия: Редкие 1"
})

-------------
-- Rares 2 --
-------------
L= DBM:GetModLocalization("BrawlRare2")

L:SetGeneralLocalization({
	name = "Бойцовская гильдия: Редкие 2"
})