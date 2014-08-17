local skin = DBT:RegisterSkin("DefaultSkin")

-- DBT templates work by providing a set of DBT options which control the look and feel of the status bars. The DBM 5.0 skinning system consists of two parts:
-- 1) This API to define sets of options and load new textures/fonts
-- 2) The new DBT option "Template", which controls the XML template that is used for all DBT bars

-- You can override any of the DBT options (see DBT.lua) here; these options will be set to this value when the skin is selected.
-- Options that are not set here will be reset to their default value (as defined in DBT.lua) when the skin is selected (except for the positioning options).
skin.defaults = {
	-- Most skins want to set the "Template" option which sets the XML template to use (note that you could also create a template which doesn't have a custom template, just custom other settings)
	Template = "DBMDefaultSkinTimerTemplate",
	-- Most skins probably also want this option: the default texture (the user can still change this to any other texture from any DBT skin or LibSharedMedia)
	Texture = "Interface\\AddOns\\DBM-DefaultSkin\\textures\\default.tga",
}

