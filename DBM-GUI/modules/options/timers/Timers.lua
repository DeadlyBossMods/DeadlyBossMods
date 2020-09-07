DBM_GUI.Cat_Timers = DBM_GUI:CreateNewPanel(DBM_GUI_L.TabCategory_Timers, "option")

--if an area doesn't exist on a catagory, then clicking category continues showing previous panel.
--This creates an empty area for time being to at least empty panel out when clicking cat headrers
--TODO, maybe Add Text blocks to each cat explaining how to get most out of each area, maybe add links to github wiki to each
local emptyArea = DBM_GUI.Cat_Timers:CreateArea("")
