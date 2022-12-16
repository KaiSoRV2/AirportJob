ESX = nil

 TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
 TriggerEvent('esx_society:registerSociety', 'airport', 'airport', 'society_airport', 'society_airport', 'society_airport', {type = 'private'})
   
------------------------[ CONFIG ANNONCES F6 ]------------------------ 

RegisterServerEvent('AnnonceOuverture:airport')
AddEventHandler('AnnonceOuverture:airport', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Los Santos Airport', '~r~Annonce', 'Los Santos Airport est maintenant ~HUD_COLOUR_BLUELIGHT~ouvert !', 'CHAR_PROPERTY_BAR_AIRPORT', 8) --> Modif Char pour le logo entreprise
	end
end)

RegisterServerEvent('AnnonceFermeture:airport')
AddEventHandler('AnnonceFermeture:airport', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Los Santos Airport', '~r~Annonce', 'Los Santos Airport ferme ses portes pour ~r~aujourd\'hui~s~ !', 'CHAR_PROPERTY_BAR_AIRPORT', 8)
	end
end)

RegisterServerEvent('AnnonceRecrutement:airport')
AddEventHandler('AnnonceRecrutement:airport', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Los Santos Airport', '~r~Annonce', '~s~Recrutement en cours, rendez-vous au Los Santos Airport', 'CHAR_PROPERTY_BAR_AIRPORT', 8)
	end
end)

------------------------[ CONFIG COFFRE ]------------------------ 

ESX.RegisterServerCallback('airport:playerinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local all_items = {}
	
	for k,v in pairs(items) do
		if v.count > 0 then
			table.insert(all_items, {label = v.label, item = v.name,nb = v.count})
		end
	end

	cb(all_items)

	
end)

ESX.RegisterServerCallback('airport:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_airport', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
			end
		end

	end)
	cb(all_items)
end)

ESX.RegisterServerCallback('airport:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_airport', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
			end
		end

	end)
	cb(all_items)
end)

RegisterServerEvent('airport:putStockItems')
AddEventHandler('airport:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_airport', function(inventory)
		if item_in_inventory >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~g~Dépot\n~s~- ~HUD_COLOUR_BLUELIGHT~Coffre : ~s~Los Santos Airport \n~s~- ~o~Quantitée ~s~: "..count.."")
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n'en avez pas assez sur vous")
		end
	end)
end)

RegisterServerEvent('airport:takeStockItems')
AddEventHandler('airport:takeStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_airport', function(inventory)
			xPlayer.addInventoryItem(itemName, count)
			inventory.removeItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~r~Retrait\n~s~- ~HUD_COLOUR_BLUELIGHT~Coffre : ~s~Los Santos Airport \n~s~- ~o~Quantitée ~s~: "..count.."")
	end)
end)

--------------------- [ CONFIG MISSION ] ---------------------



ESX.RegisterServerCallback('airport:PriceColis', function(source, cb)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_airport', function(account)
		societyAccount = account
	end)
	
	if societyAccount.money >= 5000 then 
		cb(true)
	else 
		cb(false)
	end 
end)


RegisterServerEvent('airport:PayeColis')
AddEventHandler('airport:PayeColis', function(itemName, count)
	price = 5000
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_airport', function(account)
		societyAccount = account
	end)
	societyAccount.removeMoney(price)
end)


RegisterServerEvent('airport:livraisoncolis')
AddEventHandler('airport:livraisoncolis', function(itemName, count)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_airport', function(inventory)
		inventory.addItem(itemName, count)
	end)
end)


ESX.RegisterServerCallback('airport:mini40colis', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local result = xPlayer.getInventoryItem('colis').count
	if result >= 40 then 
		cb(true)
	else 
	 	cb(false)
	end
end)
 
RegisterServerEvent('airport:ventecolishydravionmission')
AddEventHandler('airport:ventecolishydravionmission', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local result = xPlayer.getInventoryItem(item).count
	if result >= 40 then
		xPlayer.removeInventoryItem(item, 40)
		TriggerClientEvent("esx:showNotification", source, "Retourner l'avion a l'aéroport pour toucher votre argent !")
	else 
		TriggerClientEvent("esx:showNotification", source, "Tu as dû faire tomber un colis durant le vol ? Il n'y a pas le compte !")
	
	end 
end)

ESX.RegisterServerCallback('airport:CompteurHydravion', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local result = xPlayer.getInventoryItem('colis').count
	if result >= 40 then
		cb(true)
	else 
		cb(false)
	end 
end)


RegisterServerEvent('airport:retourhydravionmission')
AddEventHandler('airport:retourhydravionmission', function(item)
	local price = 16000
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_airport', function(account)
	societyAccount = account
	end)
	societyAccount.addMoney(price)
	TriggerClientEvent("esx:showNotification", source, "Votre entreprise a gagné ~HUD_COLOUR_BLUELIGHT~"..price.."$ !")
end)


RegisterServerEvent('airport:retourSAmission')
AddEventHandler('airport:retourSAmission', function()
	local price = 25000
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_airport', function(account)
	societyAccount = account
	end)
	societyAccount.addMoney(price)
	TriggerClientEvent("esx:showNotification", source, "Votre entreprise a gagné ~HUD_COLOUR_BLUELIGHT~"..price.."$ !")
end)

RegisterServerEvent('airport:retourCayomission')
AddEventHandler('airport:retourCayomission', function()
	local price = 50000
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_airport', function(account)
	societyAccount = account
	end)
	societyAccount.addMoney(price)
	TriggerClientEvent("esx:showNotification", source, "Votre entreprise a gagné ~HUD_COLOUR_BLUELIGHT~"..price.."$ !")
end)