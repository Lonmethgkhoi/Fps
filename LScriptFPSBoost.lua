-- 📦 LScript FPS Boost - All-in-One Script by Lonmethgkhoi / LScriptZ

local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- 💡 Ánh sáng & môi trường
Lighting.GlobalShadows = false
Lighting.FogEnd = 100000
Lighting.Brightness = 1
Lighting.ClockTime = 14
pcall(function()
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
end)

-- 🌊 Nước & Terrain
if Terrain then
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 1
end

-- 🧹 Xoá hiệu ứng nặng
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") then
        obj.Material = Enum.Material.SmoothPlastic
        obj.Reflectance = 0
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        obj:Destroy()
    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
        obj.Enabled = false
    elseif obj:IsA("Beam") then
        obj.Enabled = false
    end
end

-- 🔇 Tắt âm thanh nền
for _, sound in ipairs(workspace:GetDescendants()) do
    if sound:IsA("Sound") then
        sound.Volume = 0
    end
end

-- 🖥 FOV chuẩn
if Camera then
    Camera.FieldOfView = 70
end

-- 📊 FPS Counter UI
local screenGui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "FPS_UI"
local fpsLabel = Instance.new("TextLabel", screenGui)
fpsLabel.Position = UDim2.new(1, -110, 0, 5)
fpsLabel.Size = UDim2.new(0, 100, 0, 25)
fpsLabel.BackgroundTransparency = 0.5
fpsLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
fpsLabel.TextColor3 = Color3.new(1,1,1)
fpsLabel.Font = Enum.Font.SourceSans
fpsLabel.TextSize = 18
fpsLabel.Text = "FPS: 0"
fpsLabel.TextXAlignment = Enum.TextXAlignment.Center

local lastUpdate = tick()
local frameCount = 0

RunService.RenderStepped:Connect(function()
    frameCount += 1
    local now = tick()
    if now - lastUpdate >= 1 then
        fpsLabel.Text = "FPS: " .. frameCount
        frameCount = 0
        lastUpdate = now
    end
end)

-- 🔘 Giao diện bật/tắt FPS Boost
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 160, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.Text = "🟢 FPS Boost: ON"

local boosted = true
toggleButton.MouseButton1Click:Connect(function()
    boosted = not boosted
    toggleButton.Text = boosted and "🟢 FPS Boost: ON" or "🔴 FPS Boost: OFF"
    fpsLabel.Visible = boosted
    if boosted then
        -- Bật lại tối ưu nếu tắt xong bật
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
    else
        Lighting.GlobalShadows = true
        Lighting.FogEnd = 500
    end
end)

-- ✅ Thông báo popup
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "LScript FPS Boost",
        Text = "✅ FPS Boost đã kích hoạt!",
        Duration = 5
    })
end)
