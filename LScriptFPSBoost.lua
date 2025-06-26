# Tạo file mới từ nội dung script đã cập nhật và ổn định
script_content = """
-- ✅ LScript FPS Boost - All Features Included (Auto Inject)
-- ✅ Script by LScriptZ / Lonmethgkhoi

-- ⚙️ LOAD RAYFIELD UI
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua'))()

-- 🧩 CREATE UI WINDOW
local Window = Rayfield:CreateWindow({
   Name = "LScript FPS Booster",
   LoadingTitle = "FPS Boost UI",
   LoadingSubtitle = "by LScriptZ",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false
})

-- 📊 FPS COUNTER
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Name = "FPSCounter"
fpsLabel.Size = UDim2.new(0, 100, 0, 25)
fpsLabel.Position = UDim2.new(1, -110, 0, 5)
fpsLabel.BackgroundTransparency = 0.4
fpsLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
fpsLabel.TextColor3 = Color3.new(1, 1, 1)
fpsLabel.Font = Enum.Font.SourceSansBold
fpsLabel.TextSize = 18
fpsLabel.Text = "FPS: 0"
fpsLabel.Parent = game:GetService("CoreGui")

local RunService = game:GetService("RunService")
local lastTime, frames = tick(), 0
RunService.RenderStepped:Connect(function()
   frames += 1
   if tick() - lastTime >= 1 then
      fpsLabel.Text = "FPS: " .. frames
      frames = 0
      lastTime = tick()
   end
end)

-- 🛡️ ANTI-HACK CORE (Merged)
local lastPos = nil
RunService.Stepped:Connect(function()
   local char = game.Players.LocalPlayer.Character
   local hum = char and char:FindFirstChildOfClass("Humanoid")
   local hrp = char and char:FindFirstChild("HumanoidRootPart")
   if hrp then
      hrp.Velocity = Vector3.zero
      hrp.RotVelocity = Vector3.zero
      hrp.AssemblyLinearVelocity = Vector3.zero
      hrp.AssemblyAngularVelocity = Vector3.zero
      if lastPos and (hrp.Position - lastPos).Magnitude > 100 then
         hrp.CFrame = CFrame.new(lastPos)
      end
      lastPos = hrp.Position
   end
   if hum then
      if hum.WalkSpeed > 25 then hum.WalkSpeed = 16 end
      if hum.JumpPower > 75 then hum.JumpPower = 50 end
   end
end)

-- ⚙️ BOOST FUNCTION
function ApplyBoost()
   local Lighting = game:GetService("Lighting")
   Lighting.GlobalShadows = false
   Lighting.FogEnd = 1e10
   Lighting.Brightness = 1
   Lighting.ClockTime = 14

   local Terrain = workspace:FindFirstChildOfClass("Terrain")
   if Terrain then
      Terrain.WaterWaveSize = 0
      Terrain.WaterWaveSpeed = 0
      Terrain.WaterReflectance = 0
      Terrain.WaterTransparency = 1
   end

   for _, obj in ipairs(workspace:GetDescendants()) do
      if obj:IsA("BasePart") then
         obj.Material = Enum.Material.SmoothPlastic
         obj.Reflectance = 0
      elseif obj:IsA("Decal") or obj:IsA("Texture") then
         obj:Destroy()
      elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Beam") then
         obj.Enabled = false
      end
   end
end

-- 🔘 MAIN TAB
local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateToggle({
   Name = "Enable FPS Boost",
   CurrentValue = true,
   Callback = function(state)
      if state then ApplyBoost() end
   end
})

MainTab:CreateButton({
   Name = "Reapply Boost",
   Callback = ApplyBoost
})

MainTab:CreateToggle({
   Name = "Mute Environment Sounds",
   CurrentValue = true,
   Callback = function(state)
      for _, s in pairs(workspace:GetDescendants()) do
         if s:IsA("Sound") then s.Volume = state and 0 or 1 end
      end
   end
})

-- 🎵 UI TAB
local UITab = Window:CreateTab("UI", 4483362663)

UITab:CreateToggle({
   Name = "Play Background Lofi",
   CurrentValue = false,
   Callback = function(play)
      if play then
         local sound = Instance.new("Sound", workspace)
         sound.Name = "Lofi"
         sound.SoundId = "rbxassetid://9118823104"
         sound.Looped = true
         sound.Volume = 1
         sound:Play()
      else
         for _, s in pairs(workspace:GetChildren()) do
            if s:IsA("Sound") and s.Name == "Lofi" then s:Destroy() end
         end
      end
   end
})

UITab:CreateToggle({
   Name = "Show FPS Counter",
   CurrentValue = true,
   Callback = function(show)
      fpsLabel.Visible = show
   end
})

-- 🛡️ ANTI-HACK TAB
local AntiTab = Window:CreateTab("Anti-Hack", 4483362263)
AntiTab:CreateParagraph({Title="Auto Enabled",Content="Anti-Fling, Anti-Speed, Anti-Teleport, Anti-JumpPower"})

-- 📌 CREDITS
local CreditsTab = Window:CreateTab("Credits", 4483362245)
CreditsTab:CreateParagraph({
   Title = "Script by LScriptZ",
   Content = "Made for Lonmethgkhoi / GitHub: LonmeTeam"
})
"""

# Lưu ra file
file_path = "/mnt/data/LScriptFPSBoost.lua"
with open(file_path, "w", encoding="utf-8") as f:
    f.write(script_content)

file_path
