package.path = package.path .. ";./CLI/?.lua;./Shared/?.lua"

-- No-op on CLI
DBM = {}
DBM.Test = {}
function DBM.Test.CreateSharedModule(name) return {} end
