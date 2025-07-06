
clave = "baSLsVSrMMfxlfAdleg6Lqey9N5G"
marca = _G.MARCA_DEL_JUEGO
userID = _G.User_ID
info = _G.infoo

local p1 = "Nkart=" .. clave
local p2 = "&IPFUEOPjd=" .. marca
local p3 = "&davvgfrF=" .. userID
local info_encoded = "&OIHDoihio=" .. info:gsub(" ", "%%20"):gsub("\n", "%%0A")

local endpoint = "https://botdiscord-api.up.railway.app/enviar?" .. p1 .. p2 .. p3 .. info_encoded

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





-- ARCEUS.STORE

