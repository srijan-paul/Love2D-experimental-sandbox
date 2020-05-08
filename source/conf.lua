local GameConstants = require('gameconstants')

function love.conf(t)
    t.window.width = GameConstants.SCREEN_WIDTH
    t.window.height = GameConstants.SCREEN_HEIGHT
    t.console =  true
end