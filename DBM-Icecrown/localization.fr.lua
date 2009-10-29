if GetLocale() ~= "frFR" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "Lord Marrowgar"
})

L:SetWarningLocalization({
	warnImpale				= ">%s< est empalé(e)",
	specWarnWhirlwind		= "Whirlwind - Courez",
	specWarnColdflame		= "Coldflame - Bougez"
})

L:SetOptionLocalization({
	warnImpale				= "Montre une alerte for Impale target",
	specWarnWhirlwind		= "Montre une alerte spéciale for Whirlwind",
	specWarnColdflame		= "Montre une alerte spéciale lorsque vous subissez des dégâts de Coldflame",
	PlaySoundOnWhirlwind	= "Joue un son pour Whirlwind"
})


-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "Festergut"
})
L:SetWarningLocalization({
})
L:SetOptionLocalization({
})


---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization({
	name = "Rotface"
})
L:SetWarningLocalization({
	SpecWarnStickyOoze	= "Ooze - Bougez"
})
L:SetOptionLocalization({
	SpecWarnStickyOoze	= "Montre une alerte spéciale for Sticky Ooze"
})
L:SetMiscLocalization({
	YellSlimePipes		= "Good news, everyone! I've fixed the poison slime pipes!"	-- Professor Putricide
})


----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization({
	name = "Gunship Battle"
})
L:SetWarningLocalization({
})
L:SetOptionLocalization({
})





