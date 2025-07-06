-- * Sistema de logging
local function log(modo, mensaje)
	if modo == "info" then
		print("✅ [INFO] " .. mensaje)
	elseif modo == "warn" then
		warn("⚠️ [ADVERTENCIA] " .. mensaje)
	elseif modo == "error" then
		warn("❌ [ERROR] " .. mensaje)
	elseif modo == "help" then
		print("🔷 [AYUDA] " .. mensaje)
	else
		print("🔘 [LOG] " .. mensaje)
	end
end

-- * Guardamos referencia para evitar duplicados por frame
local ultimaReferencia = nil

task.spawn(function()
	while true do
		task.wait(0.1)

		local mensaje = _G.mensaje

		if mensaje and type(mensaje) == "table" and mensaje ~= ultimaReferencia then
			local texto = mensaje.texto or "Sin texto"
			local modo = mensaje.modo or "info"
			log(modo, texto)

			-- * Actualizamos la referencia (evita imprimir más de una vez)
			ultimaReferencia = mensaje
		end
	end
end)
