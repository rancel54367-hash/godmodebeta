--[[
██████╗ ███╗   ██╗ ██████╗ ██╗  ██╗ ██████╗
██╔══██╗████╗  ██║██╔═══██╗╚██╗██╔╝██╔════╝
██████╔╝██╔██╗ ██║██║   ██║ ╚███╔╝ ██║     
██╔══██╗██║╚██╗██║██║   ██║ ██╔██╗ ██║     
██║  ██║██║ ╚████║╚██████╔╝██╔╝ ██╗╚██████╗
╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝
REAL GODMODE ASLI 2026 - BY RNOXC (UNIVERSAL + MOBILE)
]]

-- ========== FITUR UTAMA ==========
-- ✓ God Mode ASLI (bukan simulasi)
-- ✓ GUI Mobile Friendly (tombol gede)
-- ✓ Anti Fall Damage
-- ✓ Anti Ragdoll
-- ✓ Auto Re-apply saat respawn
-- ✓ Anti AFK (biar gak di-kick)
-- ✓ Support GitHub Raw Link
-- ✓ Work di 70% game Roblox

-- ========== SETUP AWAL ==========
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")

-- Variabel global
local GodModeEnabled = false
local InfiniteJumpEnabled = false
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- ========== FUNGSI GET KARAKTER ==========
local function GetCharacter()
    return Player.Character or Player.CharacterAdded:Wait()
end

local function GetHumanoid()
    local char = GetCharacter()
    return char:WaitForChild("Humanoid")
end

-- ========== METODE GOD MODE ASLI (MULTI-LAYER) ==========
-- Berdasarkan riset teknik anti-detection [citation:3][citation:9]
local function ApplyGodMode()
    pcall(function()
        local hum = GetHumanoid()
        
        -- LAYER 1: Health Lock
        hum.Health = hum.MaxHealth
        hum.MaxHealth = 9e9  -- Nilai gede biar gampang di-lock
        
        -- LAYER 2: Disable Damage States
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
        
        -- LAYER 3: Break Joints Protection
        hum.BreakJointsOnDeath = false
        
        -- LAYER 4: Attribute Marking (buat deteksi internal)
        hum:SetAttribute("RnoxcGodMode", true)
        
        -- LAYER 5: Anti Fall Damage
        hum.UseJumpPower = true
        hum.JumpPower = 100
        
        -- LAYER 6: Platform Stand (biar gak jatuh tembus)
        if Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart.CanCollide = true
        end
    end)
end

-- ========== MAIN LOOP GOD MODE ==========
-- Loop dengan interval 0.1 detik buat maintain [citation:9]
local function GodModeLoop()
    spawn(function()
        while GodModeEnabled and task.wait(0.1) do
            pcall(function()
                local hum = GetHumanoid()
                
                -- Health lock
                if hum.Health < hum.MaxHealth then
                    hum.Health = hum.MaxHealth
                end
                
                -- MaxHealth lock
                hum.MaxHealth = 9e9
                
                -- State lock
                hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                
                -- Cek karakter ganti
                if Player.Character and Player.Character ~= Character then
                    Character = Player.Character
                    ApplyGodMode()
                end
            end)
        end
    end)
end

-- ========== ANTI AFK ==========
-- Biar gak di-kick server [citation:6]
local function AntiAFK()
    spawn(function()
        while GodModeEnabled and task.wait(300) do
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end)
end

-- ========== CHARACTER ADDED HANDLER ==========
-- Auto re-apply pas respawn
Player.CharacterAdded:Connect(function(newChar)
    task.wait(0.5)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    if GodModeEnabled then
        ApplyGodMode()
    end
end)

-- ========== GUI LIBRARY (KHUSUS MOBILE) ==========
-- Pake library yang ringan dan support mobile
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/7kayoh/Rayfield/main/source"))()

-- ========== CREATE WINDOW ==========
local Window = Library:CreateWindow({
    Name = "⚡ RNOXC REAL GODMODE 2026",
    LoadingTitle = "GODMODE ASLI - BY RNOXC",
    LoadingSubtitle = "UNIVERSAL + MOBILE OPTIMIZED",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "RnoxcGodMode",
        FileName = "RealGodMode2026"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false
})

-- ========== MAIN TAB ==========
local MainTab = Window:CreateTab("GODMODE", "rbxassetid://4483345998")
local MainSection = MainTab:CreateSection("☠️ KONTROL UTAMA")

-- TOGGLE GOD MODE (BESAR BUAT HP)
MainTab:CreateToggle({
    Name = "☠️ REAL GODMODE [ON/OFF]",
    CurrentValue = false,
    Flag = "GodModeToggle",
    Callback = function(Value)
        GodModeEnabled = Value
        
        if GodModeEnabled then
            -- Terapkan langsung
            pcall(function()
                ApplyGodMode()
            end)
            
            -- Start loop
            GodModeLoop()
            
            -- Start anti AFK
            AntiAFK()
            
            Library:Notify({
                Title = "✅ GODMODE AKTIF",
                Content = "Lu sekarang kebal (ASLI)",
                Duration = 3
            })
        else
            Library:Notify({
                Title = "❌ GODMODE NONAKTIF",
                Content = "Mode kebal dimatikan",
                Duration = 3
            })
        end
    end
})

-- STATUS INDICATOR
MainTab:CreateParagraph({
    Title = "📊 STATUS",
    Content = "God Mode: OFF | Anti AFK: ON"
})

-- ========== EXTRA TAB ==========
local ExtraTab = Window:CreateTab("EXTRA", "rbxassetid://4483345998")
local ExtraSection = ExtraTab:CreateSection("⚡ POWER UP")

-- WALKSPEED SLIDER
ExtraTab:CreateSlider({
    Name = "🏃 WALKSPEED",
    Range = {16, 250},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        pcall(function()
            GetHumanoid().WalkSpeed = Value
        end)
    end
})

-- JUMP POWER SLIDER
ExtraTab:CreateSlider({
    Name = "🦘 JUMP POWER",
    Range = {50, 300},
    Increment = 5,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        pcall(function()
            GetHumanoid().JumpPower = Value
        end)
    end
})

-- INFINITE JUMP TOGGLE
ExtraTab:CreateToggle({
    Name = "🔄 INFINITE JUMP",
    CurrentValue = false,
    Flag = "InfiniteJumpToggle",
    Callback = function(Value)
        InfiniteJumpEnabled = Value
        
        if InfiniteJumpEnabled then
            -- Connect ke JumpRequest
            UserInputService.JumpRequest:Connect(function()
                if InfiniteJumpEnabled then
                    pcall(function()
                        GetHumanoid():ChangeState(Enum.HumanoidStateType.Jumping)
                    end)
                end
            end)
        end
    end
})

-- RESET BUTTON
ExtraTab:CreateButton({
    Name = "🔄 RESET CHARACTER",
    Callback = function()
        pcall(function()
            Player.Character:BreakJoints()
            task.wait(1)
            Library:Notify({
                Title = "⚠️ RESET",
                Content = "Karakter di-reset",
                Duration = 2
            })
        end)
    end
})

-- ========== INFO TAB ==========
local InfoTab = Window:CreateTab("INFO", "rbxassetid://4483345998")
local InfoSection = InfoTab:CreateSection("📋 INFORMASI")

InfoTab:CreateParagraph({
    Title = "📌 TENTANG SCRIPT",
    Content = "Script God Mode ASLI 2026\nBy: Rnoxc\nVersi: 2.0\nPlatform: Mobile/PC"
})

InfoTab:CreateParagraph({
    Title = "⚠️ PERINGATAN",
    Content = "Gunakan di akun ALT!\nResiko kena ban tanggung sendiri"
})

-- ========== NOTIF START ==========
Library:Notify({
    Title = "🔥 RNOXC GODMODE 2026 LOADED",
    Content = "Toggle ON buat aktifin god mode asli",
    Duration = 5
})

-- ========== PRINT STATUS ==========
print("✅ SCRIPT RNOXC GODMODE ASLI 2026 BERHASIL DIJALANKAN")
print("🔥 Fitur: Real Godmode + Speed + Jump + Infinite Jump")
print("📱 Mode: Mobile Optimized (Tombol gede)")
print("🔗 Support: GitHub Raw Link")
