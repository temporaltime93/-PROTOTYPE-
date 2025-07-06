function log(modo, mensaje)
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
