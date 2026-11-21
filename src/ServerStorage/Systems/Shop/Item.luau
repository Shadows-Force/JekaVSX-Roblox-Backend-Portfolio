local module = {}

local RS = game:GetService("ReplicatedStorage")
local src = RS[".cealshell"].src

local ItemInfo = RS.Shared.Systems.Item.Data
local economy = require(script.Parent.Parent.Economy)
local inventory = require(script.Parent.Parent.Inventory)
local Item = require(RS.Shared.Systems.Item)

local priceMultiplier = {}

function module.setPriceMultiplier(itemId, multiplier)
	priceMultiplier[itemId] = multiplier
end

local function getItemPrice(itemId: string)
	if not ItemInfo[itemId] then
		return false
	end
	local data = require(ItemInfo[itemId])
	return data.price
end

function module.buy(plr, itemId)
	local itemPrices = getItemPrice(itemId)
	if not itemPrices then warn("Item price not found") return false end

	local itemData = Item.new(itemId, "lite")
	if not itemData then warn("Item data not found") return false end

	local multi = priceMultiplier[itemId] or 1	

	local ok = economy.update(plr, "Decrement", itemPrices.economy, multi)
	if not ok then warn("err in decrement") return false end

	local success = inventory.add(plr, itemData)
	if not success then warn("err in inventory.add") economy.update(plr, "Increment", itemPrices.economy, multi) return false end
	
	return true
end

return module
