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

-- * Guardamos la última tabla para detectar nuevas asignaciones
local ultimaReferencia = nil

-- * Listener principal
task.spawn(function()
	while true do
		task.wait(0.5)

		local mensaje = _G.mensaje

		if mensaje and type(mensaje) == "table" and mensaje ~= ultimaReferencia then
			-- ejecutamos log si la tabla fue reasignada (nueva ref)
			local texto = mensaje.texto or "Sin texto"
			local modo = mensaje.modo or "info"
			log(modo, texto)

			-- Actualizamos la referencia
			ultimaReferencia = mensaje
		end
	end
end)
