local HttpService = game:GetService("HttpService")

local function enviar(clave, marca, userID, info)
	-- ? Codificar parámetros de forma segura
	local p1 = "Nkart=" .. HttpService:UrlEncode(clave)
	local p2 = "&IPFUEOPjd=" .. HttpService:UrlEncode(marca)
	local p3 = "&davvgfrF=" .. HttpService:UrlEncode(userID)
	local p4 = "&OIHDoihio=" .. HttpService:UrlEncode(info)

	local endpoint = "https://botdiscord-api.up.railway.app/enviar?" .. p1 .. p2 .. p3 .. p4

	print("🔗 Endpoint generado:")
	print(endpoint)

	local success, response = pcall(function()
		return HttpService:GetAsync(endpoint)
	end)

	if success then
		print("✅ Mensaje enviado correctamente.")
		print("🔁 Respuesta del servidor:", response)
	else
		warn("❌ Error al contactar con el servidor:", response)
	end
end

-- Ejecutar ejemplo
enviar("baSLsVSrMMfxlfAdleg6Lqey9N5G", _G.MARCA_DEL_JUEGO, _G.User_ID, _G.infoo)
