_G.gamestart = false


function menuload()
    love.graphics.setBackgroundColor(0, 0, 0) -- Set the background color
    
    -- Set the font and font size
    font = love.graphics.newFont(32)

    sounds = {}

     sounds.music2 = love.audio.newSource("sounds/My-Dark-Passenger.mp3", "stream")
     sounds.music2:setLooping(true)

     sounds.music2:play()
    
    -- Set the buttons
    buttons = {}
    buttons[1] = {text = "Play Game", func = menuplayGame}
    buttons[2] = {text = "Exit Game", func = love.event.quit}
    
    -- Set the button size and position
    buttonWidth = 200
    buttonHeight = 50
    buttonX = (love.graphics.getWidth() / 2) - (buttonWidth / 2)
    buttonY = (love.graphics.getHeight() / 2) - (buttonHeight / 2)
    menuFont = love.graphics.newFont(32) -- Set font size for menu text
end

function menudraw()
    -- Draw the buttons
    for i, button in ipairs(buttons) do
        
        love.graphics.setColor(238, 232, 170)
        love.graphics.setFont(menuFont)
        love.graphics.printf("Tax Evasion", 0, love.graphics.getHeight()/3 - 100, love.graphics.getWidth(), "center") -- Draw menu title at the top center of the screen
        love.graphics.rectangle("fill", buttonX, buttonY + (i - 1) * (buttonHeight + 10), buttonWidth, buttonHeight)
        love.graphics.setColor(0, 0, 0)
        love.graphics.printf(button.text, font, buttonX, buttonY + (i - 1) * (buttonHeight + 10) + (buttonHeight / 2) - (font:getHeight() / 2), buttonWidth, "center")
    end
end

function love.mousepressed(x, y, button)
    -- Check if a button is clicked
    for i, button in ipairs(buttons) do
        if x > buttonX and x < buttonX + buttonWidth and y > buttonY + (i - 1) * (buttonHeight + 10) and y < buttonY + (i - 1) * (buttonHeight + 10) + buttonHeight then
            button.func()
        end
    end
end

function menuplayGame()
    titleScreen = false
    love.audio.stop()
   
end