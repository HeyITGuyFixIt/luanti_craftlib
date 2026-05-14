knapping_mtg = {}
local tools = {
    pick = {
        title = 'Pickaxe',
        groups = { pickaxe = 1 },
    },
    axe = {
        title = 'Axe',
        groups = { axe = 1 },
    },
    shovel = {
        title = 'Shovel',
        groups = { shovel = 1 },
    },
    sword = {
        title = 'Sword',
        groups = { sword = 1 },
    },
}

local materials = {
    flint = {
        texture = 'flint_obj.png',
        title = 'Flint',
        replacement = {
            pick = 'default:pick_stone',
            sword = 'default:sword_stone',
            axe = 'default:axe_stone',
            shovel = 'default:shovel_stone'
        }
    },
    obsidian = {
        texture = 'default_obsidian.png',
        title = 'Obsidian',
        tool_capabilities = {
            pick = {
                full_punch_interval = 1.1,
                max_drop_level = 3,
                groupcaps = {
                    cracky = { times = { [1] = 2.2, [2] = 1.1, [3] = 0.55 }, uses = 30, maxlevel = 3 },
                },
                damage_groups = { fleshy = 6 },
            },
            sword = {
                full_punch_interval = 0.9,
                max_drop_level = 1,
                groupcaps = {
                    snappy = { times = { [1] = 1.95, [2] = 0.95, [3] = 0.32 }, uses = 40, maxlevel = 3 },
                },
                damage_groups = { fleshy = 9 },
            },
            axe = {
                full_punch_interval = 1.1,
                max_drop_level = 1,
                groupcaps = {
                    choppy = { times = { [1] = 2.15, [2] = 0.95, [3] = 0.55 }, uses = 30, maxlevel = 3 },
                },
                damage_groups = { fleshy = 8 },
            },
            shovel = {
                full_punch_interval = 1.2,
                max_drop_level = 1,
                groupcaps = {
                    crumbly = { times = { [1] = 1.15, [2] = 0.55, [3] = 0.30 }, uses = 30, maxlevel = 3 },
                },
                damage_groups = { fleshy = 5 },
            }
        }
    },
}

if core.global_exists('stoneage') then
    materials.flint = nil
end

for name, def in pairs(tools) do
    for material, props in pairs(materials) do
        local item_name = "knapping_mtg:" .. material .. "_" .. name .. "_head"
        core.register_craftitem(item_name, {
            description = "Knapped " .. props.title .. ' ' .. def.title .. " Head",
            inventory_image = material .. "_" .. name .. "_head.png",
        })

        knapping.register_recipe({
            input = "default:" .. material,
            output = item_name,
            recipe = knapping.default_recipes[name],
            texture = props.texture
        })

        local tool_name = ''

        if props.replacement and props.replacement[name] then
            tool_name = props.replacement[name]

            core.clear_craft({
                output = props.replacement[name]
            })

            core.override_item(tool_name, {
                inventory_image = material .. "_" .. name .. ".png",
                description = props.title .. " " .. def.title,
                wield_image = name == 'shovel' and (material .. "_" .. name .. ".png^[transformR90") or (material .. "_" .. name .. ".png"),
            })
        else
            tool_name = 'knapping_mtg:' .. name .. '_' .. material

            core.register_tool(tool_name, {
                description = "Knapped " .. props.title .. ' ' .. def.title,
                inventory_image = texture or material .. "_" .. name .. ".png",
                wield_image = texture or (name == 'shovel' and (material .. "_" .. name .. ".png^[transformR90") or (material .. "_" .. name .. ".png")),
                tool_capabilities = props.tool_capabilities[name],
                sound = { breaks = "default_tool_breaks" },
                groups = def.groups,
            })
        end

        core.register_craft({
            output = tool_name,
            type = 'shaped',
            recipe = {
                { item_name },
                { 'group:stick' }
            }
        })
    end
end
