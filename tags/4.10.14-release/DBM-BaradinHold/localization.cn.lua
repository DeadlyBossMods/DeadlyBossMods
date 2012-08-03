-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 2/25/2012

if GetLocale() ~= "zhCN" then return end

local L

----------------
--  Argaloth  --
----------------
L= DBM:GetModLocalization(139)

L:SetOptionLocalization({
	SetIconOnConsuming		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88954)
})

-----------------
--  Occu'thar  --
-----------------
L= DBM:GetModLocalization(140)

----------------------------------
--  Alizabal, Mistress of Hate  --
----------------------------------
L= DBM:GetModLocalization(339)

L:SetTimerLocalization({
	TimerFirstSpecial		= "第一次特殊技能"
})

L:SetOptionLocalization({
	TimerFirstSpecial		= "计时条：$spell:105738后的第一次特殊技能\n（第一次特殊技能是随机的，$spell:105067或$spell:104936）"
})

L:SetMiscLocalization({
})