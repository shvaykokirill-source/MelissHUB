loadstring(game:HttpGet("https://raw.githubusercontent.com/Terfiscript1/KitagawaStealAnEgg/refs/heads/main/KitagawaHubStealAnEgg"))()

task.wait(0.01)

task.spawn(function()
    while true do
        for _, v in pairs(game.CoreGui:GetDescendants()) do
            if v:IsA("TextLabel") then
                if v.Text == "KitagawaHub" then
                    v.Text = "MelissHub"
                elseif v.Text == "KitagawaHub PatchLog" then
                    v.Text = "MelissHub PatchLog"
                elseif v.Text == "Steal An Egg" then
                    v.Text = "by MelissXD"
                    v.TextSize = 10
                    v.TextColor3 = Color3.fromRGB(140, 140, 140)
                end
            end
        end
        task.wait(1)
    end
end)
