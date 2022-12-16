ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

------------------------[ Config Variation de Couleur Menu ]------------------------

Citizen.CreateThread(function()
    while true do 
       Citizen.Wait(500)
       if VarColor == "~HUD_COLOUR_BLUELIGHT~" then VarColor = "~s~" else VarColor = "~HUD_COLOUR_BLUELIGHT~" end   -- Si vous voulez changer la couleur toucher uniquement aux "g"
   end 
end)

------------------------[  ]------------------------

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end
 
------------------------[ Config Menu ]------------------------

local openedMenu = false
local mainMenu = RageUI.CreateMenu("", "Los Santos Airport") -- Première "" si vous voulez ajoutez un titre sur la bannière / deuxième "" le nom du menu 
local MenuVehicule = RageUI.CreateSubMenu(mainMenu, "", "MENU") 
local annoncemenu = RageUI.CreateSubMenu(mainMenu, "", "Annonces")

 
mainMenu.X = 0 
mainMenu.Y = 0
 
mainMenu.Closed = function() 
    openedMenu = false 
end 

------------------------[ MENU F6 ]------------------------
 
function menuairport()
    if openedMenu then 
        openedMenu = false 
            RageUI.Visible(mainMenu, false) 
            return 
    else 
        openedMenu = true 
        RageUI.Visible(mainMenu, true)
        Citizen.CreateThread(function()
            while openedMenu do 
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Separator(VarColor.."↓ Options ↓") 
                    RageUI.Button("Faire une Annonces", nil, {RightLabel = "→→"}, true, {},annoncemenu)
                    RageUI.Button("Donner une Facture", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            ESX.UI.Menu.Open(
                                'dialog', GetCurrentResourceName(), 'facture',
                                {
                                    title = 'Montant de la facture'
                                },
                                function(data, menu)
                        
                                    local amount = tonumber(data.value)
                        
                                    if amount == nil or amount <= 0 then
                                        ESX.ShowNotification('Montant invalide')
                                    else
                                        menu.close()
                        
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        
                                        if closestPlayer == -1 or closestDistance > 3.0 then
                                            ESX.ShowNotification('Pas de joueurs proche')
                                        else
                                            local playerPed        = GetPlayerPed(-1)
                        
                                            Citizen.CreateThread(function()
                                                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
                                                Citizen.Wait(5000)
                                                ClearPedTasks(playerPed)
                                                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_airport', 'airport', amount)
                                                ESX.ShowNotification("~r~Vous avez bien envoyé la facture")
                                            end)
                                        end
                                    end
                                end,
                                function(data, menu)
                                    menu.close()
                            end)
                        end
                    })     
                end)

                RageUI.IsVisible(annoncemenu, function()
                    ESX.PlayerData = ESX.GetPlayerData()
                    RageUI.Separator(VarColor.."↓ Annonces ↓")
                        RageUI.Button("Annonce ~g~Ouverture~s~", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
                        onSelected = function()
                            TriggerServerEvent('AnnonceOuverture:airport')
                        end
                       })

                       RageUI.Button("Annonce ~r~Fermeture~s~", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
                        onSelected = function()
                            TriggerServerEvent('AnnonceFermeture:airport')  
                        end
                       })

                       RageUI.Button("Annonce ~y~Recrutement~s~", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
                        onSelected = function()
                            TriggerServerEvent('AnnonceRecrutement:airport') 
                        end
                       })
                end)
  
                Wait(0)
            end
        end)
    end
end
 
------------------------[ MARKERS ]------------------------
 
Keys.Register('F6', 'airport', 'Ouvrir le menu Los Santos Airport', function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
        if IsControlJustPressed(1,167) then
        menuairport()
        end
	end
end)

------------------------[ MENU COFFRE ]------------------------ 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local mainMenu = RageUI.CreateMenu("", "Action :")
local PutMenu = RageUI.CreateSubMenu(mainMenu,"", "Contenue :")
local GetMenu = RageUI.CreateSubMenu(mainMenu,"", "Contenue :")

local open = false

mainMenu:DisplayGlare(false)
mainMenu.Closed = function()
    open = false
end

all_items = {}

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    
    blockinput = true 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "Somme", ExampleText, "", "", "", MaxStringLenght) 
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end 
         
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

    
function Coffreairport() 
    if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Prendre un objet", nil, {RightLabel = "→"}, true, {onSelected = function()
                getStock()
            end},GetMenu);

            RageUI.Button("Déposer un objet", nil, {RightLabel = "→"}, true, {onSelected = function()
                getInventory()
            end},PutMenu);
            

        end)

        RageUI.IsVisible(GetMenu, function()
            
            for k,v in pairs(all_items) do
                RageUI.Button(v.label, nil, {RightLabel = "x"..""..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput("Combien voulez vous en prendre",nil,4)
                    count = tonumber(count)
                    if count <= v.nb then
                        TriggerServerEvent("airport:takeStockItems",v.item, count)
                    else
                        ESX.ShowNotification("~r~Vous n'en avez pas assez sur vous")
                    end
                    getStock()
                end});
            end

        end)

        RageUI.IsVisible(PutMenu, function()
            
            for k,v in pairs(all_items) do
                RageUI.Button(v.label, nil, {RightLabel = "x"..""..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput("Combien voulez vous en déposer",nil,4)
                    count = tonumber(count)
                    TriggerServerEvent("airport:putStockItems",v.item, count)
                    getInventory()
                end});
            end
            

        end)


        Wait(0)
    end
end)
end
end



function getInventory()
    ESX.TriggerServerCallback('airport:playerinventory', function(inventory)               
                
        all_items = inventory
        
    end)
end

function getStock()
    ESX.TriggerServerCallback('airport:getStockItems', function(inventory)               
                
        all_items = inventory
        
    end)
end

Citizen.CreateThread(function()
    while true do
		local wait = 750
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
				for k, v in pairs(Config.Position) do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Coffre.x, v.Coffre.y, v.Coffre.z)

				if dist <= Config.MarkerDistance then
					wait = 0
					DrawMarker(Config.MarkerType, v.Coffre.x, v.Coffre.y, v.Coffre.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, true, p19)  
				end

				if dist <= 1.0 then
					wait = 0
					ESX.ShowHelpNotification(Config.TextCoffre) 
					if IsControlJustPressed(1,51) then
						Coffreairport()
					end
				end
			end
		end
    Citizen.Wait(wait)
    end
end)


------------------------[ MENU GARAGE ]------------------------

function SetVehicleMaxMods(vehicle)

    local props = {
        modEngine       = 3,
        modBrakes       = 2,
        modTransmission = 2,
        modSuspension   = 3,
        modTurbo        = true,
    }
  
    ESX.Game.SetVehicleProperties(vehicle, props)
  
  end



local open = false 
local mainMenu6 = RageUI.CreateMenu('', 'Faites votre choix ?')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function Garageairport()
    if open then 
        open = false
        RageUI.Visible(mainMenu6, false)
        return
    else
        open = true 
        RageUI.Visible(mainMenu6, true)
        CreateThread(function()
        while open do 
            RageUI.IsVisible(mainMenu6,function() 

              RageUI.Separator(VarColor.."↓ Véhicules ↓")

                for k,v in pairs(Config.Vehiculeairport) do
                RageUI.Button(v.buttoname, nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        if not ESX.Game.IsSpawnPointClear(vector3(v.spawnzone.x, v.spawnzone.y, v.spawnzone.z), 10.0) then
                        ESX.ShowNotification("~s~Los Santos Airport\n~r~Point de spawn bloquée")
                        else
                        local model = GetHashKey(v.spawnname)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Wait(10) end
                        SetVehicleMaxMods(vehicle)
                        local ambuveh = CreateVehicle(model, v.spawnzone.x, v.spawnzone.y, v.spawnzone.z, v.headingspawn, true, false)
                        SetVehicleNumberPlateText(ambuveh, "Airport")
                        SetVehicleWindowTint(Vehicle, WINDOWTINT_PURE_BLACK) --> vitre teintée - a modif pour que ça marche
                        SetVehicleFixed(ambuveh)
                        SetVehRadioStation(ambuveh, 0)
                        
                        RageUI.CloseAll()
                        end
                    end
                })


              end
            end)
          Wait(0)
         end
      end)
   end
end

Citizen.CreateThread(function()
    while true do 
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
            for k, v in pairs(Config.Position) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.GarageVehicule.x, v.GarageVehicule.y, v.GarageVehicule.z)
  
                if dist <= Config.MarkerDistance then 
                    wait = 0
                    DrawMarker(Config.MarkerTypeAvion, v.GarageVehicule.x, v.GarageVehicule.y, v.GarageVehicule.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeurGarageAvion, Config.MarkerSizeEpaisseurGarageAvion, Config.MarkerSizeHauteurGarageAvion, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, true, p19)  
                end
  
                if dist <= 2.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.TextGarage) 
                    if IsControlJustPressed(1,51) then
                        Garageairport()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
  end)
 
------------------------[ MENU RANGER - Véhicule ]------------------------

local open = false 
local mainMenuRanger = RageUI.CreateMenu('', 'Faites votre choix ?')
mainMenuRanger.Display.Header = true 
mainMenuRanger.Closed = function()
  open = false
end

function RangerVoiture()
    if open then 
        open = false
        RageUI.Visible(mainMenuRanger, false)
        return
    else
        open = true 
        RageUI.Visible(mainMenuRanger, true)
        CreateThread(function()
        while open do 
            RageUI.IsVisible(mainMenuRanger,function() 


              RageUI.Separator(VarColor.."↓ Options ↓")

              RageUI.Button("Ranger votre véhicule", 'Vous devez ranger uniquement :\n- les véhicules de service de l\'~HUD_COLOUR_BLUELIGHT~Aéroport', {RightLabel = "→→"}, true , {
                onSelected = function()
                    local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                    if dist4 < 1 then
                        DeleteEntity(veh)
                        ESX.ShowNotification('~r~Garage \n~g~- Véhicule rangé !~s~')
                        RageUI.CloseAll()
                    end
                end
             })



              end)
          Wait(0)
         end
      end)
   end
end

Citizen.CreateThread(function()
    while true do 
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
            for k, v in pairs(Config.Position) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.RangerVehicule.x, v.RangerVehicule.y, v.RangerVehicule.z)
  
                if dist <= Config.MarkerDistance then 
                    wait = 0
                    DrawMarker(Config.MarkerType, v.RangerVehicule.x, v.RangerVehicule.y, v.RangerVehicule.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, true, p19)  
                end
  
                if dist <= 2.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.TextRangerGarage) 
                    if IsControlJustPressed(1,51) then
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                            RangerVoiture()
                    else
                        ESX.ShowNotification('Vous devez être dans un ~r~Véhicule !~s~')
                    end
            end
            end
            end
        end
    Citizen.Wait(wait)
    end
  end)


Citizen.CreateThread(function()
    while true do 
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
            for k, v in pairs(Config.Position) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.RangerVehicule2.x, v.RangerVehicule2.y, v.RangerVehicule2.z)
  
                if dist <= 200 then 
                    wait = 0
                    DrawMarker(1, v.RangerVehicule2.x, v.RangerVehicule2.y, v.RangerVehicule2.z-1, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 5.5, 5.5, 0.75, 255, 0, 0, 200)  
                end
  
                if dist <= 2.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.TextRangerGarage) 
                    if IsControlJustPressed(1,51) then
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                            RangerVoiture()
                    else
                        ESX.ShowNotification('Vous devez être dans un ~r~Véhicule !~s~')
                    end
            end
            end
            end
        end
    Citizen.Wait(wait)
    end
  end)
 
 
   
------------------------[ MENU VESTIAIRE ]------------------------

    local open = false 
    local mainMenuvestiaire = RageUI.CreateMenu('', 'Faites votre choix ?')
    mainMenuvestiaire.Display.Header = true 
    mainMenuvestiaire.Closed = function()
      open = false
    end
    
    function vestiaire()
        if open then 
            open = false
            RageUI.Visible(mainMenuvestiaire, false)
            return
        else
            open = true 
            RageUI.Visible(mainMenuvestiaire, true)
            CreateThread(function()
            while open do 
                RageUI.IsVisible(mainMenuvestiaire,function() 
    
    
                  RageUI.Separator(VarColor.."↓ Vestiaire ↓")
    

                  RageUI.Checkbox("Prendre votre tenue", nil, service, {}, {
                    onChecked = function(index, items)
                        service = true
                        serviceon()
                        ESX.ShowAdvancedNotification('Los Santos Airport', '~r~Notification', "Vous venez de prendre votre ~HUD_COLOUR_BLUELIGHT~tenue", 'CHAR_PROPERTY_BAR_AIRPORT', 7)
                    end,
                    onUnChecked = function(index, items)
                        service = false
                        serviceoff()
                        ESX.ShowAdvancedNotification('Los Santos Airport', '~r~Notification', "Vous venez de ~r~ranger votre tenue", 'CHAR_PROPERTY_BAR_AIRPORT', 7)
                    end
                })
    
    
    
                  end)
              Wait(0)
             end
          end)
       end
    end
    
    Citizen.CreateThread(function()
        while true do  
            local wait = 750
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
                for k, v in pairs(Config.Position) do 
                    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Vestiaire.x, v.Vestiaire.y, v.Vestiaire.z)
      
                    if dist <= Config.MarkerDistance then 
                        wait = 0
                        DrawMarker(Config.MarkerType, v.Vestiaire.x, v.Vestiaire.y, v.Vestiaire.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, true, p19)  
                    end
      
                    if dist <= 2.0 then 
                        wait = 0
                        ESX.ShowHelpNotification(Config.TextVestiaire) 
                        if IsControlJustPressed(1,51) then
                            vestiaire()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
      end)

------------------------[ Tenue Vestiaire Homme / Femme ]------------------------

      function  serviceon()
        local model = GetEntityModel(GetPlayerPed(-1))
        TriggerEvent('skinchanger:getSkin', function(skin)
            if model == GetHashKey("mp_m_freemode_01") then
                clothesSkin = {
                  ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                  ['torso_1'] = 318,   ['torso_2'] = 5,
                  ['decals_1'] = 78,   ['decals_2'] = 0,
                  ['arms'] = 11,
                  ['pants_1'] = 24,   ['pants_2'] = 0,
                  ['shoes_1'] = 20,    ['shoes_2'] = 7,
                  ['helmet_1'] = 149,  ['helmet_2'] = 0,
                  ['chain_1'] = 38,   ['chain_2'] = 0,
                  ['ears_1'] = -1,    ['ears_2'] = 0,
                }
            else
                clothesSkin = {
                    ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                    ['torso_1'] = 318,   ['torso_2'] = 5,
                    ['decals_1'] = 149,   ['decals_2'] = 0,
                    ['arms'] = 11,
                    ['pants_1'] = 24,   ['pants_2'] = 0,
                    ['shoes_1'] = 20,    ['shoes_2'] = 7,
                    ['helmet_1'] = 149,  ['helmet_2'] = 0,
                    ['chain_1'] = 38,   ['chain_2'] = 0,
                    ['ears_1'] = -1,    ['ears_2'] = 0
                }
            end
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end)
    end
    
    function serviceoff()
      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          TriggerEvent('skinchanger:loadSkin', skin)
         end)
      end



------------------------[ MENU ACTIONS PATRON ]------------------------

local open = false 
local societyargent = nil
local mainMenuBoss = RageUI.CreateMenu('', 'GESTION')
mainMenuBoss.Display.Header = true 
mainMenuBoss.Closed = function()
  open = false
end

function bossmenu()
    if open then 
        open = false
        RageUI.Visible(mainMenuBoss, false)
        return
    else
        open = true 
        RageUI.Visible(mainMenuBoss, true)
        CreateThread(function()
        while open do 
            RageUI.IsVisible(mainMenuBoss,function() 

              RageUI.Separator(VarColor.."↓ Gestion Entreprise ↓") 

              RageUI.Button("Accédez à la gestion de l\'entreprise" , nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    gestionboss()
                    RageUI.CloseAll()
                    
                end
             })




              end)
          Wait(0)
         end
      end)
   end
end

Citizen.CreateThread(function()
    while true do  
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
            for k, v in pairs(Config.Position) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Boss.x, v.Boss.y, v.Boss.z)
  
                if dist <= Config.MarkerDistance then 
                    wait = 0
                    DrawMarker(Config.MarkerType, v.Boss.x, v.Boss.y, v.Boss.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, true, p19)  
                end
  
                if dist <= 2.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.TextBoss) 
                    if IsControlJustPressed(1,51) then
                        bossmenu()
                       end
                 end
                end
            end
    Citizen.Wait(wait)
    end
  end)

function ArgentRefresh(money)
    airport = ESX.Math.GroupDigits(money)
end

function UpdateMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            ArgentRefresh(money)
        end, ESX.PlayerData.job.name)
    end
end

function gestionboss()
    TriggerEvent('esx_society:openBossMenu', 'airport', function(data, menu)
        menu.close()
    end, {wash = false})
end



------------------------[ Config Blips ]------------------------
 
local blips = {
    {title="~HUD_COLOUR_BLUELIGHT~Los Santos ~s~Airport", colour=3, id=307, x = -977.27, y = -2979.39, z = 13.94}
  }
  Citizen.CreateThread(function()
  
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.9)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)







