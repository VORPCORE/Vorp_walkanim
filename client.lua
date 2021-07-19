

local animation 
local pedid
RegisterCommand(Config.command, function(source, args) 
    WarMenu.OpenMenu('walkanimation')
end)




Citizen.CreateThread( function()
    WarMenu.CreateMenu('walkanimation', Config.Language.walkanimation)
    WarMenu.CreateSubMenu('animations', 'walkanimation', Config.Language.walkanimation)


    while true do
        if WarMenu.IsMenuOpened('walkanimation') then
            if WarMenu.MenuButton(Config.Language.walkanimation, 'animations') then end
            if WarMenu.Button(Config.Language.confirm) then
                if animation ~= nil and animation ~= "noanim" then
                    TriggerServerEvent("vorp_walkanim:setwalk",animation)
                end
                WarMenu.CloseMenu() 
            end
        elseif WarMenu.IsMenuOpened('animations') then
            for k,v in pairs(Config.animations2) do 
                if WarMenu.Button(""..k.."") then
                    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
                    print(animation)
                    Wait(500)
                    animation = v
                    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
                    print(animation)

                end
            end
       
        end ----- end of menu
        WarMenu.Display()
        Citizen.Wait(0)
    end
end)

function contains(table, element)
    for k, v in pairs(table) do
          if v == element then
            return true
        end
    end
return false
end

--[[ Citizen.CreateThread(function() 
    while true do 
        Citizen.Wait(10)
        if animation ~= nil and animation ~= "noanim" then
            Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
        end
        Wait(30000)
    end
end) ]]

--[[ AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            Citizen.Wait(10000)
            TriggerServerEvent("vorp_walkanim:getwalk")
        end
    end
) ]]

--[[ RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    TriggerServerEvent("vorp_walkanim:getwalk")
end) ]]

RegisterNetEvent("vorp_walkanim:getwalk2")
AddEventHandler("vorp_walkanim:getwalk2", function(walk)
    animation = walk
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
end)

RegisterNetEvent("vorp_walkanim:secondchance2")
AddEventHandler("vorp_walkanim:secondchance2", function()
    TriggerServerEvent("vorp_walkanim:secondchance")
end)