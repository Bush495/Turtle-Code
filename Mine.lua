function Mine()
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
        if(backData["name"] == ("minecraft:" .. Valuables[i])) then
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
function tunnelDown(fuel)    
    Y_Axis = 0
    repeat
        Mine()
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
    repeat    
        Mine()
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
    user_Choice = io.read()
    if user_choice == "tunnel down" then
        tunnelDown(fuel)
    elseif user_Choice == "tunnel forward" then
        tunnelForward(fuel)
    end
end
Main()