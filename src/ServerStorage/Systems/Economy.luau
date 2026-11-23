local module = {}

local RS = game:GetService("ReplicatedStorage")
local src = RS[".cealshell"].src

local PlayerState = require(src.PlayerState.PlayerStateServer)

type Methods = "Increment" | "Decrement" | "SetPath"
type Currencies = {[string]: number}

function module.update(plr, method: Methods, currencies: Currencies, n: number?)
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

	local ops = {}

	if method == "SetPath" then
		for currency, value in currencies do
			table.insert(ops, {path = `economy.{currency}`, value = value * n})
		end
		return PlayerState.BatchSetValues(plr, ops)
	end

	for currency, value in currencies do
		table.insert(ops, {
			path = `economy.{currency}`,
			operation = method,
			amount = value * n
		})
	end
	return PlayerState.BatchUpdateValues(plr, ops)
end

return module
