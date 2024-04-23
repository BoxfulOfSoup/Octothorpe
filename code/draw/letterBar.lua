function drawLetterBar ()
    letter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    for i = 1,#letter,2 do
        love.graphics.setColor(0.7, 1, 0.5)
        love.graphics.rectangle("fill",610,(((i-1)/2)*(600/13))+2.5,80,(600/15), 5, 5)
        love.graphics.setColor(0, 0, 0.5)
        love.graphics.printf(string.sub(letter,i,i),610,(((i-0.5)/2)*(600/13)),80,"center")
    end
    for i = 2,#letter,2 do
        love.graphics.setColor(0.7, 1, 0.5)
        love.graphics.rectangle("fill",710,(((i-2)/2)*(600/13))+2.5,80,(600/15), 5, 5)
        love.graphics.setColor(0, 0, 0.5)
        love.graphics.printf(string.sub(letter,i,i),710,(((i-1.5)/2)*(600/13)),80,"center")
    end
end

function getLetterBarButton (x, y)
    letter = "abcdefghijklmnopqrstuvwxyz"
    if x < 600 then
        return nil
    end
    snappedY = math.floor(y/(600/13))
    if x < 700 then
        return string.sub(letter, (2*snappedY)+1, (2*snappedY)+1)
    else
        return string.sub(letter, (2*snappedY)+2, (2*snappedY)+2)
    end
end