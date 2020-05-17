require('gameConstants')
function love.conf(t)
    t.window.width = GameConstants.SCREEN_WIDTH
    t.window.height = GameConstants.SCREEN_HEIGHT
    t.window.title = 'Topdown sandbox'
    t.console =  true
end