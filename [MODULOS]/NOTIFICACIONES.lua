--!strict

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- * Crear GUI principal si no existe
local gui = playerGui:FindFirstChild("NotifGui") or Instance.new("ScreenGui")
gui.Name = "NotifGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true -- * evita que se mueva con la barra superior
gui.Parent = playerGui

-- * Contenedor general de notificaciones
local frame = gui:FindFirstChild("NotifFrame") or Instance.new("Frame")
frame.Name = "NotifFrame"
frame.Parent = gui
frame.BackgroundTransparency = 1
frame.Size = UDim2.new(0, 300, 1, 0)
frame.AnchorPoint = Vector2.new(1, 1)
frame.Position = UDim2.new(1, -10, 1, -30) -- * always bottom = 30, right = 10
frame.ClipsDescendants = false

-- * Colores por tipo
local modoColor = {
	info = Color3.fromRGB(85, 170, 255),     -- azul
	warn = Color3.fromRGB(255, 204, 0),      -- amarillo
	error = Color3.fromRGB(255, 80, 80),     -- rojo
	help = Color3.fromRGB(180, 90, 255),     -- violeta
	log = Color3.fromRGB(200, 200, 200),     -- gris
}

-- * Mostrar una notificación visual
local function mostrarNotificacion(modo: string, texto: string)
	local msg = Instance.new("TextLabel")
	msg.Size = UDim2.new(1, 0, 0, 40)
	msg.Position = UDim2.new(0, 0, 1, 0) -- aparece justo debajo del frame
	msg.BackgroundColor3 = modoColor[modo] or modoColor.log
	msg.BorderSizePixel = 0
	msg.BackgroundTransparency = 0.1
	msg.Text = `[{modo:upper()}] {texto}`
	msg.TextColor3 = Color3.new(1, 1, 1)
	msg.Font = Enum.Font.GothamBold
	msg.TextSize = 14
	msg.TextXAlignment = Enum.TextXAlignment.Center
	msg.AnchorPoint = Vector2.new(0, 1)
	msg.Parent = frame
	msg.ZIndex = 2

	-- * Padding interno
	local padding = Instance.new("UIPadding", msg)
	padding.PaddingLeft = UDim.new(0, 10)
	padding.PaddingRight = UDim.new(0, 10)
	padding.PaddingTop = UDim.new(0, 5)
	padding.PaddingBottom = UDim.new(0, 5)

	-- * Esquinas redondeadas
	local corner = Instance.new("UICorner", msg)
	corner.CornerRadius = UDim.new(0, 6)

	-- * Animación de aparición (sube 50 px)
	local appear = TweenService:Create(msg, TweenInfo.new(0.3), {
		Position = UDim2.new(0, 0, 1, -50),
	})
	appear:Play()

	-- * Esperar y luego desvanecer
	task.delay(3, function()
		local disappear = TweenService:Create(msg, TweenInfo.new(0.5), {
			TextTransparency = 1,
			BackgroundTransparency = 1,
		})
		disappear:Play()
		disappear.Completed:Wait()
		msg:Destroy()
	end)
end

-- * Sistema que escucha el mensaje global
local ultimaReferencia = nil

task.spawn(function()
	while true do
		task.wait(0.1)
		local mensaje = _G.mensaje
		if mensaje and type(mensaje) == "table" and mensaje ~= ultimaReferencia then
			local texto = mensaje.texto or "Sin texto"
			local modo = mensaje.modo or "info"
			mostrarNotificacion(modo, texto)
			ultimaReferencia = mensaje
		end
	end
end)

