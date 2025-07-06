-- mensajes.lua
local M = {}

function M.log(tipo, mensaje)
	-- (tu código log)
end

-- * Simular que "está escuchando" o que corre algo en segundo plano
spawn(function()
	while true do
		wait(5)
		M.log("info", "⌛ Sistema en escucha activa...")
	end
end)

-- Registrar global
_G.log = M.log
return M
