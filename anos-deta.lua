local sampev = require("lib.samp.events")

script_name("Admin Detector by Anos")
script_author("Anos")
script_version("1.5")

local adminList = {}
local adminKeywords = {
    "admin", "moderator", "helper", "owner", "staff", "mod", "gm", "gamemaster",
    "supervisor", "leader", "founder", "developer", "dev", "management"
}
local warningActive = true
local lastWarningTime = 0
local scanDelay = math.random(3000, 5000)

local adminColors = {
    0xFF0000FF, 0xFF00FFFF, 0xFFFF00FF, 0xFF8000FF, 0xFF0080FF,
    0x00FF00FF, 0x8000FFFF, 0xFF4080FF, 0x80FF00FF, 0x0080FFFF
}

function main()
    sampAddChatMessage("Script adet from anos ready ", -1)
    while not isSampAvailable() do wait(100) end

    sampRegisterChatCommand("adet", function()
        warningActive = not warningActive
        local status = warningActive and "{00FF00}AKTIF" or "{FF0000}NONAKTIF"
        sampAddChatMessage("{FFFFFF}[{FF6B35}ADMIN-DET{FFFFFF}] Status: "..status, -1)
        if warningActive then
            scanAllPlayers()
        end
    end)

    while true do
        wait(scanDelay)
        if warningActive then
            scanAllPlayers()
            scanDelay = math.random(3000, 5000)
        end
    end
end

function scanAllPlayers()
    local currentTime = os.clock() * 1000
    if currentTime - lastWarningTime < 2000 then return end

    local newAdmins = {}
    for i = 0, sampGetMaxPlayerId() do
        if sampIsPlayerConnected(i) then
            local playerName = sampGetPlayerNickname(i)
            local playerColor = sampGetPlayerColor(i)
            
            if isLikelyAdmin(playerName, playerColor) and not adminList[i] then
                newAdmins[#newAdmins + 1] = {id = i, name = playerName}
                adminList[i] = {name = playerName, joinTime = currentTime}
            elseif not sampIsPlayerConnected(i) and adminList[i] then
                adminList[i] = nil
            end
        end
    end

    if #newAdmins > 0 and warningActive then
        showAdminWarning(newAdmins)
        lastWarningTime = currentTime
    end
end

function isLikelyAdmin(playerName, playerColor)
    local lowerName = string.lower(playerName)
    
    for _, keyword in ipairs(adminKeywords) do
        if string.find(lowerName, keyword) then
            return true
        end
    end
    
    for _, adminColor in ipairs(adminColors) do
        if playerColor == adminColor then
            return true
        end
    end
    
    if string.find(lowerName, "%[%w+%]") or string.find(lowerName, "_%w+_") then
        return true
    end
    
    return false
end

function showAdminWarning(admins)
    sampAddChatMessage("{FF0000}    PERINGATAN! ADMIN TERDETEKSI ONLINE!", -1)
    
    for _, admin in ipairs(admins) do
        sampAddChatMessage("{FFFF00}     ID: {FF0000}"..admin.id.." {FFFF00}| Nama: {FF0000}"..admin.name, -1)
    end
    
    sampAddChatMessage("{FF0000}    Hati-hati dengan aktivitas mencurigakan!", -1)
    
    playWarningSound()
end

function playWarningSound()
    addOneOffSound(0, 0, 0, 1147)
end

function sampev.onPlayerJoin(playerId, color, isNpc, nickname)
    if not isNpc and warningActive then
        lua_thread.create(function()
            wait(1000)
            if isLikelyAdmin(nickname, color) then
                adminList[playerId] = {name = nickname, joinTime = os.clock() * 1000}
                showAdminWarning({{id = playerId, name = nickname}})
            end
        end)
    end
end

function sampev.onPlayerQuit(playerId, reason)
    if adminList[playerId] then
        sampAddChatMessage("{00FF00}[INFO] Admin "..adminList[playerId].name.." telah disconnect", -1)
        adminList[playerId] = nil
    end
end
