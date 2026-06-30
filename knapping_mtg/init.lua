knapping_mtg = {
    path = core.get_modpath(core.get_current_modname()),
    tools = {
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
        }
    },
    materials = {
        flint = {
            texture = 'flint_obj.png',
            title = 'Flint',
            replacement = {
                pick = 'default:pick_stone',
                sword = 'default:sword_stone',
                axe = 'default:axe_stone',
                shovel = 'default:shovel_stone'
            },
            tool_capabilities = {
                pick = core.registered_items['default:pick_stone'].tool_capabilities,
                sword = core.registered_items['default:sword_stone'].tool_capabilities,
                axe = core.registered_items['default:axe_stone'].tool_capabilities,
                shovel = core.registered_items['default:shovel_stone'].tool_capabilities,
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
        }
    },
    default_recipes = {
		pick = {
			{ 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 0, 0, 0 },
			{ 0, 1, 1, 1, 1, 1, 1, 0 },
			{ 1, 1, 1, 1, 1, 1, 1, 1 },
			{ 1, 1, 1, 0, 0, 1, 1, 1 },
			{ 1, 0, 0, 0, 0, 0, 0, 1 },
			{ 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0 },
		},
		axe = {
			{ 0, 0, 1, 1, 0, 0, 0, 0 },
			{ 0, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 1, 1, 1, 1, 1, 0, 0 },
			{ 0, 1, 1, 1, 1, 1, 1, 0 },
			{ 0, 1, 1, 1, 1, 1, 1, 0 },
			{ 0, 1, 1, 1, 0, 1, 0, 0 },
			{ 0, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 1, 1, 0, 0, 0, 0 },
		},
		shovel = {
			{ 0, 0, 0, 1, 1, 0, 0, 0 },
			{ 0, 0, 1, 1, 1, 1, 0, 0 },
			{ 0, 1, 1, 1, 1, 1, 1, 0 },
			{ 0, 1, 1, 1, 1, 1, 1, 0 },
			{ 0, 1, 1, 1, 1, 1, 1, 0 },
			{ 0, 1, 1, 1, 1, 1, 1, 0 },
			{ 0, 1, 1, 1, 1, 1, 1, 0 },
			{ 0, 0, 1, 0, 0, 1, 0, 0 },
		},
		sword = {
			{ 0, 0, 0, 0, 0, 0, 1, 1 },
			{ 0, 0, 0, 0, 0, 1, 1, 1 },
			{ 0, 0, 0, 0, 1, 1, 1, 0 },
			{ 0, 0, 0, 1, 1, 1, 0, 0 },
			{ 0, 0, 1, 1, 1, 0, 0, 0 },
			{ 0, 1, 1, 1, 0, 0, 0, 0 },
			{ 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 1, 1, 0, 0, 0, 0, 0, 0 },
		},
	}
}

if core.global_exists('stoneage') then
    knapping_mtg.materials.flint = nil
end

for name, def in pairs(knapping_mtg.tools) do
    for material, props in pairs(knapping_mtg.materials) do
        local item_name = "knapping_mtg:" .. material .. "_" .. name .. "_head"
        core.register_craftitem(item_name, {
            description = "Knapped " .. props.title .. ' ' .. def.title .. " Head",
            inventory_image = material .. "_" .. name .. "_head.png",
        })

        craftlib.register_craft({
            type = "carve",
            base = {"default:" .. material},
            tool = {"default:" .. material},
            output = {item_name},
            pattern = knapping_mtg.default_recipes[name],
            texture = props.texture
        })

        local tool_name = ''
        local tool_def = {
            description = "Knapped " .. props.title .. ' ' .. def.title,
            inventory_image = texture or material .. "_" .. name .. ".png",
            wield_image = texture or (name == 'shovel' and (material .. "_" .. name .. ".png^[transformR90") or (material .. "_" .. name .. ".png")),
            tool_capabilities = props.tool_capabilities[name],
            sound = { breaks = "default_tool_breaks" },
            groups = def.groups,
        }

        if props.replacement and props.replacement[name] then
            tool_name = props.replacement[name]
            core.clear_craft({
                output = props.replacement[name]
            })
            core.override_item(tool_name, tool_def)
        else
            tool_name = 'knapping_mtg:' .. name .. '_' .. material
            core.register_tool(tool_name, tool_def)
        end

        craftlib.register_craft({
            type = 'craft',
            base = {'group:stone', 'group:soil'},
            input = { item_name },
            tool = 'group:stick',
            output = tool_name
        })
    end
end
