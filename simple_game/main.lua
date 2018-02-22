-- Hello! this game was made by a person who is learning lua / love engine
-- help will be welcome
debug = true
if debug then
   love.audio.setVolume(.5)
end

-- sound
music = love.audio.newSource('main.wav')
music:setLooping(true)
music:play()

player = {x = 100, y=500, speed=400, img=nil}

-- Shoot
canShoot = True
canShootTimerMax = 0.5
canShootTimer = canShootTimerMax

bulletImg = nil

bullets = {}

-- enimes
createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax

enemyImg = nil

enemies = {}

-- score
isAlive = true
score = 0

function movimentacao(framerate)
    -- movimentação
    if love.keyboard.isDown('left', 'a') then
        if player.x > 0 then
            player.x = player.x - (player.speed * framerate)
        end
    elseif love.keyboard.isDown('right', 'd') then
        if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
            player.x = player.x + (player.speed * framerate)
        end
    end

    if love.keyboard.isDown('up', 'w') then
        if player.y > 0 then
            player.y = player.y - (player.speed * framerate)
        end
    elseif love.keyboard.isDown('down', 's') then
        if player.y < (love.graphics.getHeight() - player.img:getHeight()) then
            player.y = player.y + (player.speed * framerate)
        end
    end
end

function bullets_fun(time)
    canShootTimer = canShootTimer - (1 * time)
    if canShootTimer < 0 then
        canShoot = true
    end
end

function shooting()
    -- criando tiros
    if love.keyboard.isDown('space', 'rctrl', 'lctrl', 'ctrl') and canShoot then
        newBullet = { x = player.x + (player.img:getWidth()/2), y = player.y,  img = bulletImg}
        table.insert(bullets, newBullet)
        canShoot = false
        canShootTimer = canShootTimerMax
    end
end


function love.load(arg)
    player.img = love.graphics.newImage('hero.png')
    bulletImg = love.graphics.newImage('power-sheet.png')
    enemyImg = love.graphics.newImage('policia.png')
    background = love.graphics.newImage('back.png')
end

function love.update(dt)
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end
    movimentacao(dt)
    bullets_fun(dt)
    shooting()

    for i, bullet in ipairs(bullets) do
        bullet.y = bullet.y - (250*dt)
        if bullet.y <0 then
            table.remove(bullets, i)
        end
    end

    -- Time enemy creation
    createEnemyTimer = createEnemyTimer - ( 1 * dt )
    if createEnemyTimer < 0 then
        createEnemyTimer = createEnemyTimerMax
        -- create eneny
        randomNumber = math.random(10, love.graphics.getWidth() - 10)
        newEnemy = { x = randomNumber, y = -10, img=enemyImg }
        table.insert(enemies, newEnemy)
    end

    for i, enemy in ipairs(enemies) do
        enemy.y = enemy.y + (200 * dt)

        if enemy.y > 600 then
            table.remove(enemies, i)
        end
    end

    -- colisão e regra de pontos
    for i, enemy in ipairs(enemies) do
        for j, bullet in ipairs(bullets) do
            if CheckCollision( enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
                table.remove(bullets, j)
                table.remove(enemies, i)
                score = score + 1
            end
        end

        if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight()) and isAlive then
            table.remove(enemies, i)
            isAlive = false
        end
    end
    if not isAlive and love.keyboard.isDown('r') then
        -- remove all our bullets and enemies from screen
        bullets = {}
        enemies = {}

        -- reset timers
        canShootTimer = canShootTimerMax
        createEnemyTimer = createEnemyTimerMax

        -- move player back to default position
        player.x = 100
        player.y = 500

        -- reset our game state
        score = 0
        isAlive = true
    end
end

function love.draw(dt)
    --background
    for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        end
    end
    --end
    --
    if isAlive then
        love.graphics.draw(player.img, player.x, player.y)
    else
        love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
    end
    for i, bullet in ipairs(bullets) do
        love.graphics.draw(bullet.img, bullet.x, bullet.y)
    end
    for i, enemy in ipairs(enemies) do
        love.graphics.draw(enemy.img, enemy.x, enemy.y)
    end
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2 + w2 and
    x2 < x1 + w1 and
    y1 < y2 + h2 and
    y2 < y1 + h1
end
