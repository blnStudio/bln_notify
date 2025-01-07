local function LoadVersionChecker()
    local resourceName = GetCurrentResourceName()
    PerformHttpRequest('https://raw.githubusercontent.com/blnStudio/version-check/refs/heads/main/main.lua', function(errorCode, result, headers)
        if errorCode ~= 200 then
            print('^1[VERSION CHECKER] Failed to load version checker for ' .. resourceName .. '^0')
            return
        end
        local code = "local RESOURCE_NAME = '" .. resourceName .. "'\n" .. result
        load(code)()
    end, 'GET')
end
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        LoadVersionChecker()
    end
end)