--██████╗░░█████╗░██████╗░░█████╗░██╗░░██╗░█████╗░███╗░░██╗░██████╗░███████╗███╗░░██╗
--██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░██╔╝██╔══██╗████╗░██║██╔════╝░██╔════╝████╗░██║
--██████╔╝███████║██████╔╝███████║█████═╝░██║░░██║██╔██╗██║██║░░██╗░█████╗░░██╔██╗██║
--██╔═══╝░██╔══██║██╔═══╝░██╔══██║██╔═██╗░██║░░██║██║╚████║██║░░╚██╗██╔══╝░░██║╚████║
--██║░░░░░██║░░██║██║░░░░░██║░░██║██║░╚██╗╚█████╔╝██║░╚███║╚██████╔╝███████╗██║░╚███║
--╚═╝░░░░░╚═╝░░╚═╝╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝░╚═════╝░╚══════╝╚═╝░░╚══╝

vRP = Proxy.getInterface("vRP")

local ped = false
local searchingDrugs = false

local rewardTime = math.random(4,7)

--pistol
Citizen.CreateThread(function()
    while true do
        inRange = false
 
        local Player = GetPlayerPed(-1)
        local Position = GetEntityCoords(Player)
 
            local dist = GetDistanceBetweenCoords(Position, -430.5947265625,90.687477111816,64.263244628906)
            
            if dist < 2 then
                inRange = true
            
                DrawText3D(-430.5947265625,90.687477111816,64.263244628906, 'Tryk [~g~E~w~] for at købe våben kontrakt')
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('weapondealer:Weaponbuy')
            end
        end
 
        if not inRange then
            Citizen.Wait(1000)
        end
 
        Citizen.Wait(5)
    end
end)

Citizen.CreateThread(function()
    while true do
        inRange = false
 
        local Player = GetPlayerPed(-1)
        local Position = GetEntityCoords(Player)
 
            local dist = GetDistanceBetweenCoords(Position, 708.54638671875,-310.10708618164,59.246913909912)
            
            if dist < 2 then
                inRange = true
            
                DrawText3D(708.54638671875,-310.10708618164,59.246913909912, 'Tryk [~g~E~w~] for at købe ammunition kontrakt')
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('weapondealer:Bulletbuy')
            end
        end
 
        if not inRange then
            Citizen.Wait(1000)
        end
 
        Citizen.Wait(5)
    end
end)

Citizen.CreateThread(function()
    while true do
        inRange = false
 
        local Player = GetPlayerPed(-1)
        local Position = GetEntityCoords(Player)
 
            local dist = GetDistanceBetweenCoords(Position, 319.50421142578,2883.2502441406,46.382823944092)
            
            if dist < 2 then
                inRange = true
            
                DrawText3D(319.50421142578,2883.2502441406,46.382823944092, 'Tryk [~g~E~s~] for at lave en pistol')
                if IsControlJustReleased(0, 38) then
                    exports['progressBars']:startUI(2000, "Laver pistol.")
                FreezeEntityPosition(PlayerPedId(), true) 
                RequestAnimDict("amb@prop_human_bum_bin@idle_b") 
                while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end 
                  TaskPlayAnim(Player,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0) 
                  Citizen.Wait(2000)
                  StopAnimTask(Player, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0) 
                  FreezeEntityPosition(PlayerPedId(), false)
                TriggerServerEvent('weapondealer:make') 
            end
        end
 
        if not inRange then
            Citizen.Wait(1000)
        end
 
        Citizen.Wait(5)
    end
end)

RegisterNetEvent('weapondealer:findweapon')
AddEventHandler('weapondealer:findweapon', function()
    local player = GetPlayerPed(-1)

    exports['mythic_notify']:DoCustomHudText('inform', "Du har modtaget et gps", 4500)
    num = math.random(1,4)
     SetNewWaypoint(Config.WeaponCoords[num].x, Config.WeaponCoords[num].y, Config.WeaponCoords[num].z)
    drugProp = CreateObject("prop_idol_case_02", Config.WeaponCoords[num].x, Config.WeaponCoords[num].y, Config.WeaponCoords[num].z - 1.0, true, true, true)
    PlaceObjectOnGroundProperly(drugProp)

    drugPos = GetEntityCoords(drugProp) 

     drugs = true  
end)

Citizen.CreateThread(function()
    while true do
        inRange = false
 
        local Player = GetPlayerPed(-1)
        local Position = GetEntityCoords(Player)
 
            local dist = GetDistanceBetweenCoords(Position, Config.WeaponCoords[num].x, Config.WeaponCoords[num].y, Config.WeaponCoords[num].z)
            
            if dist < 2 then
                inRange = true
                if drugs then
            
                DrawText3D(Config.WeaponCoords[num].x, Config.WeaponCoords[num].y, Config.WeaponCoords[num].z, 'Tryk på [~r~E~w~] for at åbne kassen')
                if IsControlJustReleased(0, 38) then
                    drugPos = ""
                    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
                    Citizen.Wait(rewardTime * 1000)
                    local ped = PlayerPedId()
                    local x,y,z = table.unpack(GetEntityCoords(ped, false))
                    local streetName, crossing = GetStreetNameAtCoord(x, y, z)
                    streetName = GetStreetNameFromHashKey(streetName)
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    drugs = false
                    TriggerServerEvent("weapondealer:GetWeaponReward")
                    DeleteObject(drugProp)
                end
            end
        end
 
        if not inRange then
            Citizen.Wait(1000)
        end
 
        Citizen.Wait(5)
    end
end)

RegisterNetEvent('weapondealer:ammunition')
AddEventHandler('weapondealer:ammunition', function()
    local player = GetPlayerPed(-1)

    exports['mythic_notify']:DoCustomHudText('inform', "Du har modtaget et gps", 4500)
    num = math.random(1,4)
     SetNewWaypoint(Config.ammunitionCoords[num].x, Config.ammunitionCoords[num].y, Config.ammunitionCoords[num].z)
    drugProp = CreateObject("prop_box_ammo03a_set2", Config.ammunitionCoords[num].x, Config.ammunitionCoords[num].y, Config.ammunitionCoords[num].z - 1.0, true, true, true)
    PlaceObjectOnGroundProperly(drugProp)

    drugPos = GetEntityCoords(drugProp) 

     drugs = true  
end)

Citizen.CreateThread(function()
    while true do
        inRange = false
 
        local Player = GetPlayerPed(-1)
        local Position = GetEntityCoords(Player)
 
            local dist = GetDistanceBetweenCoords(Position, Config.ammunitionCoords[num].x, Config.ammunitionCoords[num].y, Config.ammunitionCoords[num].z)
            
            if dist < 2 then
                inRange = true
                if drugs then
            
                DrawText3D(Config.ammunitionCoords[num].x, Config.ammunitionCoords[num].y, Config.ammunitionCoords[num].z, 'Tryk på [~r~E~w~] for at åbne ammunition kassen')
                if IsControlJustReleased(0, 38) then
                    drugPos = ""
                    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
                    Citizen.Wait(rewardTime * 1000)
                    local ped = PlayerPedId()
                    local x,y,z = table.unpack(GetEntityCoords(ped, false))
                    local streetName, crossing = GetStreetNameAtCoord(x, y, z)
                    streetName = GetStreetNameFromHashKey(streetName)
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    drugs = false
                    TriggerServerEvent("weapondealer:GetAmmunitionReward")
                    DeleteObject(drugProp)
                end
            end
        end
 
        if not inRange then
            Citizen.Wait(1000)
        end
 
        Citizen.Wait(5)
    end
end)

Citizen.CreateThread(function() 
    if ped == false then 
        RequestModel(GetHashKey('s_m_y_dealer_01')) 
            while not HasModelLoaded('s_m_y_dealer_01') do 
                Citizen.Wait(100) 
            end 
        Ped = CreatePed(4, 0xE497BBEF, -430.5947265625,90.687477111816,63.263244628906,101.94372558594, false, true) 
        SetEntityHeading(Ped, 101.94372558594) 
        FreezeEntityPosition(Ped, true) 
        SetEntityInvincible(Ped, true) 
        SetBlockingOfNonTemporaryEvents(Ped, true) 
        RequestAnimDict("amb@world_human_hang_out_street@male_c@base") 
            while not HasAnimDictLoaded("amb@world_human_hang_out_street@male_c@base") do 
                Citizen.Wait(100) 
            end 
        TaskPlayAnim(Ped, "amb@world_human_hang_out_street@male_c@base", "base", 8.0, 8.0, -1, 1, 0, 0, 0, 0) 
        ped = true 
    end 
end)


--tommy
Citizen.CreateThread(function()
    while true do
        inRange = false
 
        local Player = GetPlayerPed(-1)
        local Position = GetEntityCoords(Player)
 
            local dist = GetDistanceBetweenCoords(Position, -430.5947265625,90.687477111816,64.263244628906)
            
            if dist < 2 then
                inRange = true
            
                DrawText3D(-430.5947265625,90.687477111816,64.263244628906, 'Tryk [~g~E~s~] for at lave en tommy gun')
                if IsControlJustReleased(0, 38) then
                    exports['progressBars']:startUI(35000, "Laver en tommy gun.")
                    FreezeEntityPosition(PlayerPedId(), true) 
                    RequestAnimDict("amb@prop_human_bum_bin@idle_b") 
                    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end 
                      TaskPlayAnim(Player,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0) 
                      Citizen.Wait(35000)
                      StopAnimTask(Player, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0) 
                      FreezeEntityPosition(PlayerPedId(), false)
                    TriggerServerEvent('tommydealer:make') 
            end
        end
 
        if not inRange then
            Citizen.Wait(1000)
        end
 
        Citizen.Wait(5)
    end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 20,20,20,150)
end
