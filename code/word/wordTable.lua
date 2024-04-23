require "code.word.wordList"

wordTable = {}
letters = "abcdefghijklmnopqrstuvwxyz"
for i = 1,26,1 do
    wordTable[string.sub(letters, i, i)] = {}
    for j = 1,26,1 do
        wordTable[string.sub(letters, i, i)][string.sub(letters, j, j)] = {}
    end
end
for i = 1,#wordList,1 do
    local word = wordList[i]
    local pos = wordTable[string.sub(word, 2, 2)][string.sub(word, 4, 4)]
    pos[#pos+1] = word
end