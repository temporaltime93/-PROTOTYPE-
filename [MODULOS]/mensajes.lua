--!strict
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- * Tabla con imágenes por modo
local imagenes = {
	error = "rbxassetid://140664997265204",
	log = "rbxassetid://78505793690725",
	success = "rbxassetid://81679707041572",
	help = "rbxassetid://120037550632387",
}
local coloresTexto = {
	error = Color3.fromRGB(255, 60, 60),
	log = Color3.fromRGB(220, 220, 220),
	success = Color3.fromRGB(60, 255, 140),
	help = Color3.fromRGB(120, 180, 255),
}

-- * Función para crear y mostrar la notificación visual
local function mostrarNotificacion(modo: string, texto: string)
	local imagenID = imagenes[modo] or imagenes.log

	local screenGui = playerGui:FindFirstChild("NotifGuiV2") or Instance.new("ScreenGui")
	screenGui.Name = "NotifGuiV2"
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

	local NOTI = Instance.new("Frame")
	NOTI.Name = "NOTI"
	NOTI.BackgroundTransparency = 1
	NOTI.Size = UDim2.new(0, 330, 0, 280)
	NOTI.AnchorPoint = Vector2.new(1, 1)
	NOTI.Position = UDim2.new(1, -10, 1, -10)
	NOTI.Parent = screenGui
	NOTI.ZIndex = 99999

	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.Name = "ImageLabel"
	ImageLabel.Image = imagenID
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0, 0, 0, 0)
	ImageLabel.Size = UDim2.new(0, 331, 0, 277)
	ImageLabel.Parent = NOTI

	local TEXTO_NOTI = Instance.new("TextBox")
	TEXTO_NOTI.Name = "TEXTO_NOTI"
	TEXTO_NOTI.Text = texto
	TEXTO_NOTI.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TEXTO_NOTI.TextColor3 = coloresTexto[modo] or Color3.fromRGB(255, 255, 255)
	TEXTO_NOTI.TextSize = 25
	TEXTO_NOTI.TextXAlignment = Enum.TextXAlignment.Left
	TEXTO_NOTI.TextYAlignment = Enum.TextYAlignment.Top
	TEXTO_NOTI.BackgroundTransparency = 1
	TEXTO_NOTI.Position = UDim2.new(0.08, 0, 0.28, 0)
	TEXTO_NOTI.Size = UDim2.new(0, 278, 0, 175)
	TEXTO_NOTI.TextWrapped = true
	TEXTO_NOTI.ClearTextOnFocus = false
	TEXTO_NOTI.TextEditable = false
	TEXTO_NOTI.Active = false
	TEXTO_NOTI.Parent = NOTI

	-- * Animar entrada (opcional)
	NOTI.Position = UDim2.new(1, -10, 1, 100)
	local entrada = TweenService:Create(NOTI, TweenInfo.new(0.3), {
		Position = UDim2.new(1, -10, 1, -10)
	})
	entrada:Play()

	-- * Auto eliminar después de 4 segundos
	task.delay(4, function()
		local salida = TweenService:Create(NOTI, TweenInfo.new(0.4), {
			Position = UDim2.new(1, -10, 1, 100),
			BackgroundTransparency = 1
		})
		for _, hijo in ipairs(NOTI:GetDescendants()) do
			if hijo:IsA("TextLabel") or hijo:IsA("TextBox") then
				TweenService:Create(hijo, TweenInfo.new(0.4), {
					TextTransparency = 1
				}):Play()
			elseif hijo:IsA("ImageLabel") then
				TweenService:Create(hijo, TweenInfo.new(0.4), {
					ImageTransparency = 1
				}):Play()
			end
		end
		salida:Play()
		salida.Completed:Wait()
		NOTI:Destroy()
	end)
end

-- * Escuchar _G
local ultimaReferencia = nil
task.spawn(function()
	while true do
		task.wait(0.1)
		local mensaje = _G.mensaje
		if mensaje and type(mensaje) == "table" and mensaje ~= ultimaReferencia then
			mostrarNotificacion(mensaje.M or "log", mensaje.T or "Sin texto")
			ultimaReferencia = mensaje
		end
	end
end)

-- * Ejemplo para probarlo:
_G.mensaje = {
	M = "success", -- Opciones: error, log, success, help
	T = "NOTI CARGO CORRECTAMENTE"
}


