require "code.word.boardGeneration"
require "code.word.clueGeneration"
require "code.draw.font"
require "code.draw.letterBar"
require "code.draw.octothorpeDraw"

select = 1
scene = 1

time = 0
correct = nil
wrongGuess = 0

guess = {"","","","","","","","","","","","","","","",""}

answerKey = boardToKey(boardGeneration(os.time()))
clue = clueGeneration(answerKey)

function love.load()
    love.graphics.setBackgroundColor(0.5,0.9,.5)
end

function love.update(delta)
    if scene == 2 then
        time =time+ delta
    end
end

function love.draw()
    switch = {
        function()--1 Start
            love.graphics.setColor(0.7, 1, 0.5)
            love.graphics.rectangle("fill", 5, 5, 390, 590, 10, 10)
            love.graphics.rectangle("fill", 405, 5, 390, 590, 10, 10)
            love.graphics.setColor(0, 0, 0.5)
            love.graphics.setFont(smallFont)
            love.graphics.print("DAILY", 20, 20)
                love.graphics.setLineWidth(5)
                love.graphics.circle("line", 200, 300, 100)
                love.graphics.arc("line", 200, 200, 10, math.pi*1, math.pi*2)
                for i = 1,12,1 do
                    angle = (-.5*math.pi)+((i/6)*math.pi)
                    outer = {x = math.cos(angle)*90; y = math.sin(angle)*90}
                    inner = {x = math.cos(angle)*80; y = math.sin(angle)*80}
                    love.graphics.line(200+outer.x, 300+outer.y, 200+inner.x, 300+inner.y)
                end
                date = os.date("*t")
                angle = (-.5*math.pi)+((date.hour/6)*math.pi)
                outer = {x = math.cos(angle)*30; y = math.sin(angle)*30}
                love.graphics.line(200+outer.x, 300+outer.y, 200, 300)
                angle = (-.5*math.pi)+((date.min/30)*math.pi)
                outer = {x = math.cos(angle)*70; y = math.sin(angle)*70}
                love.graphics.line(200+outer.x, 300+outer.y, 200, 300)
            love.graphics.print("RANDOM", 420, 20)
                love.graphics.setLineWidth(5)
                love.graphics.rectangle("line", 500, 200, 200, 200, 30, 30)
                for x = 550, 650, 100 do
                    for y = 250, 350, 50 do
                        love.graphics.circle("line", x, y, 15)
                    end
                end
        end,
        function()--2 Game
            drawLetterBar()
            octothorpeDraw(guess, clue, select)
            if correct ~= nil then
                love.graphics.setFont(smallFont)
                love.graphics.printf(math.floor(100*(correct/16)).."%", 240, 50, 120, "center")
            end
        end,
        function()--3 End
            love.graphics.setColor(0.7, 1, 0.5)
            love.graphics.rectangle("fill", 5, 505, 790, 90, 10, 10)
            love.graphics.setColor(0, 0, 0.5)
            love.graphics.setFont(bigFont)
            love.graphics.printf("You did it!", 5, 45 , 800, "center")
            love.graphics.printf("Time : "..math.floor(time/60)..":"..math.floor(time%60), 5, 145 , 800, "center")
            love.graphics.printf("Wrong guesses : "..wrongGuess, 5, 245 , 800, "center")
            love.graphics.setFont(smallFont)
            love.graphics.printf("Back to home", 5, 540 , 800, "center")
        end
    }
    switch[scene]()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(1,0,0)
    if love.keyboard.isDown("up") then
        if love.keyboard.isDown("left") then
            for i = 1,#answerKey,1 do
                love.graphics.print(answerKey[i], 0, i*15)
            end
        end
    end
end

function love.mousereleased(x, y, button)
    switch = {
        function(x, y)--1 Start
            time = 0
            correct = nil
            wrongGuess = 0
            guess = {"","","","","","","","","","","","","","","",""}
            if x < 400 then
                date = os.date("*t")
                todaySeed = (date.year*480)+(date.month*40)+date.day
                answerKey = boardToKey(boardGeneration(todaySeed))
            else
                answerKey = boardToKey(boardGeneration(os.time()))
            end
            clue = clueGeneration(answerKey)
            scene = 2
        end,
        function(x, y)--2 Game
            letterBarButton = getLetterBarButton(x, y)
            if letterBarButton ~= nil then
                guess[select] = letterBarButton
                return
            end
            selectLocation = getOctothorpeSelect(x, y)
            if selectLocation ~= nil then
                select = selectLocation
                return
            end
            if x > 240 and y > 240 and x < 360 and y < 360 then
                if correct == 16 then
                    scene = 3
                    return
                end
                correct = 0
                for i = 1,#answerKey,1 do
                    if answerKey[i] == guess[i] then
                        correct =correct+ 1
                    end
                end
                if correct ~= 16 then
                    wrongGuess =wrongGuess+ 1
                    return
                end
            end
        end,
        function(x, y)--3 End
            if y > 500 then
                scene = 1
            end
        end
    }
    switch[scene](x, y)
end

function love.keyreleased(key)
    if key == "escape" then
        scene = 1
        return
    end
    if scene ~= 2 then
        return
    end
    letter = "abcdefghijklmnopqrstuvwxyz"
    for i = 1,#letter,1 do
        if string.sub(letter, i, i) == key then
            guess[select] = key
            break
        end
    end
    if key == "space" then
        clue = clueGeneration(answerKey)
    end
end