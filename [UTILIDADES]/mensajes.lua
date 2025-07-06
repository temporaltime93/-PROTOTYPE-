-- * Sistema de logging elegante y semántico
local function log(modo, mensaje)
	if modo == "info" then
		print("✅ [INFO] " .. mensaje)
	elseif modo == "warn" then
		warn("⚠️ [ADVERTENCIA] " .. mensaje)
	elseif modo == "error" then
		error("❌ [ERROR] " .. mensaje)
	elseif modo == "help" then
		print("🔷 [AYUDA] " .. mensaje)
	else
		print("🔘 [LOG] " .. mensaje)
	end
end

-- * Variable para evitar mensajes repetidos
local ultimoTexto = nil

-- * Bucle que escucha actualizaciones en _G.mensaje
while true do
	wait(0.5)

	local paquete = _G.mensaje

	if paquete and type(paquete) == "table" and paquete.texto ~= ultimoTexto then
		local modo = paquete.modo or "info"
		log(modo, paquete.texto)
		ultimoTexto = paquete.texto
	end
end
