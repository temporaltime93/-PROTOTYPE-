local M = {}

function M.log(tipo, mensaje)
	if tipo == "info" then
		print("✅ [INFO] " .. mensaje)
	elseif tipo == "warn" then
		warn("⚠️ [ADVERTENCIA] " .. mensaje)
	elseif tipo == "error" then
		error("❌ [ERROR] " .. mensaje)
	elseif tipo == "help" then
		print("🔷 [AYUDA] " .. mensaje)
	else
		print("🔘 [LOG] " .. mensaje)
	end
end

-- ? Registrar global para uso inmediato
_G.log = M.log

return M
