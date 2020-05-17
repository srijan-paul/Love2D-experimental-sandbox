local Weapon = require('gameObjects/weapons/weapon')
local Resources = require('resources')
local ProjectileType = require('gameObjects/weapons/projectileTypes')

local WeaponType = {
    Revolver = {
        sprite = Resources.Textures.Weapons.Revolver,
        projectile = ProjectileType.Bullet,
        scaleX = 4,
        scaleY = 4,
        muzzleX = 3
    }
}

return WeaponType
