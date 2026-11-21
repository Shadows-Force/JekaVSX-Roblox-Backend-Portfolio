local module = {}

local RS = game:GetService("ReplicatedStorage")
local src = RS[".cealshell"].src

local PlayerState = require(src.PlayerState.PlayerStateServer)

type methods = "SetPath" | "Increment" | "Decrement"

local function auxUpdate(plr, method: methods, currencies: {[string]: number}, multi: number)
	multi = multi or 1
	for currency, value in currencies do
		if not value or value < 0 then return end
		local money = PlayerState.GetPath(plr, `economy.{currency}`)
		if not money then return end
		if method == "Decrement" and (money - (value * multi)) < 0 then return end
	end
	
	for currency, value in currencies do
		PlayerState[method](plr, `economy.{currency}`, value * (multi))
	end
	
	return true
end

function module.update(plr: Player, method: methods, currencies: {[string]: number}, multi: number)
	return auxUpdate(plr, method, currencies, multi)
end

return module
