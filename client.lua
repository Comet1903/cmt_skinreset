ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1)
    if Config.enableBlips then
        local blip = AddBlipForCoord(Config.blipLocation)
        SetBlipSprite(blip, Config.blip)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, Config.blipColor)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Config.blipLabel)
        EndTextCommandSetBlipName(blip)
    end
    if Config.enableNpcs then
        for _, v in pairs(Config.locations) do
            RequestModel(GetHashKey(v[6]))
            while not HasModelLoaded(GetHashKey(v[6])) do
                Wait(1)
            end

            RequestAnimDict("mini@strip_club@idles@bouncer@base")
            while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
                Wait(1)
            end
            ped = CreatePed(4, v[5], v[1], v[2], v[3], 3374176, false, true)
            SetEntityHeading(ped, v[4])
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            TaskPlayAnim(ped, "mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for i = 1, #Config.locations, 1 do
            local location = vector3(Config.locations[i][1], Config.locations[i][2], Config.locations[i][3])
            local distance = GetDistanceBetweenCoords(coords, location, true)
            if distance < 2 then
                ESX.ShowHelpNotification("Drücke ~g~E~w~ um ~r~Schönheits Op~w~ zu starten")
                if IsControlJustReleased(0, 38) then
                    ESX.TriggerServerCallback('cmt_skinreset:canResetSkin', function(reset)
                        if reset then
                            ESX.ShowNotification("Schönheits OP für " .. Config.price .. "$ gekauft", "RZR | Schönheitschirurgie")
                            TriggerEvent('esx_skin:openSaveableMenu')
                        else
                            ESX.ShowNotification("Eine Schönheits OP kostet " .. Config.price .. "$", "RZR | Schönheitschirurgie")
                        end
                    end)
                end
            end
        end
    end
end)

