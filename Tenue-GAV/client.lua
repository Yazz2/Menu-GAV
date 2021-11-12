ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)





function GAV()

  local model = GetEntityModel(GetPlayerPed(-1))

  TriggerEvent('skinchanger:getSkin', function(skin)

      if model == GetHashKey("mp_m_freemode_01") then


          clothesSkin = {---- homme
            
            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            ['torso_1'] = 111, ['torso_2'] = 0,
            ['arms'] = 11,
            ['pants_1'] = 3, ['pants_2'] = 0,
            ['shoes_1'] = 8, ['shoes_2'] = 0,

          }
    else


          clothesSkin = {---- femme
          
            ['tshirt_1'] = 15,['tshirt_2'] = 0,
            ['torso_1'] = 56, ['torso_2'] = 0,
            ['arms'] = 0, ['arms_2'] = 0,
            ['pants_1'] = 3, ['pants_2'] = 2,
            ['shoes_1'] = 4, ['shoes_2'] = 1,

          }

      end

      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

  end)

end

function vcivil()

ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

TriggerEvent('skinchanger:loadSkin', skin)

end)

end

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('Tenue', 'Tenue de Garde à vue')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
  FreezeEntityPosition(PlayerPedId(), false)

end



function OpenMenuGAV()
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

                RageUI.Separator("~b~"..ESX.PlayerData.job.label.." - "..ESX.PlayerData.job.grade_label.." - "..GetPlayerName(PlayerId()))
              RageUI.Separator("↓~b~ Civil ~s~↓")
              RageUI.Button("Tenue Civil", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    vcivil()
                    ESX.ShowNotification("~b~Tu as mis ta tenue Civil")

                  end
                })	

                RageUI.Separator("↓~r~ GAV ~s~↓")
                
                RageUI.Button("Tenue de GAV", nil, {RightLabel = "→→"}, true , {
                  onSelected = function()
                    GAV()
                    ESX.ShowNotification("~b~Tu as reçu(e) ta tenue de GAV")
                    end
                  })	


                  RageUI.Button("Fermer", nil, {Color = {BackgroundColor = {255, 0, 0, 50}}, RightLabel = "→→"}, true , {
                    onSelected = function()
                        RageUI.CloseAll()
                    end
                })
            
            end)
          Wait(0)
         end
      end)
   end
end


local position = {
	{x = -1086.6, y = -832.09, z = 5.48}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData  then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
       if dist <= 1.0 then
               wait = 1
                ESX.ShowHelpNotification("Appuyer sur~b~ ~INPUT_PICKUP~ pour mettre la tenue de garde à vue") 
                if IsControlJustPressed(1,51) then
                  OpenMenuGAV()
            end
        end
      end
    Citizen.Wait(wait)
    end
  end
end)


