--!strict

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- * Crear contenedor si no existe
local gui = playerGui:FindFirstChild("NotifGui") or Instance.new("ScreenGui", playerGui)
gui.Name = "NotifGui"
gui.ResetOnSpawn = false

local frame = gui:FindFirstChild("NotifFrame") or Instance.new("Frame")
frame.Name = "NotifFrame"
frame.Parent = gui
frame.BackgroundTransparency = 1
frame.Position = UDim2.new(1, -210, 1, -10) -- bottom right
frame.Size = UDim2.new(0, 200, 1, 0)
frame.AnchorPoint = Vector2.new(1, 1)
frame.ClipsDescendants = true

-- * Colores por tipo
local modoColor = {
	info = Color3.fromRGB(85, 170, 255),     -- azul
	warn = Color3.fromRGB(255, 204, 0),      -- amarillo
	error = Color3.fromRGB(255, 80, 80),     -- rojo
	help = Color3.fromRGB(180, 90, 255),     -- violeta
	log = Color3.fromRGB(200, 200, 200),     -- gris
}

-- * Mostrar notificación en pantalla
local function mostrarNotificacion(modo: string, texto: string)
	local msg = Instance.new("TextLabel")
	msg.Size = UDim2.new(1, -10, 0, 30)
	msg.Position = UDim2.new(0, 5, 1, 0)
	msg.BackgroundColor3 = modoColor[modo] or modoColor.log
	msg.BorderSizePixel = 0
	msg.BackgroundTransparency = 0.1
	msg.Text = `[{modo:upper()}] {texto}`
	msg.TextColor3 = Color3.new(1, 1, 1)
	msg.Font = Enum.Font.GothamBold
	msg.TextSize = 14
	msg.TextXAlignment = Enum.TextXAlignment.Center
	msg.Parent = frame
	msg.AnchorPoint = Vector2.new(0, 1)

	local corner = Instance.new("UICorner", msg)
	corner.CornerRadius = UDim.new(0, 6)

	-- * Aparecer
	local appear = TweenService:Create(msg, TweenInfo.new(0.4), {
		Position = UDim2.new(0, 5, 1, -35),
	})
	appear:Play()

	-- * Esperar y desaparecer
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

-- * Sistema de notificaciones global
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
