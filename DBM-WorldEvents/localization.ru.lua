if GetLocale() ~= "ruRU" then return end

local L

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Корен Худовар"
})

L:SetWarningLocalization({
	specWarnBrew		= "Избавьтесь от варева прежде, чем она бросит вам другое!",
	specWarnBrewStun	= "СОВЕТ: Вы получили удар, не забудьте выпить варево в следующий раз!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Спец-предупреждение для Пива темной официантки",
	specWarnBrewStun	= "Спец-предупреждение для Оглушения темным пивом официантки",
	YellOnBarrel		= "Крикнуть, когда на вас Бочка"
})

L:SetMiscLocalization({
	YellBarrel	= "Бочка на мне!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Всадник без головы"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers	= "Призыв Пульсирующих тыкв",
	specWarnHorsemanHead	= "Вихрь - переключитесь на голову"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers	= "Предупреждать о призыве Пульсирующих тыкв",
	specWarnHorsemanHead	= "Спец-предупреждение для Вихря (призыв 2ой и следующей головы)"
})

L:SetMiscLocalization({
	HorsemanHead		= "Не надоело еще убегать?",
	HorsemanSoldiers	= "Восстаньте слуги, устремитесь в бой! Пусть павший рыцарь обретет покой!",
	SayCombatEnd		= "Со смертью мы давно уже друзья...Что ждет теперь на пустоши меня?"
})

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name = "Трое аптекарей"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization{
	HummelActive	= "Хаммел вступает в бой",
	BaxterActive	= "Бакстер вступает в бой",
	FryeActive		= "Фрай вступает в бой"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Отсчет времени до вступления Троих аптекарей в бой"
})

L:SetMiscLocalization({
	SayCombatStart		= "Тебе хоть сказали, кто я и чем занимаюсь?"
})

-----------------------
--  Lord Ahune  --
-----------------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	name = "Lord Ahune"
})

L:SetWarningLocalization({
	Submerged		= "Ahune has submerged",
	Emerged			= "Ahune has emerged",
	specWarnAttack	= "Ahune is vulnerable - Attack now!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Submerge",
	EmergeTimer		= "Emerge",
	TimerCombat		= "Combat starts"
}

L:SetOptionLocalization({
	Submerged		= "Show warning when Ahune submerges",
	Emerged			= "Show warning when Ahune emerges",
	specWarnAttack	= "Show special warning when Ahune becomes vulnerable",
	SubmergTimer	= "Show timer for submerge",
	EmergeTimer		= "Show timer for emerge",
	TimerCombat		= "Show timer for start of combat",
})

L:SetMiscLocalization({
	Pull			= "Камень Льда растаял!"
})