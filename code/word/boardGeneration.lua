require "code.word.wordTable"

function boardGeneration (seed)
    math.randomseed(seed)
    words = {};
    while (#words < 4) do
        words = {wordList[math.ceil(#wordList*math.random())], wordList[math.ceil(#wordList*math.random())]}
        posOne = wordTable[string.sub(words[1], 2, 2)][string.sub(words[2], 2, 2)]
        if #posOne > 0 then
            words[3] = posOne[math.ceil(#posOne*math.random())]
        else
            goto continue
        end
        posTwo = wordTable[string.sub(words[1], 4, 4)][string.sub(words[2], 4, 4)]
        if #posTwo > 0 then
            words[4] = posTwo[math.ceil(#posTwo*math.random())]
        else
            goto continue
        end
        for i = 1,#words,1 do
            if words[i] == nil then
                words = {}
                goto continue
            end
        end
        ::continue::
    end
    return words
end

--[[
 0 4
12567
 3 8
CDE9A
 F B
--]]

function boardToKey (board)
    return {
        string.sub(board[1], 1, 1), string.sub(board[3], 1, 1), string.sub(board[1], 2, 2), string.sub(board[1], 3, 3),
        string.sub(board[2], 1, 1), string.sub(board[3], 3, 3), string.sub(board[3], 4, 4), string.sub(board[3], 5, 5),
        string.sub(board[2], 3, 3), string.sub(board[2], 4, 4), string.sub(board[4], 5, 5), string.sub(board[2], 5, 5),
        string.sub(board[4], 1, 1), string.sub(board[4], 2, 2), string.sub(board[4], 3, 3), string.sub(board[1], 5, 5)
    }
end