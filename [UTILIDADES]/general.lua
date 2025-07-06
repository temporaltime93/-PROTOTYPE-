local baseURL = "https://raw.githubusercontent.com/temporaltime93/-PROTOTYPE-/refs/heads/main/%5BUTILIDADES%5D/"

local scripts = {
  tablero = "caja.lua",
  eyes = "eyes.lua",
  mapa = "mapa.lua"
}

for nombre, activo in pairs(_G.selecciones or {}) do
  if activo and scripts[nombre] then
    local url = baseURL .. scripts[nombre]
    local success, result = pcall(function()
      return loadstring(game:HttpGet(url))()
    end)

    if not success then
      warn("❌ Error al cargar:", nombre, result)
    end
  end
end