function Inspect(Tunnel, veinMineCheck)
    Valuables = {
        "diamond_ore",
        "coal_ore",
        "gold_ore",
        "iron_ore",
        "redstone_ore",
        "lapis_lazuli_ore",
        "deepslate_diamond_ore",
        "deepslate_coal_ore",
        "deepslate_gold_ore",
        "deepslate_iron_ore",
        "deepslate_redstone_ore",
        "deepslate_lapis_lazuli_ore"
    }
    forwardBlock, forwardData = turtle.inspect()
    turtle.turnLeft()
    leftBlock, leftData = turtle.inspect()
    turtle.turnLeft()
    backBlock, backData = turtle.inspect()
    turtle.turnLeft()
    rightBlock, rightData = turtle.inspect()
    turtle.turnLeft()
    upBlock, upData = turtle.inspectUp()
    downBlock, downData = turtle.inspectDown()
    if Tunnel == true then
        lineMine(forwardData, leftData, backData, rightData, upData, downData, Valuables)
    elseif veinMineCheck == true then    
        for i, value in pairs(Valuables) then
            repeat
                veinMine(forwardData, leftData, backData, rightData, upData, downData, Valuables)
            until (forwardData["name"] ~= ("minecraft:" .. Valuables[i])) and (backData["name"] ~= ("minecraft:" .. Valuables[i])) and (rightData["name"] ~= ("minecraft:" .. Valuables[i])) and (leftData["name"] ~= ("minecraft:" .. Valuables[i])) and (upData["name"] ~= ("minecraft:" .. Valuables[i])) and (downData["name"] ~= ("minecraft:" .. Valuables[i]))
        end
    end
end
function lineMine(forwardData, leftData, backData, rightData, upData, downData, Valuables)
    i=0
    for i, value in pairs(Valuables) do   
        if (forwardData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.dig()
        end
    end
    i=0
    for i, value in pairs(Valuables) do    
        if (leftData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.turnLeft()
            turtle.dig()
            turtle.turnRight()  
        end
    end
    i=0
    for i, value in pairs(Valuables) do    
        if (backData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.turnLeft()
            turtle.turnLeft()
            turtle.dig()
            turtle.turnLeft()
            turtle.turnLeft()
        end
    end
    i=0
    for i, value in pairs(Valuables) do    
        if (rightData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.turnRight()
            turtle.dig()
            turtle.turnLeft()
        end
    end    
    i=0
    for i, value in pairs(Valuables) do    
        if (upData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.digUp()
        end
    end
    i=0
    for i, value in pairs(Valuables) do    
        if (downData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.digDown()
        end
    end
end
function veinMineMain()
    Tunnel = false
    veinMineCheck = true
    X_Axis = 0
    X1, Y1, Z1 = gps.locate()
    repeat 
        Inspect(Tunnel, veinMineCheck)
        turtle.forward()
        X_Axis = X_Axis + 1
    until X_Axis >= 10
    veinMineRecover1(X, Y, Z)
end
function veinMine(forwardData, leftData, backData, rightData, upData, downData, Valuables)   
    i = 0
    for i, value in pairs(Valuables) do     
        if (forwardData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.dig()
        end
    end
    for i, value in pairs(Valuables) do     
        if (leftData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.turnLeft()
            turtle.dig()
            turtle.forward()
        end
    end
    i = 0
    for i, value in pairs(Valuables) do    
        if (rightData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.turnRight()
            turtle.dig()
            turtle.forward()
        end
    end
    i = 0
    for i, value in pairs(Valuables) do    
        if (upData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.digUp()
        end
    end
    i = 0
    for i, value in pairs(Valuables) do    
        if (downData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.digDown()
        end
    end
end
function veinMineRecover1(X1, Y1, Z1)
    Facing = "null"
    X3, Y3, Z3 = gps.locate()
    Front = turtle.detect()
    turtle.dig()
    turtle.forward()
    X4, Y4, Z4 = gps.locate()
    XF = X4 - X3
    ZF = Z4 - Z3
    -- postive X
    if XF > 0 then
        Facing = "East"
    -- negative X
    elseif XF < 0 then
        Facing = "West"
    -- postive Z
    elseif ZF > 0 then
        Facing = "South"
    -- negative Z
    elseif ZF < 0 then
        Facing = "North"
    end
    if Facing == "North" then 
        turtle.right()
    elseif Facing == "South" then
        turtle.left()
    elseif Facing == "West" then
        turtle.left()
        turtle.left()
    end
    X2, Y2, Z2 = gps.locate()
    XR = X2 - X1
    YR = Y2 - Y1
    ZR = Z2 - Z1
    repeat    
        -- moved East counter with West
        if XR > 0 then
            turtle.turnRight()
            turtle.turnRight()
            turtle.dig()
            turtle.forward()
            turtle.turnRight()
            turtle.turnRight()
            XR = XR - 1
        -- moved West counter with East
        elseif XR < 0 then
            turtle.dig()
            turtle.forward()
            XR = XR + 1
        -- moved South counter with North
        elseif ZR > 0 then
            turtle.right()
            turtle.dig()
            turtle.forward()
            turtle.left()
            ZR = ZR - 1
        -- moved North counter with South
        elseif ZR < 0 then
            turtle.left()
            turtle.dig()
            turtle.forward()
            turtle.right()
            ZR = ZR + 1
        end
    until (XR == 0) and (XR == 0)
end 
function tunnelDown(fuel)    
    Y_Axis = 0
    repeat
        downBlock, downData = turtle.inspectDown()
        turtle.digDown()
        turtle.suckDown(64, 1)
        turtle.down()
        Y_Axis = Y_Axis + 1
    until (downData["name"] == "minecraft:bedrock") or ((fuel/2) < Y_Axis)
    tunnelDownRecover(Y_Axis)
end
function tunnelDownRecover(Y_Axis)
    repeat
        turtle.up()    
        Y_Axis = Y_Axis - 1
    until Y_Axis == 1
end
function tunnelForward()
    X_Axis = 0
    Tunnel = true
    veinMine = false
    repeat    
        Inspect(Tunnel, veinMineCheck)
        turtle.dig()
        turtle.forward()
        X_Axis = X_Axis +1
    until X_Axis >= 100 or ((fuel/2) < X_Axis) 
    tunnelForwardRecover(X_Axis)
end
function tunnelForwardRecover(X_Axis)
    repeat
        turtle.back()
        X_Axis = X_Axis - 1
    until X_Axis == 1
end
function Main()
    fuel = turtle.getFuelLevel()
    print("Status: online Fuel: " .. fuel .. ", what would you like to do?")
    user_Choice = io.read()
    if user_Choice == "tunnel down" then
        tunnelDown(fuel)
    elseif user_Choice == "tunnel forward" then
        tunnelForward(fuel)
    elseif user_Choice == "vein mine" then
        veinMineMain()
    else 
        Main()
    end
end
Main()