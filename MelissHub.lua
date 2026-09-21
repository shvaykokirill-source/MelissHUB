-- ======== НАСТРОЙКИ ========
local validKeys = {
    ["s0d-fdv-gdgdr-gdnhjgdr-iuo-poi"] = true,
    -- добавляй свои ключи сюда, каждый новой строкой:
    -- ["другой-ключ"] = true,
}

local hubName = "MelissHub"
local hubBy = "by MelissXD"
-- ============================

local CoreGui = game:GetService("CoreGui")

-- Окно ключа
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "MelissKeySystem"
keyGui.ResetOnSpawn = false
keyGui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 180)
frame.Position = UDim2.new(0.5, -160, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = keyGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = hubName .. " | Key System"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame

local byLabel = Instance.new("TextLabel")
byLabel.Size = UDim2.new(1, 0, 0, 15)
byLabel.Position = UDim2.new(0, 0, 0, 38)
byLabel.BackgroundTransparency = 1
byLabel.Text = hubBy
byLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
byLabel.Font = Enum.Font.Gotham
byLabel.TextSize = 10
byLabel.Parent = frame

local input = Instance.new("TextBox")
input.Size = UDim2.new(1, -40, 0, 35)
input.Position = UDim2.new(0, 20, 0, 65)
input.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
input.BorderSizePixel = 0
input.Text = ""
input.PlaceholderText = "Введите ключ..."
input.TextColor3 = Color3.fromRGB(255, 255, 255)
input.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
input.Font = Enum.Font.Gotham
input.TextSize = 14
input.ClearTextOnFocus = false
input.Parent = frame

local inCorner = Instance.new("UICorner")
inCorner.CornerRadius = UDim.new(0, 6)
inCorner.Parent = input

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -40, 0, 35)
button.Position = UDim2.new(0, 20, 0, 115)
button.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
button.BorderSizePixel = 0
button.Text = "Проверить ключ"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 14
button.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = button

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 15)
status.Position = UDim2.new(0, 0, 1, -20)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(255, 80, 80)
status.Font = Enum.Font.Gotham
status.TextSize = 11
status.Parent = frame

-- Обработка нажатия
button.MouseButton1Click:Connect(function()
    local key = input.Text

    if validKeys[key] then
        status.Text = "Ключ верный. Загрузка..."
        status.TextColor3 = Color3.fromRGB(120, 220, 120)

        task.wait(0.5)
        keyGui:Destroy()

        -- ======== ЗАГРУЗКА ХАБА ========
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Terfiscript1/KitagawaStealAnEgg/refs/heads/main/KitagawaHubStealAnEgg"))()

        task.wait(0.01)

        task.spawn(function()
            while true do
                for _, v in pairs(CoreGui:GetDescendants()) do
                    if v:IsA("TextLabel") then
                        if v.Text == "KitagawaHub" then
                            v.Text = hubName
                        elseif v.Text == "KitagawaHub PatchLog" then
                            v.Text = hubName .. " PatchLog"
                        elseif v.Text == "Steal An Egg" then
                            v.Text = hubBy
                            v.TextSize = 10
                            v.TextColor3 = Color3.fromRGB(140, 140, 140)
                        end
                    end
                end
                task.wait(1)
            end
        end)
    else
        status.Text = "Неверный ключ"
        status.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)
