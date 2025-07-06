local function generarCaja()
    local infoo = [[


─────────────────────────
        CAJA DE VALORES      
─────────────────────────

]]

    --? Iteramos sobre todas las variables globales
    for clave, valor in pairs(_G) do
        if type(valor) == "string" or type(valor) == "number" then
            infoo ..= "--> " .. string.upper(clave) .. ": " .. tostring(valor) .. "\n\n"
        end
    end

    infoo ..= [[
─────────────────────────


]]

    return infoo
end

print(generarCaja())