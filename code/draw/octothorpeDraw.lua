
--[[
 0 4
12567
 3 8
CDE9A
 F B
--]]

function octothorpeDraw (key, clue, select)
    --Key
    xPos = {
        1, 0, 1, 1,
        3, 2, 3, 4,
        3, 3, 4, 3,
        0, 1, 2, 1
    }
    yPos = {
        0, 1, 1, 2,
        0, 1, 1, 1,
        2, 3, 3, 4,
        3, 3, 3, 4
    }
    bgColorR = {0.4,0.4,0.4,0.4,0.6,0.6,0.6,0.6,0.8,0.8,0.8,0.8,1,1,1,1}
    love.graphics.setFont(bigFont)
    for i = 1,#key,1 do
        if select == i then
            love.graphics.setColor(0, 0, 0.5)
            love.graphics.rectangle("fill",(xPos[i]*120)+5, (yPos[i]*120)+5, 110, 110, 5, 5)
        end
        love.graphics.setColor(bgColorR[i], 1, 0.5)
        love.graphics.rectangle("fill",(xPos[i]*120)+10, (yPos[i]*120)+10, 100, 100, 5, 5)
        love.graphics.setColor(0, 0, 0.5)
        love.graphics.printf(string.upper(key[i]),(xPos[i]*120)+10, (yPos[i]*120)+15, 100,"center")
    end
    --Clue
    love.graphics.setFont(smallFont)
    for i = 0,#clue-1,4 do
        for j = 1,4,1 do
            love.graphics.setColor(bgColorR[i+j], 1, 0.5)
            x = ternary((j % 2 == 0), 5, 65)
            if i == 4 or i == 8 then
                x =x+ 480
            end
            y = ternary((j > 2), 5, 65)
            if i > 7 then
                y =y+ 480
            end
            love.graphics.rectangle("fill",x, y, 50, 50, 5, 5)
            love.graphics.setColor(0, 0, 0.5)
            love.graphics.printf(string.upper(clue[i+j]),x, y+15, 50,"center")
        end
    end
    --Submit
    love.graphics.setColor(0, 0, 0.5)
    love.graphics.line(280, 240, 280, 360)
    love.graphics.line(320, 240, 320, 360)
    love.graphics.line(240, 280, 360, 280)
    love.graphics.line(240, 320, 360, 320)
end

function ternary (boolCheck, trueVal, falseVal)
    if boolCheck then
        return trueVal
    else
        return falseVal
    end
end

function getOctothorpeSelect (x, y)
    xPos = {
        1, 0, 1, 1,
        3, 2, 3, 4,
        3, 3, 4, 3,
        0, 1, 2, 1
    }
    yPos = {
        0, 1, 1, 2,
        0, 1, 1, 1,
        2, 3, 3, 4,
        3, 3, 3, 4
    }
    adjustX = math.floor(x/120)
    adjustY = math.floor(y/120)
    for i = 1,#xPos,1 do
        if xPos[i] == adjustX and yPos[i] == adjustY then
            return i
        end
    end
end