if GetLocale() ~= "ruRU" then return end

local L

------------
--  Omen  --
------------
L = DBM:GetModLocalization("Omen")

L:SetGeneralLocalization({
	name = "Омен"
})

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("d288")

L:SetTimerLocalization{
	HummelActive		= "Хаммел вступает в бой",
	BaxterActive		= "Бакстер вступает в бой",
	FryeActive			= "Фрай вступает в бой"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Отсчет времени до вступления Троих аптекарей в бой"
})

L:SetMiscLocalization({
	SayCombatStart		= "Тебе хоть сказали, кто я и чем занимаюсь?"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Ахун появился",
	specWarnAttack	= "Ахун уязвим - атакуйте сейчас!"
})

L:SetTimerLocalization{
	SubmergeTimer	= "Исчезновение",
	EmergeTimer		= "Появление"
}

L:SetOptionLocalization({
	Emerged			= "Предупреждение, когда Ахун появляется",
	specWarnAttack	= "Спецпредупреждение, когда Ахун становится уязвим",
	SubmergeTimer	= "Отсчет времени до исчезновения",
	EmergeTimer		= "Отсчет времени до появления"
})

L:SetMiscLocalization({
	Pull			= "Камень Льда растаял!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "Избавьтесь от варева, прежде чем она бросит вам другое!",
	specWarnBrewStun	= "СОВЕТ: Вы получили удар, не забудьте выпить варево в следующий раз!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Спецпредупреждение для $spell:47376",
	specWarnBrewStun	= "Спецпредупреждение для $spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "Бочка на мне!"
})

----------------
--  Brewfest  --
----------------
L = DBM:GetModLocalization("Brew")

L:SetGeneralLocalization({
	name = "Хмельной фестиваль"
})

L:SetOptionLocalization({
	NormalizeVolume			= "Автоматически нормализуйте громкость звукового канала DIALOG, чтобы она соответствовала громкости музыкального звукового канала в зоне Хмельного фестиваля, чтобы он не был таким раздражающе громким.<br/>Если громкость звука музыки не установлена, то громкость будет отключена."
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Фаза %d",
	warnHorsemanSoldiers	= "Призыв Пульсирующих тыкв",
	warnHorsemanHead		= "Появилась голова всадника!"
})

L:SetOptionLocalization({
	WarnPhase				= "Предупреждение о смене фаз",
	warnHorsemanSoldiers	= "Предупреждать о призыве Пульсирующих тыкв",
	warnHorsemanHead		= "Спецпредупреждение о появлении головы всадника"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Всадник встает…",
	HorsemanSoldiers		= "Восстаньте слуги, устремитесь в бой! Пусть павший рыцарь обретет покой!"
})

------------------------------
--  The Abominable Greench  --
------------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "Омерзительный Гринч"
})

--------------------------
--  Plants Vs. Zombies  --
--------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "Растения против зомби"
})

L:SetWarningLocalization({
	warnTotalAdds	= "Всего появилось зомби с прошлой большой волны: %d",
	specWarnWave	= "Большая волна!"
})

L:SetTimerLocalization{
	timerWave		= "След. большая волна"
}

L:SetOptionLocalization({
	warnTotalAdds	= "Объявлять общее число появившихся аддов между каждой большой волной",
	specWarnWave	= "Спецпредупреждение, когда начинается большая волна",
	timerWave		= "Отсчет времени до следующей большой волны"
})

L:SetMiscLocalization({
	MassiveWave		= "Приближается большая волна зомби!"
})

--------------------------
--  Memories of Azeroth: Burning Crusade  --
--------------------------
L = DBM:GetModLocalization("BCEvent")

L:SetGeneralLocalization({
	name = "MoA: Burning Crusade"
})

--------------------------
--  Memories of Azeroth: Wrath of the Lich King  --
--------------------------
L = DBM:GetModLocalization("WrathEvent")

L:SetGeneralLocalization({
	name = "MoA: WotLK"
})

L:SetWarningLocalization{
	WarnEmerge				= "Ануб'арак появляется",
	WarnEmergeSoon			= "Появится в течение 10 секунд",
	WarnSubmerge			= "Ануб'арак закапывается",
	WarnSubmergeSoon		= "Закопается в течение 10 секунд",
	WarningTeleportNow		= "Телепортирован",
	WarningTeleportSoon		= "Телепортация в течение 10 секунд"
}

L:SetTimerLocalization{
	TimerEmerge				= "Появление",
	TimerSubmerge			= "Закапывание",
	TimerTeleport			= "Телепортация"
}

L:SetMiscLocalization{
	Emerge					= "вылезает на поверхность!",
	Burrow					= "зарывается в землю!"
}

L:SetOptionLocalization{
	WarnEmerge				= "Показать предупреждение о появлении",
	WarnEmergeSoon			= "Показать предварительное предупреждение о появлении",
	WarnSubmerge			= "Показать предупреждение о закапывании",
	WarnSubmergeSoon		= "Показать предварительное предупреждение о закапывании",
	TimerEmerge				= "Показать таймер для появления",
	TimerSubmerge			= "Показать таймер для закапывания",
	WarningTeleportNow		= "Показать предупреждение для телепортации",
	WarningTeleportSoon		= "Показать предварительное предупреждение для телепортации",
	TimerTeleport			= "Показать таймер для телепортации"
}

--------------------------
--  Memories of Azeroth: Cataclysm  --
--------------------------
L = DBM:GetModLocalization("CataEvent")

L:SetGeneralLocalization({
	name = "MoA: Cataclysm"
})

L:SetWarningLocalization({
	warnSplittingBlow		= "%s в %s",--Spellname in Location
	warnEngulfingFlame		= "%s в %s"--Spellname in Location
})

L:SetOptionLocalization({
	warnSplittingBlow			= "Показать предупреждения о местоположении для $spell:98951",
	warnEngulfingFlame			= "Показать предупреждения о местоположении для $spell:99171"
})

----------------------------------
--  Azeroth Event World Bosses  --
----------------------------------

-- Lord Kazzak (Badlands)
L = DBM:GetModLocalization("KazzakClassic")

L:SetGeneralLocalization{
	name = "Владыка Каззак"
}

L:SetMiscLocalization({
	Pull		= "За Легион! За Кил'Джедена!"
})

-- Azuregos (Azshara)
L = DBM:GetModLocalization("Azuregos")

L:SetGeneralLocalization{
	name = "Азурегос"
}

L:SetMiscLocalization({
	Pull		= "Это место под моей защитой. Тайны тайных останутся неприкосновенными."
})

-- Taerar (Ashenvale)
L = DBM:GetModLocalization("Taerar")

L:SetGeneralLocalization{
	name = "Таэрар"
}

L:SetMiscLocalization({
	Pull		= "Мир - всего лишь мимолетный сон! Пусть царит КОШМАР!"
})

-- Ysondre (Feralas)
L = DBM:GetModLocalization("Ysondre")

L:SetGeneralLocalization{
	name = "Исондра"
}

L:SetMiscLocalization({
	Pull		= "Нити ЖИЗНИ были разорваны! Мечтатели должны быть отомщены!"
})

-- Lethon (Hinterlands)
L = DBM:GetModLocalization("Lethon")

L:SetGeneralLocalization{
	name = "Летон"
}

L:SetMiscLocalization({
--	Pull		= "The strands of LIFE have been severed! The Dreamers must be avenged!"--Does not have one :\
})

-- Emeriss (Duskwood)
L = DBM:GetModLocalization("Emeriss")

L:SetGeneralLocalization{
	name = "Эмерисс"
}

L:SetMiscLocalization({
	Pull		= "Надежда - это БОЛЕЗНЬ души! Эта земля засохнет и умрет!"
})

-- Doomwalker (Tanaris)
L = DBM:GetModLocalization("DoomwalkerEvent")

L:SetGeneralLocalization{
	name = "Предвестник Рока (событие)"
}
