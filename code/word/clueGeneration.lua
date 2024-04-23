math.randomseed(os.time())

function clueGeneration(key)
    clue = {}
    for i = 0,12,4 do
        randomOffset = {1, 2, 3, 4}
        for j = 1,3,1 do
            switch = 1+math.ceil(math.random()*(4-j))
            store = randomOffset[switch]
            randomOffset[switch] = randomOffset[j]
            randomOffset[j] = store
        end
        for j = 1,4,1 do
            clue[#clue+1] = key[i+randomOffset[j]]
        end
    end
    return clue
end