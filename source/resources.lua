local Resources = {Texture = {}}

function Resources.load()
    -- textures and images
    love.graphics.setDefaultFilter('nearest', 'nearest')
    Resources.Texture.Player = love.graphics.newImage('assets/img/suit_guy.png')
    Resources.Texture.Cursor = love.graphics.newImage('assets/img/crosshair_n.png')
end

return Resources
