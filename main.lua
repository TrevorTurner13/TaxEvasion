function love.load()
    wf = require 'Libraries/windfield'
    world = wf.newWorld(0, 0)
    _G.keycardGrabbed = false

    mainMenu = require 'Menu/menu'
    menuload()
    titleScreen = true
    luven = require 'luven/luven'
    camera = require 'Libraries/camera'

    sounds = {}
    sounds.music = love.audio.newSource("sounds/Sneaky-Snitch.mp3", "stream")
    sounds.music:setLooping(true)
    sounds.breaker = love.audio.newSource("sounds/breaker-switch-45684.mp3", "stream")
    sounds.breaker:setLooping(false)
    sounds.keycard = love.audio.newSource("sounds/money-pickup-2-89563.mp3", "stream")
    sounds.keycard:setLooping(false)
    sounds.egg = love.audio.newSource("sounds/chatton-87836.mp3", "stream")
    sounds.egg:setLooping(false)

    anim8 = require 'Libraries/anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")

    sti = require 'Libraries/sti'
    gamemap = sti('maps/Office2map.lua')

    keycardLarge = love.graphics.newImage("sprite sheet/keycard-sheet-large.png")
    keycard = love.graphics.newImage("sprite sheet/keycard.png")
    breakerOffTile = love.graphics.newImage("sprite sheet/breakeroff.png")
    EasterEgg1 = love.graphics.newImage("sprite sheet/EasterEgg.png")
    EasterEgg2 = love.graphics.newImage("sprite sheet/EasterEgg.png")
    EasterEgg3 = love.graphics.newImage("sprite sheet/EasterEgg.png")
    EasterEgg4 = love.graphics.newImage("sprite sheet/EasterEgg.png")
    EasterEgg5 = love.graphics.newImage("sprite sheet/EasterEgg.png")
    EasterEggLarge = love.graphics.newImage("sprite sheet/EasterEggLarge.png")

    gameOver = false
    winGame = false

    EasterEgg1Grabbed = false
    EasterEgg2Grabbed = false
    EasterEgg3Grabbed = false
    EasterEgg4Grabbed = false
    EasterEgg5Grabbed = false

    player = {}
    player.collider = world:newBSGRectangleCollider(5, 5, 20, 20, 3)
    player.collider:setFixedRotation(true)
    player.x = 900
    player.y = 900
    player.speed = 90
    player.spriteSheet = love.graphics.newImage('sprite sheet/Tax_Evader.png')
    player.grid = anim8.newGrid( 32, 32, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )

    player.animations = {}
    player.animations.down = anim8.newAnimation( player.grid('1-4', 1), 0.2 )
    player.animations.left = anim8.newAnimation( player.grid('1-4', 2), 0.2 )
    player.animations.right = anim8.newAnimation( player.grid('1-4', 3), 0.2 )
    player.animations.up = anim8.newAnimation( player.grid('1-4', 4), 0.2 )

    gMan1 = {}
    gMan1.x = 200
    gMan1.y = 110
    gMan1.spriteSheet = love.graphics.newImage("sprite sheet/G-man.png")
    gMan1.grid = anim8.newGrid( 32, 32, gMan1.spriteSheet:getWidth(), gMan1.spriteSheet:getHeight() )
    gMan1.dir = -1
    gMan1.movingRight = false

    gMan1.animations = {}
    gMan1.animations.down = anim8.newAnimation( gMan1.grid('1-8', 4), 0.2 )
    gMan1.animations.left = anim8.newAnimation( gMan1.grid('1-8', 3), 0.2 )
    gMan1.animations.right = anim8.newAnimation( gMan1.grid('1-8', 1), 0.2 )
    gMan1.animations.up = anim8.newAnimation( gMan1.grid('1-8', 2), 0.2 )

    gMan2 = {}
    gMan2.x = 700
    gMan2.y = 575
    gMan2.spriteSheet = love.graphics.newImage("sprite sheet/G-man.png")
    gMan2.grid = anim8.newGrid( 32, 32, gMan2.spriteSheet:getWidth(), gMan2.spriteSheet:getHeight() )
    gMan2.dir = -1
    gMan2.movingRight = false

    gMan2.animations = {}
    gMan2.animations.down = anim8.newAnimation( gMan2.grid('1-8', 4), 0.2 )
    gMan2.animations.left = anim8.newAnimation( gMan2.grid('1-8', 3), 0.2 )
    gMan2.animations.right = anim8.newAnimation( gMan2.grid('1-8', 1), 0.2 )
    gMan2.animations.up = anim8.newAnimation( gMan2.grid('1-8', 2), 0.2 )

    gMan3 = {}
    gMan3.x = 650
    gMan3.y = 200
    gMan3.spriteSheet = love.graphics.newImage("sprite sheet/G-man.png")
    gMan3.grid = anim8.newGrid( 32, 32, gMan3.spriteSheet:getWidth(), gMan3.spriteSheet:getHeight() )
    gMan3.dir = -1
    gMan3.movingRight = false
    gMan3.movingDown = true
    gMan3.movingUp = false
    gMan3.movingLeft = false

    gMan3.animations = {}
    gMan3.animations.down = anim8.newAnimation( gMan3.grid('1-8', 4), 0.2 )
    gMan3.animations.left = anim8.newAnimation( gMan3.grid('1-8', 3), 0.2 )
    gMan3.animations.right = anim8.newAnimation( gMan3.grid('1-8', 1), 0.2 )
    gMan3.animations.up = anim8.newAnimation( gMan3.grid('1-8', 2), 0.2 )

    gMan4 = {}
    gMan4.x = 850
    gMan4.y = 850
    gMan4.spriteSheet = love.graphics.newImage("sprite sheet/G-man.png")
    gMan4.grid = anim8.newGrid( 32, 32, gMan4.spriteSheet:getWidth(), gMan4.spriteSheet:getHeight() )
    gMan4.dir = -1
    gMan4.movingRight = false
    gMan4.movingDown = false
    gMan4.movingUp = true
    gMan4.movingLeft = false

    gMan4.animations = {}
    gMan4.animations.down = anim8.newAnimation( gMan4.grid('1-8', 4), 0.2 )
    gMan4.animations.left = anim8.newAnimation( gMan4.grid('1-8', 3), 0.2 )
    gMan4.animations.right = anim8.newAnimation( gMan4.grid('1-8', 1), 0.2 )
    gMan4.animations.up = anim8.newAnimation( gMan4.grid('1-8', 2), 0.2 )

    gMan5 = {}
    gMan5.x = 185
    gMan5.y = 785
    gMan5.spriteSheet = love.graphics.newImage("sprite sheet/G-man.png")
    gMan5.grid = anim8.newGrid( 32, 32, gMan5.spriteSheet:getWidth(), gMan5.spriteSheet:getHeight() )
    gMan5.dir = -1
    gMan5.movingUp = false

    gMan5.animations = {}
    gMan5.animations.down = anim8.newAnimation( gMan5.grid('1-8', 4), 0.2 )
    gMan5.animations.left = anim8.newAnimation( gMan5.grid('1-8', 3), 0.2 )
    gMan5.animations.right = anim8.newAnimation( gMan5.grid('1-8', 1), 0.2 )
    gMan5.animations.up = anim8.newAnimation( gMan5.grid('1-8', 2), 0.2 )

    player.anim = player.animations.left
    gMan1.anim = gMan1.animations.left
    gMan2.anim = gMan2.animations.left
    gMan3.anim = gMan3.animations.down
    gMan4.anim = gMan4.animations.up
    gMan5.anim = gMan5.animations.down
    
    breakerOff = false
    
    luven.init()
    luven.camera:init(player.x, player.y) -- center the camera.
    luven.camera:setScale(5)

    cam = camera(player.x, player.y)
    cam:zoom(5)

    player_light = luven.addNormalLight(player.x, player.y, luven.newColor(1.0, 0.75, 0.5), 0.2, round)  
    exit_light = luven.addNormalLight(900, 25, luven.newColor(1.0, 0, 0), 0.5, round)
    
    emergency_light1 = luven.addNormalLight(475, 100, luven.newColor(1.0, 0.75, 0.5), 0.75, luven.lightShapes.cone, 2)
    emergency_light2 = luven.addNormalLight(220, 0, luven.newColor(1.0, 0.75, 0.5), 0.75, luven.lightShapes.cone, 2)
    emergency_light3 = luven.addNormalLight(250, 950, luven.newColor(1.0, 0.75, 0.5), 0.75, luven.lightShapes.cone, 5.9)
    emergency_light4 = luven.addNormalLight(735, 600, luven.newColor(1.0, 0.75, 0.5), 0.75, luven.lightShapes.cone, 4)
    emergency_light5 = luven.addNormalLight(475, 750, luven.newColor(1.0, 0.75, 0.5), 0.75, luven.lightShapes.cone, 4.3 )
    emergency_light6 = luven.addNormalLight(10, 750, luven.newColor(1.0, 0.75, 0.5), 0.75, luven.lightShapes.cone, 5 )
    emergency_light7 = luven.addNormalLight(160, 950, luven.newColor(1.0, 0.75, 0.5), 0.75, luven.lightShapes.cone, 4 )
    emergency_light8 = luven.addNormalLight(950, 950, luven.newColor(1.0, 0.75, 0.5), 0.75, luven.lightShapes.cone, 4.5 )
    emergency_light9 = luven.addNormalLight(950, 350 , luven.newColor(1.0, 0.75, 0.5), 0.75, luven.lightShapes.cone, 2 )
    emergency_light10 = luven.addNormalLight(550, 0 , luven.newColor(1.0, 0.75, 0.5), 0.75, luven.lightShapes.cone, 0 )
    emergency_light11 = luven.addNormalLight(220, 415 , luven.newColor(1.0, 0.75, 0.5), 0.75, luven.lightShapes.cone, 3.8 )

    gMan1_flashlight = luven.addNormalLight(gMan1.x, gMan1.y, luven.newColor(1, 0.75, 0.5), 0.5, luven.lightShapes.cone, 3.14)
    gMan1_light = luven.addNormalLight(gMan1.x, gMan1.y, luven.newColor(1, 0.75, 0.5), 0.1)

    gMan2_flashlight = luven.addNormalLight(gMan2.x, gMan2.y, luven.newColor(1, 0.75, 0.5), 0.5, luven.lightShapes.cone, 3.14)
    gMan2_light = luven.addNormalLight(gMan2.x, gMan2.y, luven.newColor(1, 0.75, 0.5), 0.1)

    gMan3_flashlight = luven.addNormalLight(gMan3.x, gMan3.y, luven.newColor(1, 0.75, 0.5), 0.5, luven.lightShapes.cone, 3.14)
    gMan3_light = luven.addNormalLight(gMan3.x, gMan3.y, luven.newColor(1, 0.75, 0.5), 0.1)

    gMan4_flashlight = luven.addNormalLight(gMan4.x, gMan4.y, luven.newColor(1, 0.75, 0.5), 0.5, luven.lightShapes.cone, 3.14)
    gMan4_light = luven.addNormalLight(gMan4.x, gMan4.y, luven.newColor(1, 0.75, 0.5), 0.1)

    gMan5_flashlight = luven.addNormalLight(gMan5.x, gMan5.y, luven.newColor(1, 0.75, 0.5), 0.5, luven.lightShapes.cone, 3.14)
    gMan5_light = luven.addNormalLight(gMan5.x, gMan5.y, luven.newColor(1, 0.75, 0.5), 0.1)

    PLAYERHITBOX = {
        x = 0,
        y = 0,
        width = 32,
        height = 32,
        speed = 90
    }

    Flashlight1 = {
        x = 200,
        y = 110,
        width = 120,
        height = 50
    }
    Flashlight2 = {
        x = 700,
        y = 575,
        width = 120,
        height = 50
    }
    Flashlight3 = {
        x = 650,
        y = 200,
        width = 50,
        height = 120
    }
    Flashlight4 = {
        x = 850,
        y = 850,
        width = 120,
        height = 50
    }
    Flashlight5 = {
        x = 185,
        y = 785,
        width = 50,
        height = 120
    }

    walls={}
    if gamemap.layers["walls"]then
        for i, obj in pairs(gamemap.layers["walls"].objects)do
            local wall = world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height)
             wall:setType('static')
             table.insert(walls, wall)
        end
    end

end

function love.update(dt)
    if not gameOver then
        if not titleScreen then
            sounds.music:play()
    
            if breakerOff then
                luvenHandler(dt)
            else
                cam:lookAt(player.x,player.y)
            end
            local isMoving = false

            local vx = 0
            local vy = 0

            PLAYERHITBOX.x = player.x
            PLAYERHITBOX.y = player.y

            if gMan1.movingRight then
                Flashlight1.x = gMan1.x
            else
                Flashlight1.x = gMan1.x - 90
            end

            if gMan2.movingRight then
                Flashlight2.x = gMan2.x
            else
                Flashlight2.x = gMan2.x - 90
            end

            if gMan3.movingRight then
                Flashlight3.x = gMan3.x
                Flashlight3.width = 120
                Flashlight3.length = 50
            elseif gMan3.movingLeft then
                Flashlight3.x = gMan3.x - 90
                Flashlight3.width = 120
                Flashlight3.length = 50
            elseif gMan3.movingDown then
                Flashlight3.y = gMan3.y 
                Flashlight3.x = gMan3.x
                Flashlight3.width = 50
                Flashlight3.length = 120
            else
                Flashlight3.y = gMan3.y -90
                Flashlight3.x = gMan3.x 
                Flashlight3.width = 50
                Flashlight3.length = 120
            end


            if gMan4.movingRight then
                Flashlight4.x = gMan4.x
                Flashlight4.y = gMan4.y -10
                Flashlight4.width = 120
                Flashlight4.length = 50
            elseif gMan4.movingLeft then
                Flashlight4.x = gMan4.x - 90
                Flashlight4.y = gMan4.y - 5
                Flashlight4.width = 120
                Flashlight4.length = 50
            elseif gMan4.movingDown then
                Flashlight4.y = gMan4.y + 70
                Flashlight4.x = gMan4.x - 8
                Flashlight4.width = 50
                Flashlight4.length = 120
            else
                Flashlight4.y = gMan4.y - 90
                Flashlight4.x = gMan4.x 
                Flashlight4.width = 50
                Flashlight4.length = 120
            end 

            if gMan5.movingUp then
                Flashlight5.y = gMan5.y - 100
                Flashlight5.x = gMan5.x - 8
            else
                Flashlight5.y = gMan5.y + 10
                Flashlight5.x = gMan5.x - 15
            end 

            if love.keyboard.isDown("d") then
                vx = player.speed
                player.anim = player.animations.right
                isMoving = true
            end

            if love.keyboard.isDown("a") then
                vx = player.speed * -1
                player.anim = player.animations.left
                isMoving = true
            end

            if love.keyboard.isDown("s") then
                vy = player.speed 
                player.anim = player.animations.down
                isMoving = true
            end

            if love.keyboard.isDown("w") then
                vy = player.speed * -1
                player.anim = player.animations.up
                isMoving = true
            end
            if not breakerOff and player.x > 0 and player.x < 50 and player.y > 0 and player.y < 50 then
                if love.keyboard.isDown("x") then
                    breakerOff = true
                    sounds.breaker:play()
                end
            end

            if not _G.keycardGrabbed and player.x > 575 and player.x < 600 and player.y > 750 and player.y < 800 then
                if love.keyboard.isDown("x") then
                    _G.keycardGrabbed = true
                    sounds.keycard:play()
                end
            end

            if _G.keycardGrabbed and player.x > 830 and player.x < 1000 and player.y > 0 and player.y < 20 then
                if love.keyboard.isDown("x") then
                    winGame = true
            
                end
            end

            if winGame then
                if love.keyboard.isDown("escape") then
                    love.event.quit()
                end
            end

            

            if not EasterEgg1Grabbed and player.x > 175 and player.x < 220 and player.y > 215 and player.y < 265 then
                if love.keyboard.isDown("x") then
                    EasterEgg1Grabbed = true
                    sounds.egg:play()
                end
            end
            if not EasterEgg2Grabbed and player.x > 235 and player.x < 285 and player.y > 0 and player.y < 50 then
                if love.keyboard.isDown("x") then
                    EasterEgg2Grabbed = true
                    sounds.egg:play()
                end
            end        
            if not EasterEgg3Grabbed and player.x > 0 and player.x < 50 and player.y > 910 and player.y < 970 then
                if love.keyboard.isDown("x") then
                    EasterEgg3Grabbed = true
                    sounds.egg:play()
                end
            end
            if not EasterEgg4Grabbed and player.x > 510 and player.x < 560 and player.y > 375 and player.y < 425 then
                if love.keyboard.isDown("x") then
                    EasterEgg4Grabbed = true
                    sounds.egg:play()
                end
            end
            if not EasterEgg5Grabbed and player.x > 625 and player.x < 650 and player.y > 610 and player.y < 660 then
                if love.keyboard.isDown("x") then
                    EasterEgg5Grabbed = true
                    sounds.egg:play()
                end
            end

            player.collider:setLinearVelocity(vx, vy)

                if isMoving == false then
                    player.anim:gotoFrame(2)
            end

            world:update(dt)
            player.x = player.collider:getX() - 10
            player.y = player.collider:getY() - 8

            player.anim: update(dt)
            gMan1.anim:update(dt)
            gMan2.anim:update(dt)
            gMan3.anim:update(dt)
            gMan4.anim:update(dt)
            gMan5.anim:update(dt)

            cameraControl()
            
            enemyMovement(dt)
        end    
   
    else 
        if love.keyboard.isDown("escape") then
                    love.event.quit()
        end
    end
end

  

function love.draw()
    if titleScreen then
        menudraw()
    else 
   
        if breakerOff then
        luven.drawBegin()    
        luven.camera:setMoveTarget(player.x,player.y)
        gamemap:drawLayer(gamemap.layers["Tile Layer 1"])
        gamemap:drawLayer(gamemap.layers["Tile Layer 2"])
        love.graphics.draw(breakerOffTile, 0, 32)
        if not keycardGrabbed then
            love.graphics.draw(keycard, 590, 775)
        end
        if not EasterEgg1Grabbed then
            love.graphics.draw(EasterEgg1, 200, 240)
        end
        if not EasterEgg2Grabbed then
            love.graphics.draw(EasterEgg2, 260, 10)
        end
        if not EasterEgg3Grabbed then
            love.graphics.draw(EasterEgg3, 10, 935) 
        end
        if not EasterEgg4Grabbed then
            love.graphics.draw(EasterEgg3, 535, 400) 
        end
        if not EasterEgg5Grabbed then
            love.graphics.draw(EasterEgg3, 650, 635) 
        end
        player.anim:draw(player.spriteSheet, player.x, player.y, nil, 1, nil, 6, 9) 
        gMan1.anim:draw(gMan1.spriteSheet, gMan1.x, gMan1.y, nil, 1, nil, 6, 9)
        gMan2.anim:draw(gMan2.spriteSheet, gMan2.x, gMan2.y, nil, 1, nil, 6, 9)
        gMan3.anim:draw(gMan3.spriteSheet, gMan3.x, gMan3.y, nil, 1, nil, 6, 9)
        gMan4.anim:draw(gMan4.spriteSheet, gMan4.x, gMan4.y, nil, 1, nil, 6, 9)
        gMan5.anim:draw(gMan5.spriteSheet, gMan5.x, gMan5.y, nil, 1, nil, 6, 9)
        
        luven.drawEnd()
        
        if not _G.keycardGrabbed and player.x > 575 and player.x < 600 and player.y > 750 and player.y < 800 then
            local rectWidth1, rectHeight1 = 50, 60 -- change the size of the rectangle here
            love.graphics.setColor(0, 0, 0) -- set the fill color to black
            love.graphics.rectangle("fill", 1100, 740, rectWidth1, rectHeight1)
            love.graphics.setColor(1, 1, 1) -- set the outline color to white
            love.graphics.setLineWidth(2) -- set the line width to 5
            love.graphics.rectangle("line", 1100, 740, rectWidth1, rectHeight1)
            love.graphics.setColor(1, 1, 1) -- set the text color to white
            love.graphics.setFont(love.graphics.newFont(10)) -- change the font size here
            love.graphics.printf("Press x to pick up keycard", 1100, 780 - rectHeight1 / 2, rectWidth1, "center")
        end
        if not keycardGrabbed and player.x > 830 and player.x < 1000 and player.y > 0 and player.y < 20 then
            -- IF STATEMENT, TELL PLAYER CANNOT LEAVE WITHOUT CARD
            local rectWidth2, rectHeight2 = 70  , 80 -- change the size of the rectangle here
            love.graphics.setColor(0, 0, 0) -- set the fill color to black
            love.graphics.rectangle("fill", 1570, 20, rectWidth2, rectHeight2)
            love.graphics.setColor(1, 1, 1) -- set the outline color to white
            love.graphics.setLineWidth(2) -- set the line width to 5
            love.graphics.rectangle("line", 1570, 20, rectWidth2, rectHeight2)
            love.graphics.setColor(1, 1, 1) -- set the text color to white
            love.graphics.setFont(love.graphics.newFont(15)) -- change the font size here
            love.graphics.printf("Find the keycard", 1570, 70 - rectHeight2 / 2, rectWidth2, "center")      
        end
        if keycardGrabbed and player.x > 830 and player.x < 1000 and player.y > 0 and player.y < 20 then
            local rectWidth2, rectHeight2 = 70  , 80 -- change the size of the rectangle here
            love.graphics.setColor(0, 0, 0) -- set the fill color to black
            love.graphics.rectangle("fill", 1570, 20, rectWidth2, rectHeight2)
            love.graphics.setColor(1, 1, 1) -- set the outline color to white
            love.graphics.setLineWidth(2) -- set the line width to 5
            love.graphics.rectangle("line", 1570, 20, rectWidth2, rectHeight2)
            love.graphics.setColor(1, 1, 1) -- set the text color to white
            love.graphics.setFont(love.graphics.newFont(15)) -- change the font size here
            love.graphics.printf("You did it! Press X to exit!", 1570, 70 - rectHeight2 / 2, rectWidth2, "center") 
        end
        

        if checkCollision(PLAYERHITBOX, Flashlight1) then
            --GAME OVER SCREEN
            gameOver = true
        end

        if checkCollision(PLAYERHITBOX, Flashlight2) then
            --GAME OVER SCREEN
            gameOver = true
        end

        if checkCollision(PLAYERHITBOX, Flashlight3) then
            --GAME OVER SCREEN
            gameOver = true
        end

        if checkCollision(PLAYERHITBOX, Flashlight4) then
            --GAME OVER SCREEN
            gameOver = true
        end

        if checkCollision(PLAYERHITBOX, Flashlight5) then
            --GAME OVER SCREENaaaaa
            gameOver = true
        end

        EasterEggDraw()

        love.graphics.print("Tax Evasion", 10, 10)
        cutsceneDraw()
        if keycardGrabbed then
            love.graphics.draw(keycardLarge, 1550, 925)
        end
        if EasterEgg1Grabbed then
            love.graphics.draw(EasterEggLarge, 1400, 925)
        end
        if EasterEgg2Grabbed then
            love.graphics.draw(EasterEggLarge, 1300, 925)
        end
        if EasterEgg3Grabbed then
            love.graphics.draw(EasterEggLarge, 1200, 925)
        end
        if EasterEgg4Grabbed then
            love.graphics.draw(EasterEggLarge, 1100, 925)
        end
        if EasterEgg5Grabbed then
            love.graphics.draw(EasterEggLarge, 1000, 925)
        end

    else
        cam:attach()        
        gamemap:drawLayer(gamemap.layers["Tile Layer 1"])
        gamemap:drawLayer(gamemap.layers["Tile Layer 2"])
        if not keycardGrabbed then
            love.graphics.draw(keycard, 590,775)
        end
        if not EasterEgg1Grabbed then
            love.graphics.draw(EasterEgg1, 200, 240)
        end
        if not EasterEgg2Grabbed then
            love.graphics.draw(EasterEgg2, 260, 10)
        end
        if not EasterEgg3Grabbed then
            love.graphics.draw(EasterEgg3, 10, 935) 
        end
        if not EasterEgg4Grabbed then
            love.graphics.draw(EasterEgg3, 535, 400) 
        end
        if not EasterEgg5Grabbed then
            love.graphics.draw(EasterEgg3, 650, 635) 
        end
        
        player.anim:draw(player.spriteSheet, player.x, player.y, nil, 1, nil, 6, 9) 
        gMan1.anim:draw(gMan1.spriteSheet, gMan1.x, gMan1.y, nil, 1, nil, 6, 9)
        gMan2.anim:draw(gMan2.spriteSheet, gMan2.x, gMan2.y, nil, 1, nil, 6, 9) 
        gMan3.anim:draw(gMan3.spriteSheet, gMan3.x, gMan3.y, nil, 1, nil, 6, 9)
        gMan4.anim:draw(gMan3.spriteSheet, gMan4.x, gMan4.y, nil, 1, nil, 6, 9)   
        gMan5.anim:draw(gMan5.spriteSheet, gMan5.x, gMan5.y, nil, 1, nil, 6, 9)
        
        if checkCollision(PLAYERHITBOX, Flashlight1) then
            --GAME OVER SCREEN
            gameOver = true
        end

        if checkCollision(PLAYERHITBOX, Flashlight2) then
            --GAME OVER SCREEN
            gameOver = true
        end

        if checkCollision(PLAYERHITBOX, Flashlight3) then
            --GAME OVER SCREEN
            gameOver = true
        end

        if checkCollision(PLAYERHITBOX, Flashlight4) then
            --GAME OVER SCREEN
            gameOver = true
        end

        if checkCollision(PLAYERHITBOX, Flashlight5) then
            --GAME OVER SCREENaaaaa
            gameOver = true
        end
        love.graphics.setColor( 0, 0, 0, 0 )
        love.graphics.rectangle("fill", PLAYERHITBOX.x + 2, PLAYERHITBOX.y - 1, 16, 16)

        if gMan1.movingRight then
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan1.x + 2, gMan1.y - 15, 120, 50)
        else
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan1.x -102, gMan1.y - 15, 120, 50)
        end

        if gMan2.movingRight then
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan2.x + 2, gMan2.y - 15, 120, 50)
        else
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan2.x -102, gMan2.y - 15, 120, 50)
        end

        if gMan3.movingLeft then
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan3.x - 102, gMan3.y - 15, 120, 50)

        elseif gMan3.movingRight then
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan3.x + 2, gMan3.y - 15, 120, 50)
        
        elseif gMan3.movingUp then
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan3.x - 15, gMan3.y - 104, 50, 120)
        else 
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan3.x - 15 , gMan3.y, 50, 120)
        end


        if gMan4.movingLeft then
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan4.x - 102, gMan4.y - 15, 120, 50)
            
        elseif gMan4.movingRight then
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan4.x + 2, gMan4.y - 15, 120, 50)
        
        elseif gMan4.movingUp then
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan4.x - 15, gMan4.y - 104, 50, 120)
        else
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan4.x - 15 , gMan4.y, 50, 120)
        end 

        if gMan5.movingUp then
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan5.x - 15, gMan5.y - 104, 50, 120)
        else
            love.graphics.setColor( 0, 0, 0, 0 )
            love.graphics.rectangle("fill", gMan5.x - 15 , gMan5.y, 50, 120)
        end 

        cam:detach()

        if not keycardGrabbed and player.x > 830 and player.x < 1000 and player.y > 0 and player.y < 20 then
            -- IF STATEMENT, TELL PLAYER CANNOT LEAVE WITHOUT CARD
            local rectWidth2, rectHeight2 = 70  , 80 -- change the size of the rectangle here
            love.graphics.setColor(0, 0, 0) -- set the fill color to black
            love.graphics.rectangle("fill", 1570, 20, rectWidth2, rectHeight2)
            love.graphics.setColor(1, 1, 1) -- set the outline color to white
            love.graphics.setLineWidth(2) -- set the line width to 5
            love.graphics.rectangle("line", 1570, 20, rectWidth2, rectHeight2)
            love.graphics.setColor(1, 1, 1) -- set the text color to white
            love.graphics.setFont(love.graphics.newFont(15)) -- change the font size here
            love.graphics.printf("Find the keycard", 1570, 70 - rectHeight2 / 2, rectWidth2, "center")             
        end

        if not breakerOff and player.x > 0 and player.x < 100 and player.y > 0 and player.y < 100 then
            local rectWidth, rectHeight = 50  , 60 -- change the size of the rectangle here
            love.graphics.setColor(0, 0, 0) -- set the fill color to black
            love.graphics.rectangle("fill", 12, 110, rectWidth, rectHeight)
            love.graphics.setColor(1, 1, 1) -- set the outline color to white
            love.graphics.setLineWidth(2) -- set the line width to 5
            love.graphics.rectangle("line", 12, 110, rectWidth, rectHeight)
            love.graphics.setColor(1, 1, 1) -- set the text color to white
            love.graphics.setFont(love.graphics.newFont(10)) -- change the font size here
            love.graphics.printf("Press X to shut off the Breaker", 10, 145 - rectHeight / 2, rectWidth, "center") 
        end
        EasterEggDraw()
        
        love.graphics.print("Tax Evasion", 10, 10)
        cutsceneDraw()
        if keycardGrabbed then
            love.graphics.draw(keycardLarge, 1550, 925)
        end
        if EasterEgg1Grabbed then
            love.graphics.draw(EasterEggLarge, 1400, 925)
        end
        if EasterEgg2Grabbed then
            love.graphics.draw(EasterEggLarge, 1300, 925)
        end
        if EasterEgg3Grabbed then
            love.graphics.draw(EasterEggLarge, 1200, 925)
        end
        if EasterEgg4Grabbed then
            love.graphics.draw(EasterEggLarge, 1100, 925)
        end
        if EasterEgg5Grabbed then
            love.graphics.draw(EasterEggLarge, 1000, 925)
        end
        end
    
    end
end

function cutsceneDraw()
    
    if breakerOff and not keycardGrabbed then
         local rectWidth, rectHeight = 150, 120 -- change the size of the rectangle here
        love.graphics.setColor(0, 0, 0) -- set the fill color to black
        love.graphics.rectangle("fill", 1620, 880, rectWidth, rectHeight)
        love.graphics.setColor(1, 1, 1) -- set the outline color to white
        love.graphics.setLineWidth(5) -- set the line width to 5
        love.graphics.rectangle("line", 1620, 880, rectWidth, rectHeight)
        love.graphics.setColor(1, 1, 1) -- set the text color to white
        love.graphics.setFont(love.graphics.newFont(15)) -- change the font size here
        love.graphics.printf("Find the keycard to escape the I.R.S. Avoid their flashlights or you will be caught", 1620, 950 - rectHeight / 2, rectWidth, "center")
    elseif not breakerOff then
        local rectWidth, rectHeight = 150, 120 -- change the size of the rectangle here
        love.graphics.setColor(0, 0, 0) -- set the fill color to black
        love.graphics.rectangle("fill", 1620, 880, rectWidth, rectHeight)
        love.graphics.setColor(1, 1, 1) -- set the outline color to white
        love.graphics.setLineWidth(5) -- set the line width to 5
        love.graphics.rectangle("line", 1620, 880, rectWidth, rectHeight)
        love.graphics.setColor(1, 1, 1) -- set the text color to white
        love.graphics.setFont(love.graphics.newFont(15)) -- change the font size here
        love.graphics.printf("The Feds are coming! Shut off the breaker and make your escape!", 1620, 940 - rectHeight / 2, rectWidth, "center") 
    elseif keycardGrabbed then
        local rectWidth, rectHeight = 150, 120 -- change the size of the rectangle here
        love.graphics.setColor(0, 0, 0) -- set the fill color to black
        love.graphics.rectangle("fill", 1620, 880, rectWidth, rectHeight)
        love.graphics.setColor(1, 1, 1) -- set the outline color to white
        love.graphics.setLineWidth(5) -- set the line width to 5
        love.graphics.rectangle("line", 1620, 880, rectWidth, rectHeight)
        love.graphics.setColor(1, 1, 1) -- set the text color to white
        love.graphics.setFont(love.graphics.newFont(15)) -- change the font size here
        love.graphics.printf("Keycard collected! Head for the exit!", 1620, 950 - rectHeight / 2, rectWidth, "center")
    end
    if winGame then
        local rectWidth, rectHeight = 500, 300 -- change the size of the rectangle here
        love.graphics.setColor(0, 0, 0) -- set the fill color to black
        love.graphics.rectangle("fill", 810 , 440, rectWidth, rectHeight)
        love.graphics.setColor(1, 1, 1) -- set the outline color to white
        love.graphics.setLineWidth(5) -- set the line width to 5
        love.graphics.rectangle("line", 810, 440, rectWidth, rectHeight)
        love.graphics.setColor(1, 1, 1) -- set the text color to white
        love.graphics.setFont(love.graphics.newFont(25)) -- change the font size here
        love.graphics.printf("Congrats! You escaped the I.R.S!  Press ESC to exit game.", 810, 700 - rectHeight / 2, rectWidth, "center")
    end
    
        if gameOver then
            local rectWidth, rectHeight = 500, 300 -- change the size of the rectangle here
            love.graphics.setColor(0, 0, 0) -- set the fill color to black
            love.graphics.rectangle("fill", 810, 440, rectWidth, rectHeight)
            love.graphics.setColor(1, 1, 1) -- set the outline color to white
            love.graphics.setLineWidth(5) -- set the line width to 5
            love.graphics.rectangle("line", 810, 440, rectWidth, rectHeight)
            love.graphics.setColor(1, 1, 1) -- set the text color to white
            love.graphics.setFont(love.graphics.newFont(25)) -- change the font size here
            love.graphics.printf("You Failed! Try harder next time! Press ESC to exit game.", 810, 700 - rectHeight / 2, rectWidth, "center")
    
    end
    
end

function cameraControl()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    if breakerOff then
        if luven.camera.x*5 < w/2 then
            luven.camera.x = w/2/5
        end 
        if luven.camera.y*5 < h/2 then
            luven.camera.y = h/2/5
        end

        local mapW = gamemap.width * gamemap.tilewidth
        local mapH = gamemap.height * gamemap.tileheight

        --Right border
        if luven.camera.x > (mapW - w/2/5) then 
            luven.camera.x = (mapW - w/2/5)
        end

        -- Bottom border
        if luven.camera.y > (mapH - h/2/5) then 
            luven.camera.y = (mapH - h/2/5)
        end  
    else
        if cam.x*5 < w/2 then
            cam.x = w/2/5
        end
        if cam.y*5 < h/2 then
            cam.y = h/2/5
        end

        local mapW = gamemap.width * gamemap.tilewidth
        local mapH = gamemap.height * gamemap.tileheight

        if cam.x > (mapW - w/2/5) then 
            cam.x = (mapW - w/2/5)
        end

        -- Bottom border
        if cam.y > (mapH - h/2/5) then 
            cam.y = (mapH - h/2/5)
        end  
    end
end

function enemyMovement(dt)
    gMan1.x = gMan1.x + 20 * gMan1.dir * dt
    if gMan1.x <= 50 then
        gMan1.x = 50 
        gMan1.dir = gMan1.dir * -1
        gMan1.anim = gMan1.animations.right
        gMan1.movingRight = true
    end

    if gMan1.x >= 200 then
        gMan1.x = 200 
        gMan1.dir = gMan1.dir * -1
        gMan1.anim = gMan1.animations.left
        gMan1.movingRight = false
    end

    gMan2.x = gMan2.x + 20 * gMan2.dir * dt
    if gMan2.x <= 175 then
        gMan2.x = 175 
        gMan2.dir = gMan2.dir * -1
        gMan2.anim = gMan2.animations.right
        gMan2.movingRight = true
    end

    if gMan2.x >= 700 then
        gMan2.x = 700 
        gMan2.dir = gMan2.dir * -1
        gMan2.anim = gMan2.animations.left
        gMan2.movingRight = false
    end

    
    if gMan3.y <= 325 and gMan3.x >= 650 and gMan3.movingDown then
        gMan3.y = gMan3.y - 20 * gMan3.dir * dt
        if gMan3.y >= 325 and gMan3.x >= 650 and gMan3.movingDown then
        gMan3.y = 325
        gMan3.dir = gMan3.dir * -1
        gMan3.anim = gMan3.animations.left
        gMan3.movingDown = false
        gMan3.movingLeft = true
        end
    elseif gMan3.x >= 525 and gMan3.y >= 325 and gMan3.movingLeft then
        gMan3.x = gMan3.x - 20 * gMan3.dir * dt
        if gMan3.x <= 525 and gMan3.y >= 325 and gMan3.movingLeft then
        gMan3.x = 525 
        gMan3.dir = gMan3.dir * -1
        gMan3.anim = gMan3.animations.up
        gMan3.movingLeft = false
        gMan3.movingUp = true
        end
    elseif gMan3.y >= 150 and gMan3.x <= 525 and gMan3.movingUp then
        gMan3.y = gMan3.y + 20 * gMan3.dir * dt
        if gMan3.y <= 150 and gMan3.x <= 525 and gMan3.movingUp then
        gMan3.y = 150 
        gMan3.dir = gMan3.dir * -1
        gMan3.anim = gMan3.animations.down
        gMan3.movingDown = true
        gMan3.movingUp = false
        end
    elseif gMan3.y <= 325 and gMan3.x <= 525 and gMan3.movingDown then
        gMan3.y = gMan3.y + 20 * gMan3.dir * dt
        if gMan3.y >= 325 and gMan3.x <=525 and gMan3.movingDown then
        gMan3.y = 325
        gMan3.dir = gMan3.dir * -1
        gMan3.anim = gMan3.animations.right
        gMan3.movingDown = false
        gMan3.movingRight = true
        end
    elseif gMan3.x <= 650 and gMan3.y >= 325 and gMan3.movingRight then
        gMan3.x = gMan3.x - 20 * gMan3.dir * dt
        if gMan3.x >= 650 and gMan3.y >=325 and gMan3.movingRight then
        gMan3.x = 650 
        gMan3.dir = gMan3.dir * -1
        gMan3.anim = gMan3.animations.up
        gMan3.movingRight = false
        gMan3.movingUp = true
        end
    elseif gMan3.y >= 200 and gMan3.x >= 650 and gMan3.movingUp then
        gMan3.y = gMan3.y - 20 * gMan3.dir * dt
        if gMan3.y <= 200 and gMan3.x >= 650 and gMan3.movingUp then
        gMan3.y = 200 
        gMan3.dir = gMan3.dir * -1
        gMan3.anim = gMan3.animations.down
        gMan3.movingDown = true
        gMan3.movingUp = false
        end
    end

    if gMan4.y >= 725 and gMan4.x >= 850 and gMan4.movingUp then
        gMan4.y = gMan4.y + 20 * gMan4.dir * dt
        if gMan4.y <= 725 and gMan4.x >= 850 and gMan4.movingUp then
        gMan4.y = 725
        gMan4.dir = gMan4.dir * -1
        gMan4.anim = gMan4.animations.left
        gMan4.movingUp = false
        gMan4.movingLeft = true
        end
    elseif gMan4.x >= 625 and gMan4.y <= 725 and gMan4.movingLeft then
        gMan4.x = gMan4.x - 20 * gMan4.dir * dt
        if gMan4.x <= 625 and gMan4.y <= 725 and gMan4.movingLeft then
        gMan4.x = 625
        gMan4.dir = gMan4.dir * -1
        gMan4.anim = gMan4.animations.down
        gMan4.movingLeft = false
        gMan4.movingDown = true
        end
    elseif gMan4.y <= 850 and gMan4.x <= 625 and gMan4.movingDown then
        gMan4.y = gMan4.y - 20 * gMan4.dir * dt
        if gMan4.y >= 850 and gMan4.x <= 625 and gMan4.movingDown then
        gMan4.y = 850 
        gMan4.dir = gMan4.dir * -1
        gMan4.anim = gMan4.animations.right
        gMan4.movingDown = false
        gMan4.movingRight = true
        end
    elseif gMan4.x <= 850 and gMan4.y >= 850 and gMan4.movingRight then
        gMan4.x = gMan4.x + 20 * gMan4.dir * dt
        if gMan4.x >=850 and gMan4.y >= 850 and gMan4.movingRight then
        gMan4.y = 850
        gMan4.dir = gMan4.dir * -1
        gMan4.anim = gMan4.animations.up
        gMan4.movingRight = false
        gMan4.movingUp = true
        end
    end

    gMan5.y = gMan5.y - 20 * gMan5.dir * dt
    if gMan5.y >= 925 then
        gMan5.y = 925 
        gMan5.dir = gMan5.dir * -1
        gMan5.anim = gMan5.animations.up
        gMan5.movingUp = true
    end

    if gMan5.y <= 785 then
        gMan5.y = 785 
        gMan5.dir = gMan5.dir * -1
        gMan5.anim = gMan5.animations.down
        gMan5.movingUp = false
    end
end

function luvenHandler(dt)
    luven.update(dt)
    luven.playerLight(player_light ,player.x+7 ,player.y+7)

    if gMan1.movingRight then
        luven.gManLight(gMan1_flashlight, gMan1.x+23, gMan1.y+2, 0)
    else
        luven.gManLight(gMan1_flashlight, gMan1.x-3, gMan1.y+12, 3.14)
    end

    if gMan2.movingRight then
        luven.gManLight(gMan2_flashlight, gMan2.x+23, gMan2.y+2, 0)
    else
        luven.gManLight(gMan2_flashlight, gMan2.x-3, gMan2.y+12, 3.14)
    end

    if gMan3.movingRight then
        luven.gManLight(gMan3_flashlight, gMan3.x+23, gMan3.y+2, 0)
    elseif gMan3.movingLeft then
        luven.gManLight(gMan3_flashlight, gMan3.x-3, gMan3.y+12, 3.14)
    elseif gMan3.movingDown then
        luven.gManLight(gMan3_flashlight, gMan3.x+10, gMan3.y+20, 1.57)
    elseif gMan3.movingUp then
        luven.gManLight(gMan3_flashlight, gMan3.x+3, gMan3.y-10, 4.712)
    end

    if gMan4.movingRight then
        luven.gManLight(gMan4_flashlight, gMan4.x+23, gMan4.y+2, 0)
    elseif gMan4.movingLeft then
        luven.gManLight(gMan4_flashlight, gMan4.x-3, gMan4.y+12, 3.14)
    elseif gMan4.movingDown then
        luven.gManLight(gMan4_flashlight, gMan4.x+10, gMan4.y+20, 1.57)
    elseif gMan4.movingUp then
        luven.gManLight(gMan4_flashlight, gMan4.x+3, gMan4.y-10, 4.712)
    end

    if gMan5.movingUp then
        luven.gManLight(gMan5_flashlight, gMan5.x+3, gMan5.y-10, 4.712)
    else
        luven.gManLight(gMan5_flashlight, gMan5.x+10, gMan5.y+20, 1.57)
    end

    luven.playerLight(gMan1_light, gMan1.x+7, gMan1.y+7)
    luven.playerLight(gMan2_light, gMan2.x+7, gMan2.y+7)
    luven.playerLight(gMan3_light, gMan3.x+7, gMan3.y+7)
    luven.playerLight(gMan4_light, gMan4.x+7, gMan4.y+7)
    luven.playerLight(gMan5_light, gMan5.x+7, gMan5.y+7)
    luven.camera:setPosition(player.x,player.y)
end

function checkCollision(a, b)
    a_left = a.x
    a_right = a.x + a.width
    a_top = a.y
    a_bottom = a.y + a.height

    b_left = b.x
    b_right = b.x + b.width
    b_top = b.y
    b_bottom = b.y + b.height

    --If Red's right side is further to the right than Blue's left side.
    if  a_right > b_left
    --and Red's left side is further to the left than Blue's right side.
    and a_left < b_right
    --and Red's bottom side is further to the bottom than Blue's top side.
    and a_bottom > b_top
    --and Red's top side is further to the top than Blue's bottom side then..
    and a_top < b_bottom then
        --There is collision!
        return true
    else
        --If one of these statements is false, return false.
        return false
    end
end

function EasterEggDraw()
    if not EasterEgg1Grabbed and player.x > 175 and player.x < 220 and player.y > 215 and player.y < 265 then
        local rectWidth2, rectHeight2 = 70  , 80 -- change the size of the rectangle here
        love.graphics.setColor(0, 0, 0) -- set the fill color to black
        love.graphics.rectangle("fill", 1000, 900, rectWidth2, rectHeight2)
        love.graphics.setColor(1, 1, 1) -- set the outline color to white
        love.graphics.setLineWidth(2) -- set the line width to 5
        love.graphics.rectangle("line", 1000, 900, rectWidth2, rectHeight2)
        love.graphics.setColor(1, 1, 1) -- set the text color to white
        love.graphics.setFont(love.graphics.newFont(15)) -- change the font size here
        love.graphics.printf("X to collect Easter Egg!", 1000, 940 - rectHeight2 / 2, rectWidth2, "center") 
    end 
    if not EasterEgg2Grabbed and player.x > 235 and player.x < 285 and player.y > 0 and player.y < 50 then
        local rectWidth2, rectHeight2 = 70  , 80 -- change the size of the rectangle here
        love.graphics.setColor(0, 0, 0) -- set the fill color to black
        love.graphics.rectangle("fill", 1000, 900, rectWidth2, rectHeight2)
        love.graphics.setColor(1, 1, 1) -- set the outline color to white
        love.graphics.setLineWidth(2) -- set the line width to 5
        love.graphics.rectangle("line", 1000, 900, rectWidth2, rectHeight2)
        love.graphics.setColor(1, 1, 1) -- set the text color to white
        love.graphics.setFont(love.graphics.newFont(15)) -- change the font size here
        love.graphics.printf("X to collect Easter Egg!", 1000, 940 - rectHeight2 / 2, rectWidth2, "center") 
    end 
    if not EasterEgg3Grabbed and player.x > 0 and player.x < 50 and player.y > 910 and player.y < 970 then
        local rectWidth2, rectHeight2 = 70  , 80 -- change the size of the rectangle here
        love.graphics.setColor(0, 0, 0) -- set the fill color to black
        love.graphics.rectangle("fill", 1000, 900, rectWidth2, rectHeight2)
        love.graphics.setColor(1, 1, 1) -- set the outline color to white
        love.graphics.setLineWidth(2) -- set the line width to 5
        love.graphics.rectangle("line", 1000, 900, rectWidth2, rectHeight2)
        love.graphics.setColor(1, 1, 1) -- set the text color to white
        love.graphics.setFont(love.graphics.newFont(15)) -- change the font size here
        love.graphics.printf("X to collect Easter Egg!", 1000, 940 - rectHeight2 / 2, rectWidth2, "center") 
    end
   
    if not EasterEgg4Grabbed and player.x > 510 and player.x < 560 and player.y > 375 and player.y < 425 then
        local rectWidth2, rectHeight2 = 70  , 80 -- change the size of the rectangle here
        love.graphics.setColor(0, 0, 0) -- set the fill color to black
        love.graphics.rectangle("fill", 1000, 900, rectWidth2, rectHeight2)
        love.graphics.setColor(1, 1, 1) -- set the outline color to white
        love.graphics.setLineWidth(2) -- set the line width to 5
        love.graphics.rectangle("line", 1000, 900, rectWidth2, rectHeight2)
        love.graphics.setColor(1, 1, 1) -- set the text color to white
        love.graphics.setFont(love.graphics.newFont(15)) -- change the font size here
        love.graphics.printf("X to collect Easter Egg!", 1000, 940 - rectHeight2 / 2, rectWidth2, "center") 
    end
    
   
    if not EasterEgg5Grabbed and player.x > 625 and player.x < 650 and player.y > 610 and player.y < 660 then
        local rectWidth2, rectHeight2 = 70  , 80 -- change the size of the rectangle here
        love.graphics.setColor(0, 0, 0) -- set the fill color to black
        love.graphics.rectangle("fill", 1000, 900, rectWidth2, rectHeight2)
        love.graphics.setColor(1, 1, 1) -- set the outline color to white
        love.graphics.setLineWidth(2) -- set the line width to 5
        love.graphics.rectangle("line", 1000, 900, rectWidth2, rectHeight2)
        love.graphics.setColor(1, 1, 1) -- set the text color to white
        love.graphics.setFont(love.graphics.newFont(15)) -- change the font size here
        love.graphics.printf("X to collect Easter Egg!", 1000, 940 - rectHeight2 / 2, rectWidth2, "center") 
    end
end