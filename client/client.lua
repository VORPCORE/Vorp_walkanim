local isInMenu = false
MenuData = {}

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

AddEventHandler('menuapi:closemenu', function()
    if isInMenu then
        isInMenu = false
    end
end)


function OpenMenu()
    MenuData.CloseAll()
    isInMenu = true
    local elements = {
        { label = _U("Casual"), value = "A1", desc = _U("chooseAnim"), info = "MP_Style_Casual" },
        { label = _U("Crazy"), value = "A2", desc = _U("chooseAnim"), info = "MP_Style_Crazy" },
        { label = _U("Drunk"), value = "A3", desc = _U("chooseAnim"), info = "mp_style_drunk" },
        { label = _U("EasyRider"), value = "A4", desc = _U("chooseAnim"), info = "MP_Style_EasyRider" },
        { label = _U("Flamboyant"), value = "A5", desc = _U("chooseAnim"), info = "MP_Style_Flamboyant" },
        { label = _U("Greenhorn"), value = "A6", desc = _U("chooseAnim"), info = "MP_Style_Greenhorn" },
        { label = _U("Gunslinger"), value = "A7", desc = _U("chooseAnim"), info = "MP_Style_Gunslinger" },
        { label = _U("Inquisitive"), value = "A8", desc = _U("chooseAnim"), info = "mp_style_inquisitive" },
        { label = _U("Refined"), value = "A9", desc = _U("chooseAnim"), info = "MP_Style_Refined" },
        { label = _U("SilentType"), value = "A10", desc = _U("chooseAnim"), info = "MP_Style_SilentType" },
        { label = _U("Veteran"), value = "A11", desc = _U("chooseAnim"), info = "MP_Style_Veteran" },
        { label = _U("RemoveWalk"), value = "removeA", desc = _U("removedesc"), info = "noanim" },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi', {
        title    = _U("MenuTitle"),
        subtext  = _U("SubMenuTitle"),
        align    = Config.Align,
        elements = elements,

    },
        function(data, menu)

            if data.current.value then
                local animation = data.current.info
                TriggerEvent("vorp_walkanim:setAnim", animation)

                DisplayRadar(true)
                isInMenu = false
                menu.close()
            end

        end,

        function(data, menu)
            menu.close()
            isInMenu = false
            DisplayRadar(true)
        end)

end

RegisterNetEvent("vorp_walkanim:getwalk2")
AddEventHandler("vorp_walkanim:getwalk2", function(walk)
    local animation = walk
    local player = PlayerPedId()
    if animation == "noanim" then
        Citizen.InvokeNative(0xCB9401F918CB0F75, player, animation, 0, -1)
        Wait(500)
        TriggerServerEvent("vorp_walkanim:setwalk", animation)
    else
        Citizen.InvokeNative(0xCB9401F918CB0F75, player, animation, 1, -1)
    end

end)

AddEventHandler("vorp_walkanim:setAnim", function(animation)
    local player = PlayerPedId()

    if animation == "noanim" then
        Citizen.InvokeNative(0xCB9401F918CB0F75, player, animation, 0, -1)
        Wait(500)
        TriggerServerEvent("vorp_walkanim:setwalk", animation)
        Wait(500)
        ExecuteCommand("rc")
    else

        Citizen.InvokeNative(0xCB9401F918CB0F75, player, animation, 0, -1)
        Wait(500)
        Citizen.InvokeNative(0xCB9401F918CB0F75, player, animation, 1, -1)
        TriggerServerEvent("vorp_walkanim:setwalk", animation)
        Wait(500)
        ExecuteCommand("rc")
    end

end)

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        Citizen.Wait(10000)
        TriggerServerEvent("vorp_walkanim:getwalk")
    end
end)

TriggerEvent("chat:addSuggestion", "/" .. Config.command, Config.walkanimsuggestion, {})

RegisterCommand(Config.command, function()

    if isInMenu == false then
        OpenMenu()
        DisplayRadar(false)
        

    end
end)

Command = false


TriggerEvent("chat:addSuggestion", "/" .. Config.slowWalkCommand, Config.slowcommandSuggestion, {})
RegisterCommand(Config.slowWalkCommand, function()

    if not Command then
        Command = true
        while Command do
            Citizen.Wait(15)
            SetPedMaxMoveBlendRatio(PlayerPedId(), 0.2)

        end
    else
        Command = false
        SetPedMaxMoveBlendRatio(PlayerPedId(), 3.0)

    end
end)
