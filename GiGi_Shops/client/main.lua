  ESX = nil
  local PlayerData = {}

  Citizen.CreateThread(function()
	  while ESX == nil do
		  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		  Citizen.Wait(0)
		  PlayerData = ESX.GetPlayerData()
	   end
   end)

  function hintToDisplay(text)
	  SetTextComponentFormat("STRING")
	  AddTextComponentString(text)
   end

  local GiGiShops = {
	  { x = 2557.46,  y = 382.41,  z = 108.00},
	  { x = 373.875,   y = 325.896,  z = 102.90},
	  { x = -3038.97, y = 586.01,  z = 7.30},
	  { x = -3241.927, y = 1001.462, z = 12.30},
	  { x =  547.431,   y = 2671.710, z = 41.50},
	  { x = 1961.464,  y = 3740.672, z = 31.50},
	  { x = 2678.916,  y = 3280.671, z = 54.50},
	  {x = 1729.216,  y = 6414.131, z = 34.40},
	  {x = -48.519,   y = -1757.514, z = 28.80},
	  {x = 1163.373,  y = -323.801,  z = 68.50},
	  {x = -707.501,  y = -914.260,  z = 18.50},
	  {x = -1820.523, y = 792.518,   z = 137.40},
	  {x = 1698.388,  y = 4924.404,  z = 41.30},
	}

  Citizen.CreateThread(function()
	  while true do
		  Citizen.Wait(0)
		  for index, value in pairs(GiGiShops) do
			  local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			  local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, value.x, value.y, value.z)
			  if dist < 7.5 then
				  DrawText3Ds(value.x, value.y, value.z + 1.0, '[~g~E~s~] Minimercado')
				  if dist <= 1.0 then
					  if IsControlJustPressed(0,38) then
						  OpenShopMenu()
					  end
				  end
			  end
		  end
	  end
  end)

  function OpenShopMenu()
	  ESX.UI.Menu.CloseAll()

	  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'GiGi_Shops',
		  {
			  title    = 'Bem Vindo a GiGi_Shop',
			  align    = 'top-right',
			  elements = {
				  {label = 'Pao (5$)', value = 'water_1', item = 'bread', price = 5},
				  {label = 'Agua (10$)', value = 'water_1', item = 'water', price = 10},
			}
		  },
		  function(data, menu)
			  local item = data.current.item
			  local price = data.current.price
			  ESX.UI.Menu.CloseAll()
			  TriggerServerEvent('GiGi_Shops:buy', item, price)
		  end,
	  function(data, menu)
		  menu.close()
	  end)
  end

  --Blips
  local blips = {
	  {title="Minimercado", colour=69, id=78, x = 2557.458,  y = 382.282,  z = 107.622},
	  {title="Minimercado", colour=69, id=78, x = 373.875,   y = 325.896,  z = 102.566},
	  {title="Minimercado", colour=69, id=78, x = -3038.939, y = 585.954,  z = 6.908},
	  {title="Minimercado", colour=69, id=78, x = -3241.927, y = 1001.462, z = 11.830},
	  {title="Minimercado", colour=69, id=78, x =  547.431,   y = 2671.710, z = 41.156},
	  {title="Minimercado", colour=69, id=78, x = 1961.464,  y = 3740.672, z = 31.343},
	  {title="Minimercado", colour=69, id=78, x = 2678.916,  y = 3280.671, z = 54.241},
	  {title="Minimercado", colour=69, id=78, x = 1729.216,  y = 6414.131, z = 34.037},
	  {title="Minimercado", colour=69, id=78, x = -48.519,   y = -1757.514, z = 28.421},
	  {title="Minimercado", colour=69, id=78, x = 1163.373,  y = -323.801,  z = 68.205},
	  {title="Minimercado", colour=69, id=78, x = -707.501,  y = -914.260,  z = 18.215},
	  {title="Minimercado", colour=69, id=78, x = -1820.523, y = 792.518,   z = 137.118},
	  {title="Minimercado", colour=69, id=78, x = 1698.388,  y = 4924.404,  z = 41.063}
	}

  Citizen.CreateThread(function()
	  for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.5)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	  end
  end)

  function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(1)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.030, 66, 66, 66, 150)
  end
