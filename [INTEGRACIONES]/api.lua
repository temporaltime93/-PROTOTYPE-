--loadstring(game:HttpGet("https://raw.githubusercontent.com/temporaltime93/-PROTOTYPE-/main/[INTEGRACIONES]/api.lua"))()
--_G.infoo = ""
--_G.User_ID = ""
--_G.MARCA_DEL_JUEGO = ""
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
--+ │ NOMBRE DEL PROYECTO: Envío de información del juego
--+ │
--+ │ 📦 FUNCIONES: 1
--+ │ 💼 MÓDULOS:   0
--+ │ 💻 SERVICIOS:  0
--+ │ 📡 APIS:      1
--+ │ 💾 BASES DE DATOS: 0
--+ │ 🗄️ ARCHIVOS:    0
--+ │ 📄 OTROS:        0
--+ │
--+ │ 💬 DESCRIPCIÓN: Este código genera un endpoint para enviar información del juego a un bot de Discord a través de una API.
--+ ╰────────────────────────────────────────────

--->╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
--->│ 🧩 GENERACIÓN DE PARÁMETROS Y ENDPOINT
--->╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
clave = "baSLsVSrMMfxlfAdleg6Lqey9N5G"
marca = _G.MARCA_DEL_JUEGO
userID = _G.User_ID
info = _G.infoo

---> Comentario: Se concatenan los parámetros para formar el endpoint
local p1 = "Nkart=" .. clave
local p2 = "&IPFUEOPjd=" .. marca
local p3 = "&davvgfrF=" .. userID
local info_encoded = "&OIHDoihio=" .. info:gsub(" ", "%%20"):gsub("\n", "%%0A")

---> Comentario: Se construye el endpoint con la URL base y los parámetros concatenados
local endpoint = "botdiscord-production-204e.up.railway.app/enviar?" .. p1 .. p2 .. p3 .. info_encoded

--->╭───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
--->│ 🧩 ENVÍO DE INFORMACIÓN Y MANEJO DE RESPUESTA
--->╰───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

---> Comentario: Se imprime el endpoint generado
print("🔗 Endpoint generado:")
print(endpoint)

---> Comentario: Se utiliza 'pcall' para manejar posibles errores al enviar la petición HTTP
local success, response = pcall(function()
	return game:HttpGet(endpoint)
end)

---> Comentario: Se verifica si la petición fue exitosa o hubo un error
if success then
	print("✅ Mensaje enviado correctamente.")
	print("🔁 Respuesta del servidor:", response)
else
	warn("❌ Error al contactar con el servidor:", response)
end

--=╭───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
--=│ 🌟 RECOMENDACIONES
--=╰───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--= Comentario: Se recomienda manejar la información sensible, como claves y IDs, de manera segura y no exponerlas directamente en el código.
--= Se sugiere utilizar variables de entorno o un archivo de configuración seguro para almacenar estos valores.

--= Comentario: Se recomienda validar la respuesta del servidor para asegurarse de que la información fue recibida y procesada correctamente.
--= Se puede agregar un manejo de errores más detallado para diferentes tipos de respuestas del servidor.

--= Comentario: Se sugiere agregar comentarios explicativos dentro del código para mejorar la comprensión del flujo y la funcionalidad de cada sección.
--= Esto ayuda a otros desarrolladores a entender rápidamente el propósito y la lógica del código.