local module = {}

local RS = game:GetService("ReplicatedStorage")
local src = RS[".cealshell"].src
local PlayerState = require(src.PlayerState.PlayerStateServer)

type Methods = "SetInDict" | "RemoveFromDict" | "SetPath"

local function updateInventory(plr, method: Methods, item, data)
	local ok, err = pcall(function()
		PlayerState[method](plr, `inventory.index.{item.key}`, data)
		PlayerState[method](plr, `inventory.type.{item.type}.{item.key}`, data)
		PlayerState[method](plr, `inventory.rarity.{item.display.rarity}.{item.key}`, data)
	end)

	if not ok then
		warn(`[Inventory] Error updating inventory: {err}`)
	end

	return ok
end

local function clean(plr, key)
	local item = PlayerState.GetPath(plr, `inventory.index.{key}`)
	if not item then return end
	updateInventory(plr, "SetPath", item, nil)
end

function module.add(plr, itemData)
	local path = string.format("inventory.index.%s", itemData.key)
	local data = PlayerState.GetPath(plr, path)
	if data then
		warn("Item already exists")
		return
	end
	return updateInventory(plr, "SetPath", itemData, itemData)
end

function module.remove(plr, key)
	clean(plr, key)
end

function module.decrease(plr, key, amount)
	local path = string.format("inventory.index.%s", key)
	local itemData = PlayerState.GetPath(plr, path)
	if not itemData then return end

	if itemData.amount - amount <= 0 then
		clean(plr, key)
		return
	end

	PlayerState.Decrement(plr, `{path}.amount`, amount)
end

return module
