local resourceName = GetCurrentResourceName()

local function SendNotification(options, template)
    if type(options) ~= "table" and type(template) ~= "table" then
        return print("Error: options or template must be a table")
    end

    local finalOptions = {}
    
    if template and type(template) == "string" and Config.Templates[template] then
        for k, v in pairs(Config.Templates[template]) do
            finalOptions[k] = v
        end
    end
    
    for k, v in pairs(options) do
        finalOptions[k] = v
    end

    SendNUIMessage({
        type = "BLN_NOTIFY",
        options = finalOptions
    })
end

RegisterNetEvent(resourceName .. ":send")
AddEventHandler(resourceName .. ":send", function(options, template)
    SendNotification(options, template)
end)



-- TODO: in css, make the icon flips.
-- TODO: changes fonts to rdr style with ar support.
-- TODO: add frotend sounds in lua.
