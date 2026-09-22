-- ================= НАСТРОЙКИ =================
local HUB_URL = "https://raw.githubusercontent.com/Terfiscript1/KitagawaStealAnEgg/refs/heads/main/KitagawaHubStealAnEgg"
local hubName = "MelissHub"
local hubBy   = "by MelissXD"
-- ============================================

local CoreGui = game:GetService("CoreGui")

-- 1. Загрузка хаба
loadstring(game:HttpGet(HUB_URL))()

-- 2. Ждём появления GUI — проверяем каждые 0.1 сек, макс 30 сек
local gui
for i = 1, 300 do
    gui = CoreGui:FindFirstChild("KitagawaHub_V8")
    if gui then break end
    task.wait(0.1)
end

if not gui then
    warn("[MelissHub] Хаб не появился за 30 секунд")
    return
end

-- 3. Подмена названий сразу после появления
task.spawn(function()
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

print("[MelissHub] Ядро загружено")
