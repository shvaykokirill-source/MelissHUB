-- ================= НАСТРОЙКИ =================
local HUB_URL = "https://raw.githubusercontent.com/Terfiscript1/KitagawaStealAnEgg/refs/heads/main/KitagawaHubStealAnEgg"
local hubName = "MelissHub"
local hubBy   = "by MelissXD"
-- ============================================

local CoreGui = game:GetService("CoreGui")

-- 1. Загрузка хаба
loadstring(game:HttpGet(HUB_URL))()

-- 2. Ждём прогрузки
task.wait(0.1)

-- 3. Подмена названий
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
