package.path = package.path .. ";./CLI/?.lua;./Shared/?.lua"

-- No-op/pass-through on CLI
DBM = {}
DBM.Test = {}
---@source ../WoW/Environment.lua:15
function DBM.Test.CreateSharedModule(name, obj) return obj or {} end
