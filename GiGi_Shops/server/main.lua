ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('GiGi_Shops:buy')
AddEventHandler('GiGi_Shops:buy', function(item, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if(xPlayer.getMoney() >= price) then
		xPlayer.removeMoney(price)
		xPlayer.addInventoryItem(item, 1)
	end
end)