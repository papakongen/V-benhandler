
--██████╗░░█████╗░██████╗░░█████╗░██╗░░██╗░█████╗░███╗░░██╗░██████╗░███████╗███╗░░██╗
--██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░██╔╝██╔══██╗████╗░██║██╔════╝░██╔════╝████╗░██║
--██████╔╝███████║██████╔╝███████║█████═╝░██║░░██║██╔██╗██║██║░░██╗░█████╗░░██╔██╗██║
--██╔═══╝░██╔══██║██╔═══╝░██╔══██║██╔═██╗░██║░░██║██║╚████║██║░░╚██╗██╔══╝░░██║╚████║
--██║░░░░░██║░░██║██║░░░░░██║░░██║██║░╚██╗╚█████╔╝██║░╚███║╚██████╔╝███████╗██║░╚███║
--╚═╝░░░░░╚═╝░░╚═╝╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝░╚═════╝░╚══════╝╚═╝░░╚══╝

local Tunnel = module("vrp", "lib/Tunnel") 
local Proxy = module("vrp", "lib/Proxy")
local narkopris = 45

vRP = Proxy.getInterface("vRP") 

--pistol
RegisterServerEvent('weapondealer:Weaponbuy')
AddEventHandler('weapondealer:Weaponbuy', function()
local source = source
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
local weaponprice = 150000
	vRP.prompt({player,"Er du sikker på, at du vil købe en våben kontrakt? (ja/nej) (150.000 DKK)","",function(player,answer)
		if string.lower(tostring(answer)) == "ja" then
			if vRP.giveInventoryItem({user_id,"våbenkontrakt",1}) then
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har allerede købt en våben kontrakt.", type = "error", queue = "global", timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			else
				if vRP.tryFullPayment({user_id,weaponprice}) then
					TriggerClientEvent("pNotify:SendNotification", player,{text = "Du købte en våben kontrakt", type = "error", queue = "global", timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
    			else
					TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har ikke råd.", type = "error", queue = "global", timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				end
			end
		end
	end})
end)

RegisterServerEvent('weapondealer:Bulletbuy')
AddEventHandler('weapondealer:Bulletbuy', function()
local source = source
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
local bulletprice = 75000
	vRP.prompt({player,"Er du sikker på, at du vil købe en ammunition kontrakt? (ja/nej) (75.000 DKK)","",function(player,answer)
		if string.lower(tostring(answer)) == "ja" then
			if vRP.giveInventoryItem({user_id,"ammunitionkontrakt",1}) then
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har allerede købt en ammunition kontrakt.", type = "error", queue = "global", timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			else
				if vRP.tryFullPayment({user_id,bulletprice}) then
					TriggerClientEvent("pNotify:SendNotification", player,{text = "Du købte en ammunition kontrakt", type = "error", queue = "global", timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
    			else
					TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har ikke råd.", type = "error", queue = "global", timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				end
			end
		end
	end})
end)

RegisterServerEvent('weapondealer:make') 
AddEventHandler('weapondealer:make', function() 
    local source = source 
    local user_id = vRP.getUserId({source}) 
    local antal = math.random(1) 
    local amount = math.random(1) 
    if vRP.hasInventoryItem({user_id, "papavåben", 1, false}) and vRP.hasInventoryItem({user_id, "papavåben2", 1, false}) and vRP.hasInventoryItem({user_id, "papavåben3", 1, false}) then
      Citizen.Wait(1500)
      if vRP.tryGetInventoryItem({user_id,"papavåben",antal}) and vRP.tryGetInventoryItem({user_id,"papavåben2",antal}) and vRP.tryGetInventoryItem({user_id,"papavåben3",antal})  then
        vRP.giveInventoryItem({user_id,"wbody|WEAPON_PISTOL50",amount}) 
    end
  end
end)

vRP.defInventoryItem({"våbenkontrakt","Våbenkontrakt","Bruges til at skaffe våben dele", function()

    local choices = {}

    choices["> Brug"] = {function(player,choice,mod)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id, "våbenkontrakt", 1, true}) then
            TriggerClientEvent("weapondealer:findweapon", player)
            vRP.closeMenu({player})
          end
        else
        end
    end}

    return choices
  end, 0.50})

  vRP.defInventoryItem({"ammunitionkontrakt","Ammunitionkontrakt","Bruges til at skaffe skud til våben", function()

    local choices = {}

    choices["> Brug"] = {function(player,choice,mod)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id, "ammunitionkontrakt", 1, true}) then
            TriggerClientEvent("weapondealer:ammunition", player)
            vRP.closeMenu({player})
          end
        else
        end
    end}

    return choices
  end, 0.50})

RegisterServerEvent('weapondealer:GetWeaponReward')
AddEventHandler('weapondealer:GetWeaponReward', function(user_id)

    local user_id = vRP.getUserId({source})

    local rItem = Config.WeaponRewards[math.random(1, #Config.WeaponRewards)] 

    local rWeaponAmount = math.random(Config.MinWeaponReward, Config.MaxWeaponReward)

    TriggerClientEvent('mythic_notify:client:DoCustomHudText', source, { type = 'success', text = 'Du har åbnet tasken og fik' ..rWeaponAmount.. ' af' ..rItem, length = 2500})

    vRP.giveInventoryItem({user_id, rItem, rWeaponAmount, true})
end)

RegisterServerEvent('weapondealer:GetAmmunitionReward')
AddEventHandler('weapondealer:GetAmmunitionReward', function(user_id)

    local user_id = vRP.getUserId({source})

    local rItem = Config.AmmunitionReward[math.random(1, #Config.AmmunitionReward)] 

    local rAmmunitionAmount = math.random(Config.MinAmmunitionReward, Config.MaxAmmunitionReward)

    TriggerClientEvent('mythic_notify:client:DoCustomHudText', source, { type = 'success', text = 'Du har åbnet tasken og fik' ..rAmmunitionAmount.. ' af' ..rItem, length = 2500})

    vRP.giveInventoryItem({user_id, rItem, rAmmunitionAmount, true})
end)



--tommygun
RegisterServerEvent('tommydealer:make') 
AddEventHandler('tommydealer:make', function() 
    local source = source 
    local user_id = vRP.getUserId({source}) 
    local antal = math.random(1) 
    local amount = math.random(1) 
      if vRP.tryGetInventoryItem({user_id,"papavåben",antal}) and vRP.tryGetInventoryItem({user_id,"papavåben2",antal}) and vRP.tryGetInventoryItem({user_id,"papavåben3",antal})  then
        vRP.giveInventoryItem({user_id,"wbody|WEAPON_GUSENBERG",amount}) 
    end
end)
