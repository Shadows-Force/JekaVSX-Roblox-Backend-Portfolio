
local module = {}

local RS = game:GetService("ReplicatedStorage")
local src = RS[".cealshell"].src
local PlayerState = require(src.PlayerState.PlayerStateServer)

local function getPaths(item)
	local key = item.key

	return {
		index = `inventory.index.{key}`,
		type = `inventory.type.{item.type}.{key}`,
		rarity = `inventory.rarity.{item.display.rarity}.{key}`
	}
end

local function update(plr, paths, value)
	local ops = {}

	for _, path in paths do
		table.insert(ops, {
			path = path,
			value = value
		})
	end

	return PlayerState.BatchSetValues(plr, ops)
end

function module.Add(plr, item)
	local paths = getPaths(item)

	if PlayerState.GetPath(plr, paths.index) then
		return false
	end

	return update(plr, paths, item)
end

function module.Remove(plr, item)
	local paths = getPaths(item)

	if not PlayerState.GetPath(plr, paths.index) then
		return false
	end

	return update(plr, paths, nil)
end

local function validateAmount(plr, item, n)
	n = n or 1
	assert(n >= 0, "Invalid amount")

	local path = `inventory.index.{item.key}.amount`
	local amount = PlayerState.GetPath(plr, path)

	assert(amount ~= nil, "Item not found")

	return path, amount, n
end

function module.Increment(plr, item, n)
	local path, _, n = validateAmount(plr, item, n)

	return PlayerState.Increment(plr, path, n)
end

function module.Decrement(plr, item, n)
	local path, amount, n = validateAmount(plr, item, n)

	if amount < n then
		return false
	end

	return PlayerState.Decrement(plr, path, n)
end

return module
