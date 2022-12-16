
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


--------------------------------------------------------------------------------------------------------------------------
                                            -- [ Config Ped Missions ] --
--------------------------------------------------------------------------------------------------------------------------


local open = false 
local mainMenuMission = RageUI.CreateMenu('', 'Faites votre choix ?')
mainMenuMission.Display.Header = true 
mainMenuMission.Closed = function()
  open = false
end
spammissionhydravion = false
spammissionsandy = false
spammissioncayo = false
SpawnVehicleVerif = true

function OpenMenuMission()
    
    if open then 
        open = false
        RageUI.Visible(mainMenuMission, false)
        return
    else
        open = true 
        RageUI.Visible(mainMenuMission, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(mainMenuMission,function() 
     
                    RageUI.Separator(VarColor.."↓ Missions Disponibles ↓")
                    RageUI.Button("Livraison - Lake Sandy Shore", 'Muni toi de ton Hydravion pour effectuer cette livraison.', {RightLabel = "→→"}, true , {
                        onSelected = function()
                            if spammissionhydravion == false and spammissionsandy == false and spammissioncayo == false then 
                                ESX.TriggerServerCallback('airport:mini40colis', function(hasEnoughColis)              
                            
                                    if hasEnoughColis then
                                        spammissionhydravion = true 
                                        for k,v in pairs(Config.Mission.Hydravion) do
                                            if not ESX.Game.IsSpawnPointClear(vector3(v.spawnzone.x, v.spawnzone.y, v.spawnzone.z), 10.0) then
                                                ESX.ShowNotification("~s~Los Santos Airport\n~r~Point de spawn bloquée")
                                                spammissionhydravion = false
                                            else
                                                local model = GetHashKey(v.spawnname)
                                                local myPed = GetPlayerPed(-1)
                                                RequestModel(model)
                                                while not HasModelLoaded(model) do 
                                                    Wait(10) 
                                                end
                                                hydravionplane = CreateVehicle(model, v.spawnzone.x, v.spawnzone.y, v.spawnzone.z, v.headingspawn, true, false)
                                                SetPedIntoVehicle(myPed, hydravionplane, - 1)
                                                SetVehicleCustomPrimaryColour(hydravionplane, 135, 206, 250)
                                                SetVehicleCustomSecondaryColour(hydravionplane, 255, 255, 255)
                                                SetVehicleFixed(hydravionplane)
                                                SetVehRadioStation(hydravionplane, 0)

                                                Ped2HydravionMissionBlip = AddBlipForEntity(Ped2)                                                        	
                                                SetBlipFlashes(Ped2HydravionMissionBlip, true)  
                                                SetBlipColour(Ped2HydravionMissionBlip, 3)
                                                Notify("Rendez-vous au point de livraison !")
                                                ComptMissionHydravion = false
                                                Verification = 1

                             
                                                RageUI.CloseAll()
                                            end                 
                                        end
                                    else 
                                        ESX.ShowNotification("Il vous faut au minimum 40 colis pour lancer la mission")
                                    end                                
                                end)
                            else 
                                Notify("Vous avez déjà une mission en cours !")
                            end
                        end
                    })
                    
                    RageUI.Button("Livraison - Sandy Shore Airport", 'Muni toi de ton avion pour effectuer ce vol.', {RightLabel = "→→"}, true , {
                        onSelected = function()
                            if spammissionsandy == false and spammissionhydravion == false and spammissioncayo == false then 
                                spammissionsandy = true 
                                for k,v in pairs(Config.Mission.SAAirport) do
                                    if not ESX.Game.IsSpawnPointClear(vector3(v.spawnzone.x, v.spawnzone.y, v.spawnzone.z), 10.0) then
                                        ESX.ShowNotification("~s~Los Santos Airport\n~r~Point de spawn bloquée")
                                        spammissionsandy = false
                                    else
                                        local model = GetHashKey(v.spawnname)
                                        local myPed = GetPlayerPed(-1)
                                        RequestModel(model)
                                        while not HasModelLoaded(model) do 
                                            Wait(10) 
                                        end
                                        nimbusplane = CreateVehicle(model, v.spawnzone.x, v.spawnzone.y, v.spawnzone.z, v.headingspawn, true, false)
                                        SetVehicleDoorsLockedForAllPlayers(nimbusplane, true)
                                        SetVehicleCustomPrimaryColour(nimbusplane, 135, 206, 250)
                                        SetVehicleCustomSecondaryColour(nimbusplane, 255, 255, 255)
                                        SetVehicleFixed(nimbusplane)
                                        SetVehRadioStation(nimbusplane, 0)
                                        NPCEmbarquementSA()
                  
                                        RageUI.CloseAll()
                                    end                 
                                end
                            else 
                                Notify("Vous avez déjà une mission en cours !")
                            end
                        end
                    })

                    RageUI.Button("Livraison - Cayo Perico Airport", 'Muni toi de ton avion pour effectuer ce vol.', {RightLabel = "→→"}, true , {
                        onSelected = function()
                            if spammissionsandy == false and spammissionhydravion == false and spammissioncayo == false then 
                                spammissioncayo = true 
                                for k,v in pairs(Config.Mission.CayoAirport) do
                                    if not ESX.Game.IsSpawnPointClear(vector3(v.spawnzone.x, v.spawnzone.y, v.spawnzone.z), 1.0) then
                                        ESX.ShowNotification("~s~Los Santos Airport\n~r~Point de spawn bloquée")
                                        spammissioncayo = false
                                    else
                                        local model = GetHashKey(v.spawnname)
                                        local myPed = GetPlayerPed(-1)
                                        RequestModel(model)
                                        while not HasModelLoaded(model) do 
                                            Wait(10) 
                                        end
                                        miljet = CreateVehicle(model, v.spawnzone.x, v.spawnzone.y, v.spawnzone.z, v.headingspawn, true, false)
                                        SetVehicleDoorsLockedForAllPlayers(miljet, true)
                                        SetVehicleCustomPrimaryColour(miljet, 135, 206, 250)
                                        SetVehicleCustomSecondaryColour(miljet, 255, 255, 255)
                                        SetVehicleFixed(miljet)
                                        SetVehRadioStation(miljet, 0)
                                        NPCEmbarquementCayo()

                        
                                        RageUI.CloseAll()
                                    end                 
                                end
                            else 
                                Notify("Vous avez déjà une mission en cours !")
                            end
                        end
                    })
                    RageUI.Line()

                    RageUI.Button("Annulation Des Missions", '', {RightBadge = RageUI.BadgeStyle.Alert }, true , {
                        onSelected = function()
                            StopMissions()
                        end
                    })

                    RageUI.Line()

                    RageUI.Button("Livraison - 40 Colis", '', {RightLabel = "~r~"..Config.Mission.PriceColis.."$"}, true , {
                        onSelected = function()
                            ESX.TriggerServerCallback('airport:PriceColis', function(hasEnoughMoney) 
                                if hasEnoughMoney then
                                    if SpawnVehicleVerif == true then 
                                        SpawnVehicle()
                                        TriggerServerEvent('airport:PayeColis')
                                    else
                                        PostOPMSG("Vous avez déjà une livraison en cours !")
                                    end
                                else
                                    Notify("Votre entreprise n'a pas accès d'argent !")
                                end 
                            end)
                        end
                    })

                end)
                Wait(0)
            end
        end)
    end
end

-- Création Ped Aéroport

Citizen.CreateThread(function()
    for k, v in pairs(Config.PosPed.Shops) do 
        while not HasModelLoaded(v.pedModel) do
            RequestModel(v.pedModel)
            Wait(1)
        end
        Ped = CreatePed(2, GetHashKey(v.pedModel), v.pedPos, v.heading, 0, 0)
        FreezeEntityPosition(Ped, 1)
        TaskStartScenarioInPlace(Ped, v.pedModel, 0, false)
        SetEntityInvincible(Ped, true)
        SetBlockingOfNonTemporaryEvents(Ped, 1)
    end
    while true do  
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
            for k, v in pairs(Config.Position) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Ped.x, v.Ped.y, v.Ped.z)
                if dist <= 3.0 then 
                    wait = 0
                    Draw3DText(v.Ped.x,v.Ped.y, v.Ped.z-1.600, Config.ParlerPed, 4, 0.1, 0.05)
                    if IsControlJustPressed(1,51) then
                        OpenMenuMission()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

--------------------------------------------------------------------------------------------------------------------------
                                    -- [ Partie Mission Hydravion PED 1 ] --
--------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    for k, v in pairs(Config.PosPed.Shops) do 
        while not HasModelLoaded(v.pedModel2) do
            RequestModel(v.pedModel2)
            Wait(1)
        end
        Ped2 = CreatePed(2, GetHashKey(v.pedModel2), v.pedPos2, v.heading2, 0, 0)
        FreezeEntityPosition(Ped2, 1)
        TaskStartScenarioInPlace(Ped2, v.pedModel2, 0, false)
        SetEntityInvincible(Ped2, true)
        SetBlockingOfNonTemporaryEvents(Ped2, 1)

    end
    while true do  
        local wait = 750
        local pv = GetEntityCoords(hydravionplane)
        local pointarriver = vector3(1323.90, 4278.31, 31.51)

        local distfreezeplane = Vdist(pointarriver.x, pointarriver.y, pointarriver.z, pv.x, pv.y, pv.z)

        if distfreezeplane <= 5 and Verification == 1 then 
            FreezeEntityPosition(hydravionplane, true)
        end

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
            for k, v in pairs(Config.PosPed.Shops) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.pedPos2.x, v.pedPos2.y, v.pedPos2.z)
                if dist <= 3.0 and Verification == 1 then 
                    wait = 0
                    Draw3DText(v.pedPos2.x, v.pedPos2.y, v.pedPos2.z-0.600, Config.ParlerPed, 4, 0.1, 0.05)
                    if IsControlJustPressed(1,51) then
                        RemoveBlip(Ped2HydravionMissionBlip)
                        Notify("Voici l'endroit où se trouvre la personne à qui vous devez livrer vos colis")
                        Ped3HydravionMissionBlip = AddBlipForEntity(Ped3)                                                        	
                        SetBlipFlashes(Ped3HydravionMissionBlip, true)  
                        SetBlipColour(Ped3HydravionMissionBlip, 3)
                        Verification = 2
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

--------------------------------------------------------------------------------------------------------------------------
                                    -- [ Partie Mission Hydravion PED 3 ] --
--------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    for k, v in pairs(Config.PosPed.Shops) do 
        while not HasModelLoaded(v.pedModel3) do
            RequestModel(v.pedModel3)
            Wait(1)
        end
        Ped3 = CreatePed(2, GetHashKey(v.pedModel3), v.pedPos3, v.heading3, 0, 0)
        FreezeEntityPosition(Ped3, 1)
        TaskStartScenarioInPlace(Ped3, v.pedModel3, 0, false)
        SetEntityInvincible(Ped3, true)
        SetBlockingOfNonTemporaryEvents(Ped3, 1)

    end
    while true do  
        local wait = 750
        local player = GetPlayerPed(-1)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
            for k, v in pairs(Config.PosPed.Shops) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.pedPos3.x, v.pedPos3.y, v.pedPos3.z)
                if dist <= 3.0 and Verification == 2 then 
                    wait = 0
                    Draw3DText(v.pedPos3.x, v.pedPos3.y, v.pedPos3.z-0.600, "Appuyez sur ~HUD_COLOUR_BLUELIGHT~[E] ~s~pour parler à la ~HUD_COLOUR_BLUELIGHT~Dame.", 4, 0.1, 0.05)
                    if IsControlJustPressed(1,51) then
                        ESX.TriggerServerCallback('airport:CompteurHydravion', function(compteurhydravion)
                            if compteurhydravion then 
                                ComptMissionHydravion = true
                                compteurhydravion = false
                                TriggerServerEvent('airport:ventecolishydravionmission','colis')

                                Verification = 3

                                RemoveBlip(Ped3HydravionMissionBlip)
                                Ped4HydravionMissionBlip = AddBlipForEntity(Ped4)                                                        	
                                SetBlipFlashes(Ped4HydravionMissionBlip, true)  
                                SetBlipColour(Ped4HydravionMissionBlip, 3)     
                            else
                                TriggerServerEvent('airport:ventecolishydravionmission','colis')
                            end
                        end)
                    end
                end
            end

            if Verification == 3 and IsPedInVehicle(player ,hydravionplane, true) then
                FreezeEntityPosition(hydravionplane, false)
            end
        end
    Citizen.Wait(wait)
    end
end)

--------------------------------------------------------------------------------------------------------------------------
                        -- [ Partie Mission Hydravion PED 4 / Fin Mission ] --
--------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    for k, v in pairs(Config.PosPed.Shops) do 
        while not HasModelLoaded(v.pedModel4) do
            RequestModel(v.pedModel4)
            Wait(1)
        end
        Ped4 = CreatePed(2, GetHashKey(v.pedModel4), v.pedPos4, v.heading4, 0, 0)
        FreezeEntityPosition(Ped4, 1)
        TaskStartScenarioInPlace(Ped4, v.pedModel4, 0, false)
        SetEntityInvincible(Ped4, true)
        SetBlockingOfNonTemporaryEvents(Ped4, 1)

    end
    while true do  
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
            for k, v in pairs(Config.PosPed.Shops) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local pv = GetEntityCoords(hydravionplane)
                local pointretour = vector3(-1281.76, -3380.46, 14.74)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.pedPos4.x, v.pedPos4.y, v.pedPos4.z)
                local distplane = Vdist(pointretour.x, pointretour.y, pointretour.z, pv.x, pv.y, pv.z)

                if dist <= 3.0 and Verification == 3 then 
                    wait = 0
                    Draw3DText(v.pedPos4.x, v.pedPos4.y, v.pedPos4.z-0.600, "Appuyez sur ~HUD_COLOUR_BLUELIGHT~[E] ~s~pour parler au ~HUD_COLOUR_BLUELIGHT~Technicien.", 4, 0.1, 0.05)

                    if IsControlJustPressed(1,51) then
                        if distplane <= 50 then 
                            if ComptMissionHydravion == true and distplane <= 50 then 
                                TriggerServerEvent('airport:retourhydravionmission')
                                RemoveBlip(Ped4HydravionMissionBlip)
                                DeleteEntity(hydravionplane)
                                Verification = 0
                                ComptMissionHydravion = false
                                spammissionhydravion = false
                                Wait(500)
                            else 
                                Notify("Tu n'as rien vendu pour le moment !")
                            end
                        else 
                            Notify("L'avion n'est pas présent dans le hangar !")
                        end
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)


--------------------------------------------------------------------------------------------------------------------------
                                            -- [ Fonction Draw Text ] --
--------------------------------------------------------------------------------------------------------------------------

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)      
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end


--------------------------------------------------------------------------------------------------------------------------
                                    -- [ Config Missions Aéroport Sandy Shore ] --
--------------------------------------------------------------------------------------------------------------------------

function NPCEmbarquementSA(x, y ,z)
    Active = true
    SAcomptdist0 = true
    SAcomptdist1 = false
    SAcomptdist2 = false
    VerifSA = 0
	local typevehicule = GetHashKey("cognoscenti2")                                                     
	local npcarriver = vector3(-1288.29, -3362.90, 13.94)  
	RequestModel(typevehicule)
	while not HasModelLoaded(typevehicule) do
		Wait(1)
	end
	RequestModel('a_m_y_business_03')
	while not HasModelLoaded('a_m_y_business_03') do
		Wait(1)
	end
  
    local spawnVehiculePos = vector3(-1045.36, -3446.45, 13.94) 
    local spawnVehiculeHeading = 58.18   

    if DoesEntityExist(NPCVehicle) then
        Notify("Vous avez un nouveau message de l'~o~Agence !")
        AirportMSG("Vous avez déjà un client en cours de chemin !")

	elseif not DoesEntityExist(typevehicule) then
        NPCVehicle = CreateVehicle(typevehicule, spawnVehiculePos, spawnVehiculeHeading, true, false)      
        SetVehicleDoorsLockedForAllPlayers(NPCVehicle, true)                  
        ClearAreaOfVehicles(GetEntityCoords(NPCVehicle), 5000, false, false, false, false, false);  
        SetVehicleOnGroundProperly(NPCVehicle)
		SetVehicleNumberPlateText(NPCVehicle, "Airport")
		SetEntityAsMissionEntity(NPCVehicle, true, true)
		SetVehicleEngineOn(NPCVehicle, true, true, false)
        
        L2Ped = CreatePedInsideVehicle(NPCVehicle, 26, GetHashKey('a_m_y_business_03'), -1, true, false)    
        SetEntityInvincible(L2Ped, true)  
        SetBlockingOfNonTemporaryEvents(L2Ped, 1)       
               	

        AirportMSG("Un client est sur le point d'arriver !")
		Wait(2000)
		TaskVehicleDriveToCoord(L2Ped, NPCVehicle, npcarriver.x, npcarriver.y, npcarriver.z, 10.0, 0, GetEntityModel(NPCVehicle), 63, 2.0)		 
    end 
end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(200)

        local pv = GetEntityCoords(NPCVehicle)
		local pp = GetEntityCoords(L2Ped) 
        local npcarriver = vector3(-1288.29, -3362.90, 13.94) 
        local entreravion = vector3(-1287.65, -3371.60, 13.94)
               
        local SAdist0 = Vdist(npcarriver.x, npcarriver.y, npcarriver.z, pp.x, pp.y, pp.z) 
        local SAdist1 = Vdist(entreravion.x, entreravion.y, entreravion.z, pp.x, pp.y, pp.z)

        if SAcomptdist0 == true then
            if SAdist0 <= 5 then
                SAcomptdist0 = false
                SAcomptdist1 = true
                Wait(100)
                TaskGoToCoordAnyMeans(L2Ped, entreravion.x, entreravion.y, entreravion.z, 1.0, 0, 0, 786603, 0xbf800000)
            end 
        end 

        if SAcomptdist1 == true then
            if SAdist1 <= 2.5 then
                SAcomptdist1 = false
                SAcomptdist2 = true
                Wait(1000)
                SetEntityHeading(L2Ped, 233.46)
                SetVehicleDoorOpen(nimbusplane, 0, false, true)
                Wait(1000)
                SetPedIntoVehicle(L2Ped, nimbusplane, 2)
                SetVehicleDoorsLockedForAllPlayers(nimbusplane, false)
                if GetVehiclePedIsIn(xPlayer, false) then
                    SetVehicleDoorShut(nimbusplane, 1, true)

                    local Blip = vector3(1708.54, 3251.85, 41.67)
                    BlipsSA = AddBlipForCoord(Blip.x, Blip.y, Blip.z)
                    SetBlipSprite(BlipsSA, 1)                                                       	
                    SetBlipFlashes(BlipsSA, true)  
                    SetBlipColour(BlipsSA, 3)
                    Notify("Le client est installé, déposer le au point qui vous a été donné !")
                    VerifSA = 1
                end
            end 
        end
    end
end)

Citizen.CreateThread(function()
    while true do
		local wait = 750
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' and VerifSA == 1 then
				for k, v in pairs(Config.Mission.SAAirport) do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.depotNPC.x,v.depotNPC.y, v.depotNPC.z)

				if dist <= 200 then
					wait = 0
					DrawMarker(1, v.depotNPC.x, v.depotNPC.y, v.depotNPC.z-1, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 5.5, 5.5, 0.75, 255, 0, 0, 200)  
				end
			end
		end
    Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    while true do
		local wait = 200

        local typevehicule = GetHashKey("cognoscenti2")
        RequestModel(typevehicule)
	    while not HasModelLoaded(typevehicule) do
		    Wait(1)
	    end

        local spawnVehiculePos = vector3(1724.18, 3276.94, 41.12) 
        local spawnVehiculeHeading = 260.05

        local AvionArriver = vector3(1708.54, 3251.85, 41.67)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local finalpointNPC = vector3(1989.85, 3067.05, 47.01)
        
        local SAdist0 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, AvionArriver.x, AvionArriver.y, AvionArriver.z) 

        if not DoesEntityExist(NPCVehicle2) and VerifSA == 1 then 
            if SAdist0 <= 200 then 
                NPCVehicle2 = CreateVehicle(typevehicule, spawnVehiculePos, spawnVehiculeHeading, true, false)      
                SetVehicleDoorsLockedForAllPlayers(NPCVehicle2, true)                  
                SetVehicleOnGroundProperly(NPCVehicle2)
		        SetVehicleNumberPlateText(NPCVehicle2, "Airport")
		        SetEntityAsMissionEntity(NPCVehicle2, true, true)
		        SetVehicleEngineOn(NPCVehicle2, true, true, false)

                DeleteEntity(NPCVehicle)
                
            end 
        end 

        
        if SAdist0 <= 5 and VerifSA == 1 then 
            VerifSA = 2
            FreezeEntityPosition(nimbusplane, true)
            Wait(1000)
            TaskVehicleDriveToCoord(L2Ped, NPCVehicle2, finalpointNPC.x, finalpointNPC.y, finalpointNPC.z, 10.0, 0, GetEntityModel(APVehicule), 63, 2.0)
            Notify("Le client est bien arrivé à destination, rapporter l'avion à l'aéroport pour être payer !")
            AirportMSG("Le client a été très satisfait de votre performance !")
        end

        if VerifSA == 2 then 
            FreezeEntityPosition(nimbusplane, false)
            RemoveBlip(BlipsSA)
            VerifSA = 3
            Ped4SAMissionBlip = AddBlipForEntity(Ped4)                                                        	
            SetBlipFlashes(Ped4SAMissionBlip, true)  
            SetBlipColour(Ped4SAMissionBlip, 3)  
            ComptMissionSA = true
        end 

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
            for k, v in pairs(Config.PosPed.Shops) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local pv = GetEntityCoords(nimbusplane)
                local pointretour = vector3(-1281.76, -3380.46, 14.74)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.pedPos4.x, v.pedPos4.y, v.pedPos4.z)
                local distplane = Vdist(pointretour.x, pointretour.y, pointretour.z, pv.x, pv.y, pv.z)

                if dist <= 3.0 and VerifSA == 3 then 
                    wait = 0
                    Draw3DText(v.pedPos4.x, v.pedPos4.y, v.pedPos4.z-0.600, "Appuyez sur ~HUD_COLOUR_BLUELIGHT~[E] ~s~pour parler au ~HUD_COLOUR_BLUELIGHT~Technicien.", 4, 0.1, 0.05)
                    
                    if IsControlJustPressed(1,51) then
                        if distplane <= 50 then 
                            if ComptMissionSA == true and distplane <= 50 then 
                                TriggerServerEvent('airport:retourSAmission')
                                RemoveBlip(Ped4SAMissionBlip)
                                DeleteEntity(nimbusplane)
                                VerifSA = 0
                                ComptMissionSA = false
                                spammissionsandy = false
                                Wait(500)
                            else 
                                Notify("Tu n'as pas déposer le client au bon endroit !")
                            end
                        else 
                            Notify("L'avion n'est pas présent dans le hangar !")
                        end
                    end
                end
            end
        end



    Citizen.Wait(wait)
    end
end)

--------------------------------------------------------------------------------------------------------------------------
                                -- [ Config Missions Aéroport Cayo Perrico ] --
--------------------------------------------------------------------------------------------------------------------------

function NPCEmbarquementCayo(x, y ,z)
    Active = true
    Cayocomptdist0 = true
    Cayocomptdist1 = false
    Cayocomptdist2 = false
    VerifCayo = 0
	local typevehicule = GetHashKey("cognoscenti2")                                                     
	local npcarriver = vector3(-1257.53, -3403.10, 13.94) 
	RequestModel(typevehicule)
	while not HasModelLoaded(typevehicule) do
		Wait(1)
	end
	RequestModel('ig_milton')
	while not HasModelLoaded('ig_milton') do
		Wait(1)
	end

    RequestModel('u_f_o_moviestar')
	while not HasModelLoaded('u_f_o_moviestar') do
		Wait(1)
	end

    RequestModel('s_f_y_movprem_01')
	while not HasModelLoaded('s_f_y_movprem_01') do
		Wait(1)
	end
  
    local spawnVehiculePos = vector3(-1045.36, -3446.45, 13.94) 
    local spawnVehiculeHeading = 58.18   

    if DoesEntityExist(NPCVehicleCayo) then
        Notify("Vous avez un nouveau message de l'~o~Agence !")
        AirportMSG("Vous avez déjà des clients en cours de chemin !")

	elseif not DoesEntityExist(typevehicule) then
        NPCVehicleCayo = CreateVehicle(typevehicule, spawnVehiculePos, spawnVehiculeHeading, true, false)      
        SetVehicleDoorsLockedForAllPlayers(NPCVehicleCayo, true)                  
        ClearAreaOfVehicles(GetEntityCoords(NPCVehicleCayo), 5000, false, false, false, false, false);  
        SetVehicleOnGroundProperly(NPCVehicleCayo)
		SetVehicleNumberPlateText(NPCVehicleCayo, "Airport")
		SetEntityAsMissionEntity(NPCVehicleCayo, true, true)
		SetVehicleEngineOn(NPCVehicleCayo, true, true, false)
        
        PedCayo = CreatePedInsideVehicle(NPCVehicleCayo, 26, GetHashKey('ig_milton'), -1, true, false)    
        SetEntityInvincible(PedCayo, true)         
        SetBlockingOfNonTemporaryEvents(PedCayo, 1)    
        
        PedCayo2 = CreatePedInsideVehicle(NPCVehicleCayo, 26, GetHashKey('u_f_o_moviestar'), 1, true, false)  
        SetEntityInvincible(PedCayo2, true)    
        SetBlockingOfNonTemporaryEvents(PedCayo2, 1)      

        PedCayo3 = CreatePedInsideVehicle(NPCVehicleCayo, 26, GetHashKey('s_f_y_movprem_01'), 2, true, false)  
        SetEntityInvincible(PedCayo3, true)    
        SetBlockingOfNonTemporaryEvents(PedCayo3, 1)      

        AirportMSG("Vos clients sont sur le point d'arriver !")
		Wait(2000)
		TaskVehicleDriveToCoord(PedCayo, NPCVehicleCayo, npcarriver.x, npcarriver.y, npcarriver.z, 10.0, 0, GetEntityModel(NPCVehicleCayo), 63, 2.0) 
    end 
end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(200)

        local player = GetPlayerPed(-1)
        local pv = GetEntityCoords(NPCVehicleCayo)
		local pp = GetEntityCoords(PedCayo2) 
        local npcarriver = vector3(-1257.53, -3403.10, 13.94)  
        local entreravion = vector3(-1269.30, -3399.16, 13.94)
               
        local Cayodist0 = Vdist(npcarriver.x, npcarriver.y, npcarriver.z, pp.x, pp.y, pp.z) 
        local Cayodist1 = Vdist(entreravion.x, entreravion.y, entreravion.z, pp.x, pp.y, pp.z)

        if Cayocomptdist0 == true then
            if Cayodist0 <= 5 then
                Cayocomptdist0 = false
                Cayocomptdist1 = true
                Wait(500)
                TaskGoToCoordAnyMeans(PedCayo, entreravion.x, entreravion.y, entreravion.z, 1.0, 0, 0, 786603, 0xbf800000)
                TaskGoToCoordAnyMeans(PedCayo2, entreravion.x, entreravion.y, entreravion.z, 1.0, 0, 0, 786603, 0xbf800000)
                TaskGoToCoordAnyMeans(PedCayo3, entreravion.x, entreravion.y, entreravion.z, 1.0, 0, 0, 786603, 0xbf800000)
            end 
        end 

        if Cayocomptdist1 == true then
            if Cayodist1 <= 2.5 then
                Cayocomptdist1 = false
                Cayocomptdist2 = true
                SetEntityHeading(PedCayo, 67.51)
                SetEntityHeading(PedCayo2, 67.51)
                SetEntityHeading(PedCayo3, 67.51)
                SetVehicleDoorOpen(miljet, 0, false, true)
                Wait(1000)
                SetPedIntoVehicle(PedCayo3, miljet, 2)
                Wait(1000)
                SetPedIntoVehicle(PedCayo, miljet, 3)
                Wait(1000)
                SetPedIntoVehicle(PedCayo2, miljet, 4)
                SetVehicleDoorsLockedForAllPlayers(miljet, false)
                if GetVehiclePedIsIn(player, false) then
                    SetVehicleDoorShut(miljet, 1, true)

                    local Blip = vector3(4480.96, -4497.38, 4.19)
                    BlipsCayo = AddBlipForCoord(Blip.x, Blip.y, Blip.z)
                    SetBlipSprite(BlipsCayo, 1)                                                       	
                    SetBlipFlashes(BlipsCayo, true)  
                    SetBlipColour(BlipsCayo, 3)
                    Notify("Les clients sont installés, vous pouvez prendre place dans l'avion !")
                    VerifCayo = 1
                end
            end 
        end
    end
end)

Citizen.CreateThread(function()
    while true do
		local wait = 750
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' and VerifCayo == 1 then
				for k, v in pairs(Config.Mission.CayoAirport) do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.depotNPCCayo.x,v.depotNPCCayo.y, v.depotNPCCayo.z)

				if dist <= 200 then
					wait = 0
					DrawMarker(1, v.depotNPCCayo.x, v.depotNPCCayo.y, v.depotNPCCayo.z-1, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 5.5, 5.5, 0.75, 255, 0, 0, 200)  
				end
			end
		end
    Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    while true do
		local wait = 200

        local AvionArriver = vector3(4480.96, -4497.38, 4.19)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local finalpointNPC = vector3(4494.16, -4525.62, 4.41)
        local debugpointPedCayo = vector3(4501.09, -4486.33, 4.19)

        local positionPedCayo = GetEntityCoords(PedCayo)
        local positionPedCayo2 = GetEntityCoords(PedCayo2)
        local positionPedCayo3 = GetEntityCoords(PedCayo3)
        
        local Cayodist0 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, AvionArriver.x, AvionArriver.y, AvionArriver.z) 

        local Cayodist1 = Vdist(positionPedCayo.x, positionPedCayo.y, positionPedCayo.z, finalpointNPC.x, finalpointNPC.y, finalpointNPC.z) 
        local Cayodist2 = Vdist(positionPedCayo2.x, positionPedCayo2.y, positionPedCayo2.z, finalpointNPC.x, finalpointNPC.y, finalpointNPC.z) 
        local Cayodist3 = Vdist(positionPedCayo3.x, positionPedCayo3.y, positionPedCayo3.z, finalpointNPC.x, finalpointNPC.y, finalpointNPC.z) 
        
        if Cayodist0 <= 5 and VerifCayo == 1 then 
            VerifCayo = 2
            DeleteEntity(NPCVehicleCayo)
            FreezeEntityPosition(miljet, true)
            Wait(1000)
            TaskLeaveVehicle(PedCayo, miljet, 256)
            TaskGoToCoordAnyMeans(PedCayo, debugpointPedCayo.x, debugpointPedCayo.y, debugpointPedCayo.z, 1.0, 0, 0, 786603, 0xbf800000)
            Wait(2000)
            TaskLeaveVehicle(PedCayo2, miljet, 256)
            TaskGoToCoordAnyMeans(PedCayo2, finalpointNPC.x, finalpointNPC.y, finalpointNPC.z, 1.0, 0, 0, 786603, 0xbf800000)
            Wait(2000)            
            TaskLeaveVehicle(PedCayo3, miljet, 1)
            TaskGoToCoordAnyMeans(PedCayo3, finalpointNPC.x, finalpointNPC.y, finalpointNPC.z, 1.0, 0, 0, 786603, 0xbf800000)
            TaskGoToCoordAnyMeans(PedCayo, finalpointNPC.x, finalpointNPC.y, finalpointNPC.z, 1.0, 0, 0, 786603, 0xbf800000)
        end

        if Cayodist1 <= 2 then 
            SetEntityHeading(PedCayo, 114.47)
            Wait(500)
            DeletePed(PedCayo)
        end

        if Cayodist2 <= 2 then 
            SetEntityHeading(PedCayo2, 114.47)
            Wait(500)
            DeletePed(PedCayo2)
        end

        if Cayodist3 <= 2 then 
            SetEntityHeading(PedCayo3, 114.47)
            Wait(500)
            DeletePed(PedCayo3)
        end

        if not DoesEntityExist(PedCayo) and not DoesEntityExist(PedCayo2) and not DoesEntityExist(PedCayo3) and VerifCayo == 2 then
            FreezeEntityPosition(miljet, false)
            RemoveBlip(BlipsCayo)
            VerifCayo = 3
            Ped4CayoMissionBlip = AddBlipForEntity(Ped4)                                                        	
            SetBlipFlashes(Ped4CayoMissionBlip, true)  
            SetBlipColour(Ped4CayoMissionBlip, 3)  
            ComptMissionCayo = true
            Notify("Les clients sont bien arrivés à destination, rapporter l'avion à l'aéroport pour être payer !")
            AirportMSG("Les clients ont été très satisfait de votre performance !")
        end 

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'airport' then
            for k, v in pairs(Config.PosPed.Shops) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local pv = GetEntityCoords(miljet)
                local pointretour = vector3(-1281.76, -3380.46, 14.74)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.pedPos4.x, v.pedPos4.y, v.pedPos4.z)
                local distplane = Vdist(pointretour.x, pointretour.y, pointretour.z, pv.x, pv.y, pv.z)

                if dist <= 3.0 and VerifCayo == 3 then 
                    wait = 0
                    Draw3DText(v.pedPos4.x, v.pedPos4.y, v.pedPos4.z-0.600, "Appuyez sur ~HUD_COLOUR_BLUELIGHT~[E] ~s~pour parler au ~HUD_COLOUR_BLUELIGHT~Technicien.", 4, 0.1, 0.05)
                    
                    if IsControlJustPressed(1,51) then
                        if distplane <= 50 then 
                            if ComptMissionCayo == true and distplane <= 50 then 
                                TriggerServerEvent('airport:retourCayomission')
                                RemoveBlip(Ped4CayoMissionBlip)
                                DeleteEntity(miljet)
                                VerifCayo = 0
                                ComptMissionCayo = false
                                spammissioncayo = false
                                Wait(500)
                            else 
                                Notify("Tu n'as pas déposer les clients au bon endroit !")
                            end
                        else 
                            Notify("L'avion n'est pas présent dans le hangar !")
                        end
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)



--------------------------------------------------------------------------------------------------------------------------
                                            -- [ Fonction Livraison de Colis ] --
--------------------------------------------------------------------------------------------------------------------------

function SpawnVehicle(x, y, z)  

    Active = true
    comptdist1 = false
    comptdist2 = true
	local typevehicule = GetHashKey("boxville4")                                                     
	local livraisonped = vector3(-1294.97, -3379.72, 13.94) 
	RequestModel(typevehicule)
	while not HasModelLoaded(typevehicule) do
		Wait(1)
	end
	RequestModel('s_m_m_gardener_01')
	while not HasModelLoaded('s_m_m_gardener_01') do
		Wait(1)
	end
  
    local spawnVehiculePos = vector3(-1460.54, -3248.30, 13.94) 
    local spawnVehiculeHeading = 284.18   

    if DoesEntityExist(APVehicule) then
        PostOPMSG("Vous avez déjà une livraison en cours !")

	elseif not DoesEntityExist(typevehicule) then
        SpawnVehicleVerif = false
        APVehicule = CreateVehicle(typevehicule, spawnVehiculePos, spawnVehiculeHeading, true, false)                        
        ClearAreaOfVehicles(GetEntityCoords(APVehicule), 5000, false, false, false, false, false);  
        SetVehicleOnGroundProperly(APVehicule)
		SetVehicleNumberPlateText(APVehicule, "Post OP")
		SetEntityAsMissionEntity(APVehicule, true, true)
		SetVehicleEngineOn(APVehicule, true, true, false)
        
        LPed = CreatePedInsideVehicle(APVehicule, 26, GetHashKey('s_m_m_gardener_01'), -1, true, false)    
        SetEntityInvincible(LPed, true)
        SetBlockingOfNonTemporaryEvents(LPed, 1)          	
        
        APVehiculeBlip = AddBlipForEntity(APVehicule)                                                        	
        SetBlipFlashes(APVehiculeBlip, true)  
        SetBlipColour(APVehiculeBlip, 5)

        PostOPMSG("Votre livraison a été accepté, elle est sur le point d'être expédié !")
		Wait(2000)
		TaskVehicleDriveToCoord(LPed, APVehicule, livraisonped.x, livraisonped.y, livraisonped.z, 10.0, 0, GetEntityModel(APVehicule), 63, 2.0)		 
    end 
end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(200)
      
        local coffre = vector3(-1306.29, -3390.01, 13.94)
		local pv = GetEntityCoords(APVehicule) 
		local pp = GetEntityCoords(LPed) 
        local livraisonped = vector3(-1294.97, -3379.72, 13.94) 
        local vehicledoor = vector3(-1292.44, -3374.84, 13.94) 
        local deletePos = vector3(-1442.16, -3225.09, 13.94) 
            
        local dist0 = Vdist(livraisonped.x, livraisonped.y, livraisonped.z, pp.x, pp.y, pp.z) 
        local dist1 = Vdist(vehicledoor.x, vehicledoor.y, vehicledoor.z, pp.x, pp.y, pp.z)    
		local dist2 = Vdist(coffre.x, coffre.y, coffre.z, pp.x, pp.y, pp.z)                   
        local dist3 = Vdist(deletePos.x, deletePos.y, deletePos.z, pp.x, pp.y, pp.z)          

        if Active == true then
            if dist0 <= 2 then         
			    SetVehicleDoorsLockedForAllPlayers(APVehicule, true)
                TaskGoToCoordAnyMeans(LPed, vehicledoor.x, vehicledoor.y, vehicledoor.z, 1.0, 0, 0, 786603, 0xbf800000)  
                comptdist1 = true
            end
        end 

        if comptdist1 == true then
            if dist1 <= 1 then
                Wait(500)
                SetEntityHeading(LPed, 147.90)
                Wait(500)
                SetVehicleDoorOpen(APVehicule, 2, false, false)
                SetVehicleDoorOpen(APVehicule, 3, false, false)
                Wait(1000)
                RequestAnimDict('anim@heists@box_carry@')
                while not HasAnimDictLoaded('anim@heists@box_carry@') do
                    Wait(100)
                end
                TaskPlayAnim(LPed, 'anim@heists@box_carry@', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
                prop = CreateObject(GetHashKey("hei_prop_heist_box"), pp.x, pp.y, pp.z,  true,  true, true)
                AttachEntityToEntity(prop, LPed, GetPedBoneIndex(LPed, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
                Wait(1000)
                SetVehicleDoorShut(APVehicule, 2, true)
                SetVehicleDoorShut(APVehicule, 3, true)
                TaskGoToCoordAnyMeans(LPed, coffre.x, coffre.y, coffre.z, 1.0, 0, 0, 786603, 0xbf800000)
                comptdist1 = false
            end
        end

        if comptdist2 == true then
            if dist2 <= 1 then 
                Wait(1000)
                SetEntityHeading(LPed, 61.49)
                Wait(1000)
                NPC()
                ClearPedTasks(LPed)
                DeleteEntity(prop)
                Wait(1000)
                Active = false
                comptdist2 = false
                TaskVehicleDriveToCoord(LPed, APVehicule, deletePos.x, deletePos.y, deletePos.z, 10.0, 0, GetEntityModel(APVehicule), 786603, 2.0)
            end
        end
        
        if dist3 <= 3 then 
            RemovePedElegantly(LPed)
            DeleteEntity(APVehicule)
        end
    end
end)


function NPC()
    TriggerServerEvent('airport:livraisoncolis', 'colis', 40)
	PostOPMSG("Votre commande vient d'être livré. Merci d'avoir fait confiance à Post OP !")
    Notify("Vous avez un nouveau message de ~o~Post OP")

end

--------------------------------------------------------------------------------------------------------------------------
                                            -- [ Fonction Notification ] --
--------------------------------------------------------------------------------------------------------------------------

function Notify(msg)
    ESX.ShowNotification(msg)
end

--------------------------------------------------------------------------------------------------------------------------
                                       -- [ Fonction Notification Téléhpone ] --
--------------------------------------------------------------------------------------------------------------------------

function PostOPMSG(msg)
	local phoneNr = "Post OP"
    PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", true)
	Notify("Vous avez un nouveau message de ~o~Post OP")
	TriggerServerEvent('gcPhone:sendMessage', phoneNr, msg) --> Si vous utilisez GCPhone ne changer rien. Si vous avez un autre téléphone utiliser le bon TriggerServentEvent liée à votre téléphone
end

function AirportMSG(msg)
	local phoneNr = "LS Airport"
    PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", true)
	Notify("Vous avez un nouveau message de l'~HUD_COLOUR_BLUELIGHT~Agence")
	TriggerServerEvent('gcPhone:sendMessage', phoneNr, msg) --> Si vous utilisez GCPhone ne changer rien. Si vous avez un autre téléphone utiliser le bon TriggerServentEvent liée à votre téléphone
end



--------------------------------------------------------------------------------------------------------------------------
                                          -- [ Fonction Coffre Garage ] --
--------------------------------------------------------------------------------------------------------------------------

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

    
function CoffreEntrepot() 
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
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.CoffreEntrepot.x, v.CoffreEntrepot.y, v.CoffreEntrepot.z)

				if dist <= Config.MarkerDistance then
					wait = 0
					DrawMarker(Config.MarkerType, v.CoffreEntrepot.x, v.CoffreEntrepot.y, v.CoffreEntrepot.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, true, p19)  
				end

				if dist <= 1.0 then
					wait = 0
					ESX.ShowHelpNotification(Config.TextCoffreEntrepot) 
					if IsControlJustPressed(1,51) then
						CoffreEntrepot()
					end
				end
			end
		end
    Citizen.Wait(wait)
    end
end)

--------------------------------------------------------------------------------------------------------------------------
                                          -- [ Fonction Stop Missions ] --
--------------------------------------------------------------------------------------------------------------------------

function StopMissions()

    -- Mission Lake Sandy Shore 
    DeleteEntity(hydravionplane)
    RemoveBlip(Ped2HydravionMissionBlip)

    -- Mission Aéroport Sandy Shore
    RemovePedElegantly(L2Ped)
    DeleteEntity(NPCVehicle)
    DeleteEntity(NPCVehicle2)
    DeleteEntity(nimbusplane)

    -- Mission Cayo
    RemovePedElegantly(PedCayo)
    RemovePedElegantly(PedCayo2)
    RemovePedElegantly(PedCayo3)
    DeleteEntity(NPCVehicleCayo)
    DeleteEntity(miljet)

    VerifSA = 0
    VerifCayo = 0
    Verification = 0
    spammissioncayo = false
    spammissionhydravion = false
    spammissionsandy = false 

    AirportMSG("Votre annulation de mission a été effectué !")
end