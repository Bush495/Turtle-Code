function Inspect(Tunnel, veinMineCheck, Path)
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
        Path = veinMine(forwardData, leftData, backData, rightData, upData, downData, Valuables)
        for i, value in pairs(Valuables) do   
            if (forwardData["name"] ~= ("minecraft:" .. Valuables[i])) and (leftData["name"] ~= ("minecraft:" .. Valuables[i])) and (backData["name"] ~= (("minecraft:" .. Valuables[i])) and rightData["name"] ~= ("minecraft:" .. Valuables[i])) and (upData["name"] ~= ("minecraft:" .. Valuables[i])) and (backData["name"] ~= ("minecraft:" .. Valuables[i])) then
                Path[6] = 1
            end
        end
        return Path
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
    Run = 0
    repeat
        newPath = {
            0,
            0,
            0,
            0,
            0,
            0
        }
        Path = {
            0,
            0,
            0,
            0,
            0,
            0
        }
         
        repeat    
            newPath = Inspect(Tunnel, veinMineCheck, Path)
            for i, value in pairs(Path) do
                Path[i] = newPath[i]
            end
        until Path[6] == 1
        navigationRecover(Path)
        turtle.forward()
        Run = Run + 1
    until Run >= 10
end
function veinMine(forwardData, leftData, backData, rightData, upData, downData, Valuables)
    leftTurnCounter = 0
    rightTurnCounter = 0
    forwardCounter = 0
    upCounter = 0   
    i = 0
    for i, value in pairs(Valuables) do     
        if (leftData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.turnLeft()
            leftTurnCounter = leftTurnCounter + 1
            turtle.dig()
            turtle.forward()
            forwardCounter = forwardCounter + 1
            Path = navigationHistory(leftTurnCounter, rightTurnCounter, forwardCounter, upCounter, downData, Path)
            return Path
        end
    end
    i = 0
    for i, value in pairs(Valuables) do    
        if (rightData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.turnRight()
            rightTurnCounter= rightTurnCounter + 1
            turtle.dig()
            turtle.forward()
            forwardCounter = forwardCounter + 1
            Path = navigationHistory(leftTurnCounter, rightTurnCounter, forwardCounter, upCounter, downData, Path)
            return Path
        end
    end
    i = 0
    for i, value in pairs(Valuables) do    
        if (upData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.digUp()
            return Path
        end
    end
    i = 0
    for i, value in pairs(Valuables) do    
        if (downData["name"] == ("minecraft:" .. Valuables[i])) then
            turtle.digDown()
            return Path
        end
    end
end
function navigationHistory(leftTurnCounter, rightTurnCounter, forwardCounter, upCounter, downData, Path)
    Path = {
        0,
        0,
        0,
        0,
        0,
        0
    }
    Path[1] = leftTurnCounter
    Path[2] = rightTurnCounter
    Path[3] = forwardCounter
    Path[4] = upCounter
    Path[5] = downData

    return Path
end   
function navigationRecover(Path)
    if (Path[1] ~= 0)  then    
        turtle.turnRight()
    end
    if (Path[2] ~= 0) then
        turtle.turnLeft()
    end
    if (Path[3] ~= 0) then
        turtle.back()
    end
    if (Path[5] ~= 0) then
        turtle.down()
    end
    if (Path[5] ~= 0) then
        turtle.up()
    end
end
function tunnelDown(fuel)    
    Y_Axis = 0
    Tunnel = true
    veinMineCheck = false
    repeat
        Inspect(Tunnel, veinMineCheck)
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
    print("Status: online Fuel:" .. fuel .. ",what would you like to do?")
    user_Choice = io.read()
    if user_choice == "tunnel down" then
        tunnelDown(fuel)
    elseif user_Choice == "tunnel forward" then
        tunnelForward(fuel)
    elseif user_Choice == "vein mine" then
        veinMineMain()
    end
end
Main()