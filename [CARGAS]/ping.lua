
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

--+╭───────────────────────────╮
--+│       🛠 GUI PING 🛠       │
--+╰───────────────────────────╯
--[[
Descripción general:
Este script crea una interfaz gráfica de usuario (GUI) para realizar un "ping" a un jugador en Roblox.
La GUI incluye un cuadro de texto para ingresar el ID del jugador y un botón para realizar el ping.
También hay una imagen de fondo que se puede arrastrar para mover la GUI.
--]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-->╭───────────────────────────╮
-->│         🛠 GUI 🛠          │
-->╰───────────────────────────╯
--[[
Esta sección crea la GUI principal y establece sus propiedades visuales básicas.
--]]

--// Crear GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UI_Main"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

--// Frame principal
local PING = Instance.new("Frame")
PING.Name = "PING"
PING.BackgroundTransparency = 1
PING.Position = UDim2.new(0.29, 0, 0.28, 0)
PING.Size = UDim2.new(0, 533, 0, 396)
PING.Parent = screenGui

-->╭───────────────────────────╮
-->│        🖼️ Fondo 🖼️       │
-->╰───────────────────────────╯
--[[
Esta sección crea la imagen de fondo que también sirve como área de arrastre para mover la GUI.
--]]

--// Imagen de fondo (drag area)
local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Name = "Fondo"
ImageLabel.Image = "rbxassetid://137312536782274"
ImageLabel.BackgroundTransparency = 1
ImageLabel.Size = UDim2.new(1, 0, 1, 0)
ImageLabel.Parent = PING

-->╭───────────────────────────╮
-->│         📝 TextBox 📝      │
-->╰───────────────────────────╯
--[[
Esta sección crea el cuadro de texto para ingresar el ID del jugador.
--]]

--// TextBox
local TextBox = Instance.new("TextBox")
TextBox.Name = "InputBox"
TextBox.Font = Enum.Font.Roboto
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 40
TextBox.BackgroundTransparency = 1
TextBox.Position = UDim2.new(0.11, 0, 0.51, 0)
TextBox.Size = UDim2.new(0, 420, 0, 63)
TextBox.ClearTextOnFocus = false
TextBox.Parent = PING

-->╭───────────────────────────╮
-->│         🔘 Botón 🔘       │
-->╰───────────────────────────╯
--[[
Esta sección crea el botón para realizar el ping.
--]]

--// Botón
local BTN_ping = Instance.new("TextButton")
BTN_ping.Name = "BTN_ping"
BTN_ping.Font = Enum.Font.SourceSans
BTN_ping.Text = "PING"
BTN_ping.TextColor3 = Color3.fromRGB(0, 0, 0)
BTN_ping.TextSize = 18
BTN_ping.BackgroundTransparency = 0
BTN_ping.Transparency = 1
BTN_ping.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
BTN_ping.Position = UDim2.new(0.47, 0, 0.82, 0)
BTN_ping.Size = UDim2.new(0, 280, 0, 70)
BTN_ping.Parent = PING

-->╭───────────────────────────╮
-->│         🖱️ Mover 🖱️      │
-->╰───────────────────────────╯
--[[
Esta sección controla la funcionalidad de arrastre para mover la GUI.
--]]

local dragging = false
local dragInput
local dragStart
local startPos

local function updateDrag(input)
	local delta = input.Position - dragStart
	PING.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

ImageLabel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = PING.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

ImageLabel.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		updateDrag(input)
	end
end)

-->╭───────────────────────────╮
-->│         🔘 Funcionalidad 🔘│
-->╰───────────────────────────╯
--[[
Esta sección controla la funcionalidad del botón de ping.
Verifica que el ID ingresado sea válido antes de realizar el ping.
--]]

BTN_ping.MouseButton1Click:Connect(function()
	local texto = TextBox.Text:match("^%s*(.-)%s*$") -- ? Elimina espacios al inicio y al final

	-- ? Verifica que solo haya números y tenga más de 5 dígitos
	if texto:match("^%d+$") and #texto > 5 then
		_G.User_ID = texto
		PING.Visible = false -- * Solo se oculta si cumple con la condición
	else
		warn("❌ Ingresa una ID válida") -- ! Recomendación: Manejar errores de manera más amigable para el usuario
	end
end)

