-- AUTO FPS BOOST MODIFICATIONS
-- Apply these changes to your existing script

-- 1. REMOVE these lines (FPS boost button creation):
-- local toggleFpsBoostButton = createButton("ToggleFpsBoostButton", UDim2.new(0, 10, 0, 10), UDim2.new(1, -20, 0, 35), "FPS Boost: OFF (F)", Color3.fromRGB(160, 140, 200), otherContentFrame)
-- toggleFpsBoostButton.TextSize = 12

-- 2. REMOVE the FPS boost state variables:
-- local isFpsBoostActive = false

-- 3. REPLACE the clearVisuals function with this simplified version:
local function clearVisuals()
    print("Auto FPS Boost: Clearing visuals on startup...")
    local objectsToDelete = {}
    local deletionCount = 0

    local function processTool(tool)
        for _, descendant in ipairs(tool:GetDescendants()) do
            if descendant:IsA("BasePart") or
               descendant:IsA("ParticleEmitter") or
               descendant:IsA("Decal") or
               descendant:IsA("Texture") or
               descendant:IsA("MeshPart") or
               descendant:IsA("SpecialMesh") or
               descendant:IsA("Light") or
               descendant:IsA("BillboardGui") or
               descendant:IsA("SurfaceGui") or
               descendant:IsA("Beam") or
               descendant:IsA("Trail") or
               descendant:IsA("Smoke") or
               descendant:IsA("Fire") then
                table.insert(objectsToDelete, descendant)
            end
        end
    end

    pcall(function()
        for _, item in ipairs(player.Backpack:GetChildren()) do
            if item:IsA("Tool") then
                processTool(item)
            end
        end

        if player.Character then
            for _, item in ipairs(player.Character:GetChildren()) do
                if item:IsA("Tool") then
                    processTool(item)
                end
            end
        end

        for _, obj in ipairs(objectsToDelete) do
            if obj and obj.Parent then
                obj:Destroy()
                deletionCount = deletionCount + 1
            end
        end
    end)
    
    print("Auto FPS Boost: Cleared", deletionCount, "visual elements")
    createNotification("Auto FPS Boost", string.format("Automatically cleared %d visual elements for better performance!", deletionCount), 5)
end

-- 4. REMOVE these functions entirely:
-- setFpsBoostState function
-- toggleFpsBoostButton click handler
-- FPS boost keybind (F key) from UserInputService

-- 5. REMOVE FPS boost from config save/load:
-- Remove FpsBoostActive from configData
-- Remove setFpsBoostState calls from loadConfig

-- 6. ADD this at the very end of your script (after loadConfig):
task.spawn(function()
    task.wait(2) -- Wait 2 seconds for everything to load
    clearVisuals() -- Automatically clear visuals
end)