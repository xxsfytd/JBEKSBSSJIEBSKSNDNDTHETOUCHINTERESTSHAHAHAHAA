-- Create a ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DraggableFrame"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create a smaller frame
local frame = Instance.new("Frame")
frame.Name = "DraggableFrame"
frame.Size = UDim2.new(0.3, 0, 0.3, 0)  -- Adjust the size as needed
frame.BackgroundTransparency = 0.5
frame.BackgroundColor3 = Color3.new(0, 0, 0) -- You can change the color here
frame.Parent = screenGui

-- Create a TextLabel for the title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Text = "Touchinterest Parts"
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundColor3 = Color3.new(0, 0, 0)
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Parent = frame
titleLabel.BackgroundTransparency = 1

-- Create a TextLabel for the title
local titleLabell = Instance.new("TextLabel")
titleLabell.Name = "titleLabell"
titleLabell.Text = "Draggable"
titleLabell.Size = UDim2.new(1, 0, 0, 305)
titleLabell.BackgroundColor3 = Color3.new(0, 0, 0)
titleLabell.TextColor3 = Color3.new(1, 1, 1)
titleLabell.Parent = frame
titleLabell.BackgroundTransparency = 1

-- Create a close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 50, 0, 30)
closeButton.Position = UDim2.new(1, -60, 0, 10)
closeButton.Parent = frame

-- Create a button to bring TouchInterest parts
local bringButton = Instance.new("TextButton")
bringButton.Name = "BringTouchInterestButton"
bringButton.Text = "Bring TouchInterest"
bringButton.Size = UDim2.new(0, 150, 0, 30)
bringButton.Position = UDim2.new(0.5, -75, 0.5, -15)
bringButton.Parent = frame

-- Create a button to go to TouchInterest parts
local gotoButton = Instance.new("TextButton")
gotoButton.Name = "GotoTouchInterestsButton"
gotoButton.Text = "Goto TouchInterests"
gotoButton.Size = UDim2.new(0, 150, 0, 30)
gotoButton.Position = UDim2.new(0.5, -75, 0.5, 30)
gotoButton.Parent = frame

-- Make the frame draggable
local isDragging = false
local touchStartPosition = nil
local frameStartPosition = nil

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        touchStartPosition = input.Position
        frameStartPosition = frame.Position
    end
end)

frame.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - touchStartPosition
        frame.Position = frameStartPosition + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

frame.InputEnded:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        isDragging = false
    end
end)

-- Function to destroy the frame when the close button is clicked
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Function to bring TouchInterest parts when the "Bring TouchInterest" button is clicked
bringButton.MouseButton1Click:Connect(function()
    -- Get all the parts with TouchInterests.
    local parts = game.Workspace:GetDescendants()
    local partsWithTouchInterests = {}

    for _, part in pairs(parts) do
        if part:IsA("BasePart") and part:FindFirstChild("TouchInterest") then
            table.insert(partsWithTouchInterests, part)
        end
    end

    -- Teleport all the parts with TouchInterests to the player.
    local player = game.Players.LocalPlayer
    for _, part in pairs(partsWithTouchInterests) do
        part.CFrame = player.Character.HumanoidRootPart.CFrame
        wait(0.1)
    end
end)

-- Function to go to TouchInterest parts when the "Goto TouchInterests" button is clicked
gotoButton.MouseButton1Click:Connect(function()
    -- Get all the parts with TouchInterests.
    local parts = game.Workspace:GetDescendants()
    local partsWithTouchInterests = {}

    for _, part in pairs(parts) do
        if part:IsA("BasePart") and part:FindFirstChild("TouchInterest") then
            table.insert(partsWithTouchInterests, part)
        end
    end

    -- Teleport the player to all the parts with TouchInterests.
    local player = game.Players.LocalPlayer
    for _, part in pairs(partsWithTouchInterests) do
        player.Character.HumanoidRootPart.CFrame = part.CFrame
        wait(0.1)
    end
end)
