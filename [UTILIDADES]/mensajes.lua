-- * Sistema de logging mejorado
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

-- * Guardamos el último mensaje para evitar repeticiones
local ultimoTexto = ""

-- * Listener principal
task.spawn(function()
	while true do
		task.wait(0.5)

		-- ? Verificamos si hay un mensaje en _G
		if _G.mensaje and type(_G.mensaje) == "table" then
			local texto = _G.mensaje.texto
			local modo = _G.mensaje.modo or "info"

			if texto and texto ~= ultimoTexto then
				log(modo, texto)
				ultimoTexto = texto
			end
		end
	end
end)
