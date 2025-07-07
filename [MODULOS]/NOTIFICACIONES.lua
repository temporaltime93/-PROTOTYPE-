--!strict

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local gui = playerGui:FindFirstChild("NotifGui") or Instance.new("ScreenGui")
gui.Name = "NotifGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local frame = gui:FindFirstChild("NotifFrame") or Instance.new("Frame")
frame.Name = "NotifFrame"
frame.Parent = gui
frame.BackgroundTransparency = 1
frame.Size = UDim2.new(0, 300, 1, 0)
frame.AnchorPoint = Vector2.new(1, 1)
frame.Position = UDim2.new(1, -10, 1, -30)
frame.ClipsDescendants = true -- * CLAVE: recorta lo que se escape

local modoColor = {
	info = Color3.fromRGB(85, 170, 255),
	warn = Color3.fromRGB(255, 204, 0),
	error = Color3.fromRGB(255, 80, 80),
	help = Color3.fromRGB(180, 90, 255),
	log = Color3.fromRGB(200, 200, 200),
	success = Color3.fromRGB(0, 200, 130),
	debug = Color3.fromRGB(100, 100, 255),
	system = Color3.fromRGB(100, 255, 255),
	event = Color3.fromRGB(255, 128, 0),
	custom = Color3.fromRGB(255, 255, 255),
}

local etiquetas = {
	info = "✅ INFO ✅",
	warn = "⚠️ ADVERTENCIA ⚠️",
	error = "❌ ERROR ❌",
	help = "🔷 AYUDA 🔷",
	log = "🔘 LOG 🔘",
	success = "✅ ÉXITO ✅",
	debug = "🛠️ DEBUG 🛠️",
	system = "🖥️ SISTEMA 🖥️",
	event = "🎯 EVENTO 🎯",
	custom = "✨ MENSAJE ✨",
}

local function mostrarNotificacion(modo: string, texto: string)
	local color = modoColor[modo] or modoColor.log
	local titulo = etiquetas[modo] or "🔘 MENSAJE"

	-- * Caja contenedora
	local contenedor = Instance.new("Frame")
	contenedor.Size = UDim2.new(1, 0, 0, 85) -- * MÁS ALTO PARA QUE TODO QUEPA
	contenedor.Position = UDim2.new(0, 0, 1, 0)
	contenedor.BackgroundColor3 = color
	contenedor.BackgroundTransparency = 0.1
	contenedor.BorderSizePixel = 0
	contenedor.AnchorPoint = Vector2.new(0, 1)
	contenedor.ClipsDescendants = true
	contenedor.Parent = frame
	contenedor.ZIndex = 2

	local corner = Instance.new("UICorner", contenedor)
	corner.CornerRadius = UDim.new(0, 6)

	local padding = Instance.new("UIPadding", contenedor)
	padding.PaddingLeft = UDim.new(0, 10)
	padding.PaddingRight = UDim.new(0, 10)
	padding.PaddingTop = UDim.new(0, 8)
	padding.PaddingBottom = UDim.new(0, 8)

	-- * Título centrado
	local tituloLabel = Instance.new("TextLabel")
	tituloLabel.Size = UDim2.new(1, 0, 0, 20)
	tituloLabel.Position = UDim2.new(0, 0, 0, 0)
	tituloLabel.BackgroundTransparency = 1
	tituloLabel.Text = titulo
	tituloLabel.Font = Enum.Font.GothamBold
	tituloLabel.TextSize = 14
	tituloLabel.ZIndex = 10
	tituloLabel.TextColor3 = Color3.new(1, 1, 1)
	tituloLabel.TextXAlignment = Enum.TextXAlignment.Center
	tituloLabel.Parent = contenedor

	-- * Contenido debajo del título
	local contenido = Instance.new("TextLabel")
	contenido.Size = UDim2.new(1, 0, 0, 40)
	contenido.Position = UDim2.new(0, 0, 0, 40) -- * Bajo el título
	contenido.BackgroundTransparency = 1
	contenido.Text = texto
	contenido.Font = Enum.Font.Gotham
	contenido.TextSize = 13
	contenido.TextWrapped = true
	contenido.ZIndex = 10
	contenido.TextColor3 = Color3.new(1, 1, 1)
	contenido.TextXAlignment = Enum.TextXAlignment.Left
	contenido.TextYAlignment = Enum.TextYAlignment.Top
	contenido.Parent = contenedor

	-- * Animar aparición
	local appear = TweenService:Create(contenedor, TweenInfo.new(0.3), {
		Position = UDim2.new(0, 0, 1, -95),
	})
	appear:Play()

	-- * Auto eliminar
	task.delay(3, function()
		local desaparecer = TweenService:Create(contenedor, TweenInfo.new(0.4), {
			BackgroundTransparency = 1,
		})
		desaparecer:Play()
		for _, hijo in ipairs(contenedor:GetChildren()) do
			if hijo:IsA("TextLabel") then
				TweenService:Create(hijo, TweenInfo.new(0.4), {
					TextTransparency = 1,
				}):Play()
			end
		end
		desaparecer.Completed:Wait()
		contenedor:Destroy()
	end)
end

-- * Escuchar global
local ultimaReferencia = nil

task.spawn(function()
	while true do
		task.wait(0.1)
		local mensaje = _G.mensaje
		if mensaje and type(mensaje) == "table" and mensaje ~= ultimaReferencia then
			mostrarNotificacion(mensaje.modo or "info", mensaje.texto or "Sin texto")
			ultimaReferencia = mensaje
		end
	end
end)
_G.mensaje = {
	texto = "🧪 Este texto ya no se saldrá del cuadro",
	modo = "debug"
}
_G.mensaje = {
	texto = "🧪 Este texto ya no se saldrá del cuadro",
	modo = "debug"
}

