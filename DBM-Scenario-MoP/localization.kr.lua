if GetLocale() ~= "koKR" then return end
local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "테라모어의 몰락"
}

L:SetMiscLocalization{
	AllianceVictory = "진심으로 감사드려요. 집중의 눈동자를 제거했으니, 이 폭탄은 이제 가로쉬의 잔인성을 보여주는 증거, 그 이상은 아니에요. 변화의 바람이 불고 있어요. 아제로스는 전쟁의 문턱에 있고요. 죄송하지만 가야겠군요... 생각할 게 많거든요. 그럼, 안녕히.",
	HordeVictory	= "감사합니다! 이제 이 우울한 섬에서 나가 볼까요?"
}