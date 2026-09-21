loadstring(game:HttpGet("https://raw.githubusercontent.com/Terfiscript1/KitagawaStealAnEgg/refs/heads/main/KitagawaHubStealAnEgg"))()

task.wait(0.1)

local hit = 0
for _, v in pairs(game.CoreGui:GetDescendants()) do
    if v:IsA("TextLabel") then
        if v.Text == "KitagawaHub" then
            v.Text = "MelissHub"
        elseif v.Text == "Steal An Egg" then
            hit = hit + 1
            if hit == 1 then
                v.Text = "by MelissXD"
                v.TextSize = 10
                v.TextColor3 = Color3.fromRGB(140, 140, 140)
            end
        end
    end
end