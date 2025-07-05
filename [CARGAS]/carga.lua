local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "PantallaCarga"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- Fondo oscuro
local fondo = Instance.new("Frame")
fondo.Size = UDim2.new(1, 0, 1, 0)
fondo.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
fondo.Parent = gui

-- Texto animado
local textoAnimado = Instance.new("TextLabel")
textoAnimado.Text = ""
textoAnimado.Font = Enum.Font.GothamBold
textoAnimado.TextSize = 90
textoAnimado.TextColor3 = Color3.fromRGB(0, 255, 4)
textoAnimado.BackgroundTransparency = 1
textoAnimado.Size = UDim2.new(1, 0, 0, 100)
textoAnimado.Position = UDim2.new(0, 0, 0.25, 0)
textoAnimado.Parent = fondo

-- Botón para Discord
local discordBtn = Instance.new("TextButton")
discordBtn.Text = "Ir a Discord"
discordBtn.Font = Enum.Font.Gotham
discordBtn.TextSize = 20
discordBtn.Size = UDim2.new(0, 200, 0, 50)
discordBtn.Position = UDim2.new(0.5, -100, 0.55, 0)
discordBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 4)
discordBtn.TextColor3 = Color3.new(0, 0, 0)
discordBtn.Parent = fondo

discordBtn.MouseButton1Click:Connect(function()
    setclipboard(DISCORD)
    discordBtn.Text = "¡Copiado!"
    task.wait(1.5)
    discordBtn.Text = "Ir a Discord"
end)

-- Contenedor y barra de progreso
local barraContenedor = Instance.new("Frame")
barraContenedor.Size = UDim2.new(0.6, 0, 0, 25)
barraContenedor.Position = UDim2.new(0.2, 0, 0.45, 0)
barraContenedor.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
barraContenedor.BorderSizePixel = 0
barraContenedor.Parent = fondo

local barraProgreso = Instance.new("Frame")
barraProgreso.Size = UDim2.new(0, 0, 1, 0)
barraProgreso.BackgroundColor3 = Color3.fromRGB(0, 255, 4)
barraProgreso.BorderSizePixel = 0
barraProgreso.Parent = barraContenedor

-- ? Frases para el efecto de escritura
local frases = {
    "TEAM PROTOTYPE",
    "TECNOLOGÍA",
    "PARA TODOS"
}

-- * Máquina de escribir animada
task.spawn(function()
    while gui and gui.Parent do
        for _, frase in ipairs(frases) do
            for i = 1, #frase do
                textoAnimado.Text = string.sub(frase, 1, i)
                task.wait(0.07)
            end
            task.wait(0.8)
            -- ? Borrado tipo máquina
            for i = #frase, 1, -1 do
                textoAnimado.Text = string.sub(frase, 1, i)
                task.wait(0.04)
            end
            task.wait(0.2)
        end
    end
end)

-- * Progresión de barra con tiempo
task.spawn(function()
    local duracion = 7
    local pasos = 100
    for i = 1, pasos do
        barraProgreso.Size = UDim2.new(i / pasos, 0, 1, 0)
        task.wait(duracion / pasos)
    end
    gui:Destroy()
end)