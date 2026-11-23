local module = {}
local RS = game:GetService("ReplicatedStorage")
local src = RS[".cealshell"].src

local HttpService = game:GetService("HttpService")
local Cryptography = require(src.cryptography)

local hashing = Cryptography.Hashing

type mode = "complete" | "lite"

local function SortTable(original)
	local sorted = {}
	local keys = {}

	-- Recolectamos las claves
	for key in pairs(original) do
		table.insert(keys, key)
	end

	-- Las ordenamos alfabéticamente
	table.sort(keys, function(a, b)
		return tostring(a) < tostring(b)
	end)

	-- Creamos la nueva tabla insertando en orden
	for _, key in ipairs(keys) do
		sorted[key] = type(original[key]) ~= "table" and original[key] or SortTable(original[key])
	end

	return sorted
end

local function getItemMethods(item: string)
	local ok, meth = pcall(function()
		return require(script.Methods[item])
	end)
	
	if not ok then
		return false
	end
	
	return meth
end

local function getItemData(item: string)
	local ok, data = pcall(function()
		local data = require(script.Data[item])
		return data
	end)
	
	if not ok then
		return false
	end
	
	return data
end

local function validateData(custom, default)
	if not custom or not default then
		return false
	end
	
	for key, value in pairs(default) do
		if type(value) == "table" then
			if not validateData(custom[key], value) then
				return false
			end
		end
		
		if custom[key] == nil then
			return false
		end
	end
	
	return true
end

local function generateIdentity(data)
	if data.config.isMutable then
		return HttpService:GenerateGUID(false)
	end
	
	return hashing.SHA2.SHA256(HttpService:JSONEncode(SortTable(data)))
end

function module:equip()
	print("default equip")
end

function module:unequip()
	print("default unequip")
end

function module:use()
	print("default use")
end

function module.new(item: string, mode: mode, data: {[string]: any}?, id: string?, amount: number?)
	local defaultData = getItemData(item)
	
	if not defaultData then warn("Item data not found") return false end
	
	if not validateData(data, defaultData) or not validateData(defaultData, data) then
		data = defaultData
	end
	
	local methods = getItemMethods(item)
	
	if not methods then warn("methods not found") return false end
	
	local self = mode == "lite" and data or setmetatable(data, {__index = function(_, key)
		return methods[key] or module[key]
	end,})
	
	self.key = id or generateIdentity(data)
	self.amount = data.config.isMutable and 1 or amount or 1
	
	return self
end

return module
