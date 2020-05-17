Resources = {Textures = {Weapons = {}, Projectiles = {}}}

function Resources.load()
    -- textures and images
    love.graphics.setDefaultFilter('nearest', 'nearest')
    Resources.Textures.Player = love.graphics.newImage('assets/img/YV.png')
    Resources.Textures.Cursor = love.graphics.newImage(
                                    'assets/img/crosshair_n.png')
    Resources.Textures.Weapons.Revolver =
        love.graphics.newImage('assets/img/weapon/revolver.png')
    Resources.Textures.Projectiles.Bullet =
        love.graphics.newImage('assets/img/weapon/bullet.png')
end

return Resources
