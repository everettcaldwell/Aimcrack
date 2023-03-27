local xor = {}

function xor.encrypt(plaintext, key)
    local keylen = string.len(key)
    local encrypted = ""
    for i = 0, (string.len(plaintext)-1) do
        local j = i % keylen
        i=i+1
        j=j+1
        local xortext = bit32.bxor(plaintext:sub(i,i):byte(), key:sub(j,j):byte())
        local hex = string.format("%02x", xortext)
        encrypted = encrypted..hex
    end

    return encrypted
end

function xor.decrypt(encryptedtext, key)
    local nums = {}
    for i = 0, string.len(encryptedtext)/2-1 do
        local num = tonumber(encryptedtext:sub(i*2+1,i*2+2),16)
        table.insert(nums, num)
    end
    local keylen = string.len(key)
    local decrypted = ""
    for i = 0, (#nums-1) do
        local j = i % keylen
        i=i+1
        j=j+1
        local plaintext = string.char(bit32.bxor(nums[i], key:sub(j,j):byte()))
        decrypted = decrypted..plaintext
    end
    return decrypted
end

return xor
