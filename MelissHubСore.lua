-- ============================================================
-- MelissHub Loader v2.0
-- Автор: SWILL для MelissXD
-- Ключи: meliss-xxx-xxx-xxx-xxx
-- ============================================================

local HUB_URL = "https://raw.githubusercontent.com/shvaykokirill-source/MELISSD/refs/heads/main/MelissHub.lua"
local hubName = "MelissHub"
local hubBy   = "by MelissXD"

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer

-- ============================================================
-- 10 ВАЛИДНЫХ КЛЮЧЕЙ
-- ============================================================
local VALID_KEYS = {
    ["meliss-a7k-9xm-4p2-q8f"] = true,
    ["meliss-b3n-6wz-1r5-h0d"] = true,
    ["meliss-c8v-2jq-7t4-k9m"] = true,
    ["meliss-d5p-0yh-3s6-l2w"] = true,
    ["meliss-e1r-4gk-8n9-v7x"] = true,
    ["meliss-f6m-7bv-2c3-z5t"] = true,
    ["meliss-g2w-1dq-5r8-y4n"] = true,
    ["meliss-h9j-8pf-3k7-b6s"] = true,
    ["meliss-i4t-5cn-9m1-x0q"] = true,
    ["meliss-j7s-3lr-6v2-c8p"] = true,
}

-- ============================================================
-- HWID ГЕНЕРАЦИЯ
-- ============================================================
local function getHVID()
    local executor = "Unknown"
    pcall(function()
        if identifyexecutor then
            executor = tostring(identifyexecutor())
        elseif getexecutorname then
            executor = tostring(getexecutorname())
        end
    end)
    
    local cam = workspace.CurrentCamera
    local vp = cam and cam.ViewportSize or Vector2.new(0, 0)
    
    local raw = tostring(LP.UserId) .. "|" .. tostring(game.PlaceId) .. "|" .. executor .. "|" .. tostring(vp.X) .. "x" .. tostring(vp.Y)
    local hash = 0
    for i = 1, #raw do
        hash = (hash * 31 + string.byte(raw, i)) % 0xFFFFFFFF
    end
    return string.format("%08X-%04X-%04X", hash, (hash // 65536) % 65536, hash % 65536)
end

local HWID = getHVID()

-- ============================================================
-- СОХРАНЕНИЕ АКТИВАЦИИ
-- ============================================================
local function loadActivated()
    if not readfile then return nil end
    local ok, data = pcall(function()
        if isfile and isfile("MelissKey.json") then
            return HttpService:JSONDecode(readfile("MelissKey.json"))
        end
        return nil
    end)
    if ok and data and data.hwid == HWID then
        return data.key
    end
    return nil
end

local function saveActivation(key)
    if not writefile then return end
    pcall(function()
        writefile("MelissKey.json", HttpService:JSONEncode({
            hwid = HWID,
            key = key,
            activated = os.time(),
        }))
    end)
end

-- ============================================================
-- UI ДЛЯ ВВОДА КЛЮЧА
-- ============================================================
local function showKeyUI()
    local sg = Instance.new("ScreenGui")
    sg.Name = "MelissKeyUI"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.Parent = CoreGui
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 420, 0, 260)
    bg.Position = UDim2.new(0.5, -210, 0.5, -130)
    bg.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    bg.BorderSizePixel = 0
    bg.Parent = sg
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 12)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(180, 100, 255)
    stroke.Thickness = 2
    stroke.Parent = bg
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 32)
    title.Position = UDim2.new(0, 10, 0, 14)
    title.BackgroundTransparency = 1
    title.Text = "🔒 MelissHub — Активация"
    title.TextColor3 = Color3.fromRGB(200, 150, 255)
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.Parent = bg
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, -20, 0, 20)
    subtitle.Position = UDim2.new(0, 10, 0, 48)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Введите ключ формата: meliss-xxx-xxx-xxx-xxx"
    subtitle.TextColor3 = Color3.fromRGB(140, 140, 160)
    subtitle.TextSize = 12
    subtitle.Font = Enum.Font.Gotham
    subtitle.Parent = bg
    
    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -20, 0, 40)
    input.Position = UDim2.new(0, 10, 0, 82)
    input.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    input.BorderSizePixel = 0
    input.Text = ""
    input.PlaceholderText = "meliss-xxx-xxx-xxx-xxx"
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
    input.TextSize = 14
    input.Font = Enum.Font.Code
    input.ClearTextOnFocus = false
    input.Parent = bg
    Instance.new("UICorner", input).CornerRadius = UDim.new(0, 8)
    
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, -20, 0, 20)
    status.Position = UDim2.new(0, 10, 0, 128)
    status.BackgroundTransparency = 1
    status.Text = "HWID: " .. HWID
    status.TextColor3 = Color3.fromRGB(120, 120, 140)
    status.TextSize = 11
    status.Font = Enum.Font.Code
    status.Parent = bg
    
    local activateBtn = Instance.new("TextButton")
    activateBtn.Size = UDim2.new(1, -20, 0, 42)
    activateBtn.Position = UDim2.new(0, 10, 0, 155)
    activateBtn.BackgroundColor3 = Color3.fromRGB(180, 100, 255)
    activateBtn.Text = "Активировать"
    activateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    activateBtn.TextSize = 15
    activateBtn.Font = Enum.Font.GothamBold
    activateBtn.BorderSizePixel = 0
    activateBtn.Parent = bg
    Instance.new("UICorner", activateBtn).CornerRadius = UDim.new(0, 8)
    
    local exitBtn = Instance.new("TextButton")
    exitBtn.Size = UDim2.new(1, -20, 0, 30)
    exitBtn.Position = UDim2.new(0, 10, 1, -40)
    exitBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    exitBtn.Text = "Выход"
    exitBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
    exitBtn.TextSize = 13
    exitBtn.Font = Enum.Font.Gotham
    exitBtn.BorderSizePixel = 0
    exitBtn.Parent = bg
    Instance.new("UICorner", exitBtn).CornerRadius = UDim.new(0, 6)
    
    local loading = false
    
    local function tryActivate()
        if loading then return end
        local key = input.Text:lower():gsub("%s", "")
        
        if key == "" then
            status.Text = "❌ Введите ключ"
            status.TextColor3 = Color3.fromRGB(255, 80, 80)
            return
        end
        
        if not VALID_KEYS[key] then
            status.Text = "❌ Неверный ключ"
            status.TextColor3 = Color3.fromRGB(255, 80, 80)
            return
        end
        
        loading = true
        status.Text = "⏳ Проверка..."
        status.TextColor3 = Color3.fromRGB(255, 200, 80)
        activateBtn.Text = "Загрузка..."
        
        task.wait(1.2)
        
        status.Text = "✅ Ключ принят! Загрузка хаба..."
        status.TextColor3 = Color3.fromRGB(100, 255, 150)
        saveActivation(key)
        
        task.wait(0.6)
        sg:Destroy()
        
        -- Запуск хаба
        loadstring(game:HttpGet(HUB_URL))()
        
        -- Подмена названий
        task.spawn(function()
            local gui
            for i = 1, 300 do
                gui = CoreGui:FindFirstChild("KitagawaHub_V8")
                if gui then break end
                task.wait(0.1)
            end
            if not gui then return end
            while gui and gui.Parent do
                for _, v in pairs(gui:GetDescendants()) do
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
                task.wait(0.2)
            end
        end)
    end
    
    activateBtn.MouseButton1Click:Connect(tryActivate)
    input.FocusLost:Connect(function(enter)
        if enter then tryActivate() end
    end)
    exitBtn.MouseButton1Click:Connect(function()
        sg:Destroy()
    end)
    
    -- Авто-активация при вставке
    input:GetPropertyChangedSignal("Text"):Connect(function()
        if #input.Text >= 24 and VALID_KEYS[input.Text:lower():gsub("%s", "")] then
            status.Text = "✅ Ключ найден — нажмите Активировать"
            status.TextColor3 = Color3.fromRGB(100, 255, 150)
        end
    end)
end

-- ============================================================
-- ЗАПУСК
-- ============================================================
local savedKey = loadActivated()

if savedKey and VALID_KEYS[savedKey] then
    print("[MelissHub] Авто-активация по сохранённому ключу")
    loadstring(game:HttpGet(HUB_URL))()
    
    task.spawn(function()
        local gui
        for i = 1, 300 do
            gui = CoreGui:FindFirstChild("KitagawaHub_V8")
            if gui then break end
            task.wait(0.1)
        end
        if not gui then return end
        while gui and gui.Parent do
            for _, v in pairs(gui:GetDescendants()) do
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
            task.wait(0.2)
        end
    end)
else
    print("[MelissHub] Требуется активация ключом")
    showKeyUI()
end
