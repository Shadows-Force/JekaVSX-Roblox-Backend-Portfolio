
local module = {}

local RS = game:GetService("ReplicatedStorage")
local src = RS[".cealshell"].src

local PlayerState = require(src.PlayerState.PlayerStateServer)

type Currencies = {[string]: number}

local function validate(plr, currencies: Currencies, n: number)
	n = n or 1
	assert(n >= 0, "Invalid multiplier")

	for currency, value in currencies do
		assert(value >= 0, `Invalid value for currency: {currency}`)

		local money = PlayerState.GetPath(plr, `economy.{currency}`)
		assert(money ~= nil, `Money not found for currency: {currency}`)
		
		if method ~= "Decrement" then
			continue
		end
		
		if money < value * n then warn("Can't afford") return false end
	end
	
	return true
end

function module.Set(plr, currencies: Currencies, n: number?)

	if not validate(plr, currencies, n) then return false end

	local ops = {}

	for currency, value in currencies do
		table.insert(ops, {
			path = `economy.{currency}`,
			value = value * n
		})
	end

	return PlayerState.BatchSetValues(plr, ops)
end

function module.Increment(plr, currencies: Currencies, n: number?)

	if not validate(plr, currencies, n) then return false end

	local ops = {}

	for currency, value in currencies do
		table.insert(ops, {
			path = `economy.{currency}`,
			operation = "Increment",
			amount = value * n
		})
	end

	return PlayerState.BatchUpdateValues(plr, ops)
end

function module.Decrement(plr, currencies: Currencies, n: number?)
	
	if not validate(plr, currencies, n) then return false end

	local ops = {}

	for currency, value in currencies do
		table.insert(ops, {
			path = `economy.{currency}`,
			operation = "Decrement",
			amount = value * n
		})
	end

	return PlayerState.BatchUpdateValues(plr, ops)
end

return module
