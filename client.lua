display = false

function Display(bool)
  display = bool
  SendNUIMessage({
      type = "ui",
      status = bool
    })
end

RegisterCommand("radar",function(source, args)
  if IsPedInAnyVehicle(GetPlayerPed(-1)) then
    Display(not display)
  end
end)


local function GetVehicleInFront()
  local playerPed = GetPlayerPed(-1)
  local pos = GetEntityCoords(playerPed)
  local forwardVector = 150.0 

  local targetCoords = pos + (forwardVector * GetEntityForwardVector(playerPed))
  local rayHandle = StartShapeTestRay(pos.x, pos.y, pos.z, targetCoords.x, targetCoords.y, targetCoords.z, -1, playerPed, 0)
  local _, _, _, _, entityHit = GetShapeTestResult(rayHandle)

  return entityHit
end

local function IsVehicle(entity)
  return DoesEntityExist(entity) and IsEntityAVehicle(entity)
end

local function GetVehiclePlate(vehicle)
  if IsVehicle(vehicle) then
      local plate = GetVehicleNumberPlateText(vehicle)
      return plate
  end

  return nil
end

local function GetVehicleBehind()
  local playerPed = GetPlayerPed(-1)
  local pos = GetEntityCoords(playerPed)
  local forwardVector = 150.0 

  local targetCoords = pos - (forwardVector * GetEntityForwardVector(playerPed))
  local rayHandle = StartShapeTestRay(pos.x, pos.y, pos.z, targetCoords.x, targetCoords.y, targetCoords.z, -1, playerPed, 0)
  local _, _, _, _, entityHit = GetShapeTestResult(rayHandle)

  return entityHit
end

local function IsVehicle(entity)
  return DoesEntityExist(entity) and IsEntityAVehicle(entity)
end

local function GetVehiclePlate(vehicle)
  if IsVehicle(vehicle) then
      local plate = GetVehicleNumberPlateText(vehicle)
      return plate
  end

  return nil
end

RegisterCommand("getplate", function()
  local vehicle = GetVehicleBehind()

  if vehicle then
      local plate = GetVehiclePlate(vehicle)
      if plate then
          print("Nr: " .. plate)
          SendNUIMessage({
            text = plate
          })
      else
          print("Nu e masina ")
      end
  else
      print("Nimic")
  end
end, false)




Citizen.CreateThread(function()
  while true do
    local vehicle = GetVehicleInFront()
    local vehicle2 = GetVehicleBehind()
    -- IN VEHICLE

    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
      if vehicle then
        local plate = GetVehicleNumberPlateText(vehicle)
        local speed = math.floor(GetEntitySpeed(vehicle) * 3.6) 


 
        if plate and speed  then
          print("Nr: " .. plate)
          print("Speed: " .. speed .. " km/h")

          SendNUIMessage({
            plate = plate,
            speed = speed,
            name = name 
          })
        end
      end

      local plate2 = GetVehicleNumberPlateText(vehicle2)
      local speed2 = math.floor(GetEntitySpeed(vehicle2) * 3.6) 
      -- local name2 = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle2))

      if plate2 and speed2  then
        print("Nr: " .. plate2)
        print("Speed: " .. speed2 .. " km/h")

        SendNUIMessage({
          plate2 = plate2,
          speed2 = speed2,
          name2 = name2 
        })
      end

    end

    -- OUT OF VEHICLE
    if IsPedOnFoot(GetPlayerPed(-1)) then
      Display(false)
    end

    Citizen.Wait(100)
  
  end
end)