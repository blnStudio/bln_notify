local resourceName = GetCurrentResourceName()

RegisterNetEvent(resourceName .. ":send")
AddEventHandler(resourceName .. ":send", function(source, options, template)
    if source == nil then
        return print("Error: source must be provided (use -1 for all players)")
    end

    TriggerClientEvent(resourceName .. ":send", source, options, template)
end)

