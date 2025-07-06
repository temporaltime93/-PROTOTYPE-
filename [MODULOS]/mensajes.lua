--loadstring(game:HttpGet("https://raw.githubusercontent.com/temporaltime93/-PROTOTYPE-/main/[MODULOS]/mensajes.lua"))()
--~ ╭────────────────────────────────────────────────────
--~ │ 🌟      ¡HOLIII~! COMO ESTAS SOY RUBI~ 💖           
--~ │        Representando a: TEAM PROTOTYPE 🛠️👾         
--~ │────────────────────────────────────────────────────
--~ │ 🎯 ¿Necesitas ayuda tecnológica? ¡Aquí estamos~!    
--~ │                                                    
--~ │ 💼 Servicios Premium que ofrecemos:                
--~ │                                                    
--~ │ 🤖  AUTOMATIZACIÓN: Bots, sistemas y tareas smart~ 
--~ │ 🧪  CREACIÓN: Ideas únicas hechas realidad 💡       
--~ │ 🔧  SCRIPTS: Personalizados, rápidos y seguros 🛡️   
--~ │ 🌀  CLONACIÓN: Entornos, sistemas, lógicas 🔍       
--~ │                                                    
--~ │ 💬 ¡Conversemos! Rubi y el team están atentos~ 💻   
--~ │ 🏡  DISCORD: https://discord.gg/ammCKeyNcX         
--~ │ 🌐  WEB:     https://arceus.online                 
--~ ╰────────────────────────────────────────────────────

--+ ╭────────────────────────────────────────────
--+ │ NOMBRE DEL PROYECTO: Sistema de Mensajes
--+ │
--+ │ 📦 FUNCIONES: 1
--+ │ 💼 MODULOS:   0
--+ │ 💻 SERVICIOS: 1
--+ │ 📡 APIS:     0
--+ │ 🔁 ETC:      0
--+ │
--+ │ 💬 DESCRIPCIÓN: Sistema para gestionar mensajes de logging con diferentes modos y formatos.
--+ ╰────────────────────────────────────────────

--= ╭───────────────────────────────────────────────────────────────────
--= │ 🧩 CAJA VISUAL DE DESCRIPCIÓN GENERAL (OBLIGATORIA)
--= ╰───────────────────────────────────────────────────────────────────
--+ ╭───────────────────────────────────────────────────────────────────
--+ │ 🌲 ESTRUCTURA DEL CÓDIGO
--+ │
--+ │ 🌳 FUNCIONES
--+ │   ├── log
--+ │
--+ │ 🌳 SERVICIOS
--+ │   ├── Mensajes
--+ ╰───────────────────────────────────────────────────────────────────

-- * Sistema de logging
local function log(modo, mensaje)
	--> Función 'log' para imprimir mensajes con formato específico basado en el modo seleccionado.
	if modo == "info" then
		--> Si el modo es "info", imprime un mensaje con un indicador de éxito.
		print("✅ [INFO] " .. mensaje)
	elseif modo == "warn" then
		--> Si el modo es "warn", imprime un mensaje de advertencia.
		warn("⚠️ [ADVERTENCIA] " .. mensaje)
	elseif modo == "error" then
		--> Si el modo es "error", imprime un mensaje de error.
		warn("❌ [ERROR] " .. mensaje)
	elseif modo == "help" then
		--> Si el modo es "help", imprime un mensaje de ayuda.
		print("🔷 [AYUDA] " .. mensaje)
	else
		--> Para cualquier otro modo, imprime un mensaje genérico.
		print("🔘 [LOG] " .. mensaje)
	end
end

-- * Guardamos referencia para evitar duplicados por frame
local ultimaReferencia = nil
--> Variable para almacenar la última referencia de mensaje, utilizada para evitar imprimir mensajes duplicados.

task.spawn(function()
	--> Servicio 'Mensajes' que se ejecuta en una tarea separada.
	while true do
		task.wait(0.1)

		local mensaje = _G.mensaje
		--> Obtiene el mensaje global 'mensaje', que es una tabla con el texto y el modo.

		if mensaje and type(mensaje) == "table" and mensaje ~= ultimaReferencia then
			--> Verifica si el mensaje es una tabla válida y si es diferente de la última referencia.
			local texto = mensaje.texto or "Sin texto"
			--> Obtiene el texto del mensaje, o usa "Sin texto" si no se proporciona.
			local modo = mensaje.modo or "info"
			--> Obtiene el modo del mensaje, o usa "info" como valor predeterminado.

			log(modo, texto)
			--> Llama a la función 'log' para imprimir el mensaje con el formato adecuado.

			-- * Actualizamos la referencia (evita imprimir más de una vez)
			ultimaReferencia = mensaje
			--> Actualiza la última referencia para evitar imprimir el mismo mensaje varias veces.
		end
	end
end)