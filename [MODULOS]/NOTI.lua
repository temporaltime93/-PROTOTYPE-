--!strict

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- * Crear o reutilizar la GUI base
local gui = playerGui:FindFirstChild("NotifGui") or Instance.new("ScreenGui")
gui.Name = "NotifGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent = playerGui

-- * Crear o reutilizar contenedor principal
local frame = gui:FindFirstChild("NotifFrame") or Instance.new("Frame")
frame.Name = "NotifFrame"
frame.BackgroundTransparency = 1
frame.Size = UDim2.new(0, 300, 1, 0)
frame.AnchorPoint = Vector2.new(1, 1)
frame.Position = UDim2.new(1, -10, 1, -30)
frame.ClipsDescendants = true
frame.Parent = gui

-- * Colores según tipo de mensaje
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

-- * Etiquetas por tipo
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

-- * Función principal para mostrar notificación
local function mostrarNotificacion(M: string, T: string)
	local color = modoColor[M] or modoColor.log
	local titulo = etiquetas[M] or "🔘 MENSAJE"

	-- Caja visual
	local contenedor = Instance.new("Frame")
	contenedor.Size = UDim2.new(1, 0, 0, 85)
	contenedor.Position = UDim2.new(0, 0, 1, 0)
	contenedor.BackgroundColor3 = color
	contenedor.BackgroundTransparency = 0.1
	contenedor.BorderSizePixel = 0
	contenedor.AnchorPoint = Vector2.new(0, 1)
	contenedor.ClipsDescendants = true
	contenedor.ZIndex = 100
	contenedor.Parent = frame

	Instance.new("UICorner", contenedor).CornerRadius = UDim.new(0, 6)
	local padding = Instance.new("UIPadding", contenedor)
	padding.PaddingLeft = UDim.new(0, 10)
	padding.PaddingRight = UDim.new(0, 10)
	padding.PaddingTop = UDim.new(0, 8)
	padding.PaddingBottom = UDim.new(0, 8)

	local tituloLabel = Instance.new("TextLabel")
	tituloLabel.Size = UDim2.new(1, 0, 0, 20)
	tituloLabel.Position = UDim2.new(0, 0, 0, 0)
	tituloLabel.BackgroundTransparency = 1
	tituloLabel.Text = titulo
	tituloLabel.Font = Enum.Font.GothamBold
	tituloLabel.TextSize = 14
	tituloLabel.ZIndex = 101
	tituloLabel.TextColor3 = Color3.new(1, 1, 1)
	tituloLabel.TextXAlignment = Enum.TextXAlignment.Center
	tituloLabel.Parent = contenedor

	local contenido = Instance.new("TextLabel")
	contenido.Size = UDim2.new(1, 0, 0, 40)
	contenido.Position = UDim2.new(0, 0, 0, 40)
	contenido.BackgroundTransparency = 1
	contenido.Text = T
	contenido.Font = Enum.Font.Gotham
	contenido.TextSize = 13
	contenido.TextWrapped = true
	contenido.ZIndex = 102
	contenido.TextColor3 = Color3.new(1, 1, 1)
	contenido.TextXAlignment = Enum.TextXAlignment.Left
	contenido.TextYAlignment = Enum.TextYAlignment.Top
	contenido.Parent = contenedor

	local appear = TweenService:Create(contenedor, TweenInfo.new(0.3), {
		Position = UDim2.new(0, 0, 1, -95),
	})
	appear:Play()

	-- Auto eliminar después de 3s
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

-- * Escuchar variable global _G.mensaje
local ultimaReferencia = nil
task.spawn(function()
	while true do
		task.wait(0.1)
		local mensaje = _G.mensaje
		if mensaje and type(mensaje) == "table" and mensaje ~= ultimaReferencia then
			mostrarNotificacion(mensaje.M or "info", mensaje.T or "Sin texto")
			ultimaReferencia = mensaje
		end
	end
end)

-- ? Prueba inicial automática
task.delay(1, function()
	_G.mensaje = {
		M = "success",
		T = "✅ Sistema de notificaciones activo"
	}
end)
