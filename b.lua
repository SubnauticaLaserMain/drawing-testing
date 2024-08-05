-- Create a new LocalScript in StarterPlayerScripts or StarterGui

-- Ensure Drawing API is available
repeat wait() until Drawing

-- Create a function to draw a box around a player's character
local function drawBoxAroundPlayer(player)
    -- Create lines for the box
    local lines = {}
    local function createLine(from, to, color, thickness)
        local line = Drawing.new("Line")
        line.From = from
        line.To = to
        line.Color = color
        line.Thickness = thickness
        line.Transparency = 0.5
        line.Visible = true
        return line
    end

    -- Create lines
    local function createBoxLines()
        -- Create lines for the box
        local top = createLine(Vector2.new(), Vector2.new(), Color3.fromRGB(255, 0, 0), 2)
        local right = createLine(Vector2.new(), Vector2.new(), Color3.fromRGB(255, 0, 0), 2)
        local bottom = createLine(Vector2.new(), Vector2.new(), Color3.fromRGB(255, 0, 0), 2)
        local left = createLine(Vector2.new(), Vector2.new(), Color3.fromRGB(255, 0, 0), 2)

        table.insert(lines, top)
        table.insert(lines, right)
        table.insert(lines, bottom)
        table.insert(lines, left)
    end

    createBoxLines()

    -- Update lines position based on player character
    game:GetService("RunService").RenderStepped:Connect(function()
        local character = player.Character
        if character and character:FindFirstChild("Head") then
            local head = character.Head
            local headPos, headOnScreen = workspace.CurrentCamera:WorldToScreenPoint(head.Position)

            if headOnScreen then
                -- Convert 3D world position to 2D screen position for the box
                local screenSize = workspace.CurrentCamera.ViewportSize
                local boxSize = Vector2.new(100, 100)  -- You may need to adjust this size

                -- Define box corners in 2D
                local topLeft = Vector2.new(headPos.X - boxSize.X / 2, headPos.Y - boxSize.Y / 2)
                local topRight = Vector2.new(headPos.X + boxSize.X / 2, headPos.Y - boxSize.Y / 2)
                local bottomLeft = Vector2.new(headPos.X - boxSize.X / 2, headPos.Y + boxSize.Y / 2)
                local bottomRight = Vector2.new(headPos.X + boxSize.X / 2, headPos.Y + boxSize.Y / 2)

                -- Update line positions
                lines[1].From = topLeft
                lines[1].To = topRight
                lines[2].From = topRight
                lines[2].To = bottomRight
                lines[3].From = bottomRight
                lines[3].To = bottomLeft
                lines[4].From = bottomLeft
                lines[4].To = topLeft
            end
        end
    end)
end

-- Draw boxes around all players
for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
    drawBoxAroundPlayer(player)
end
