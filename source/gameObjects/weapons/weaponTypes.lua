local Weapon = require('gameObjects/weapons/weapon')
local Resources = require('resources')
local ProjectileType = require('gameObjects/weapons/projectileTypes')

local WeaponType = {
    Revolver = {
        sprite = Resources.Textures.Weapons.Revolver,
        projectile = ProjectileType.Bullet
    }
}

return WeaponType
