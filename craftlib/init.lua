craftlib = {
    path = core.get_modpath(core.get_current_modname()),
    meta_keys = {
        active = "craftlib:crafting_activated",
        inv = "craftlib:inventory"
    },
    registered_crafts = {},
    bases = {},
    inputs = {},
    outputs = {},
    tools = {},
}

dofile(craftlib.path .. "/api.lua")

local organize_recipes = function(key)

end

core.register_on_mods_loaded(function()
    core.log("action", "[craftlib] Registered crafts: " .. dump(craftlib.registered_crafts))
    local clear_crafts = false
    if core.settings:get_bool("craftlib_clear_old_crafts") then
        clear_crafts = true
    end
    local groups = {
        base = {},
        input = {},
        tool = {},
        output = {}
    }
    local keys = { "base", "input", "tool", "output" }
    for i, recipe in ipairs(craftlib.registered_crafts) do
        core.log("action", "[craftlib] Recipe: " .. dump(recipe))
        for _, key in ipairs(keys) do
            if recipe[key] and #recipe[key] > 0 then
                for _, str in pairs(recipe[key]) do
                    if string.match(str, "^group:") then
                        -- need to accomidate for multiple groups in a single string
                        local group = string.match(str, "^group:([^ ]+)")
                        local in_groups_yet = false
                        for igroup, _ in pairs(groups[key]) do
                            if group == igroup then
                                in_groups_yet = true
                                table.insert(groups[key][group], i)
                                break
                            end
                        end
                        if in_groups_yet == false then
                            core.log("action", "[craftlib] Adding " .. group .. " to groups." .. key)
                            groups[key][group] = { i }
                        end
                    else
                        ---@type ("bases"|"inputs"|"tools"|"outputs")
                        local pkey = key .. 's'
                        if craftlib[pkey][str] == nil then
                            craftlib[pkey][str] = {}
                        end
                        ---@diagnostic disable-next-line: param-type-mismatch
                        table.insert(craftlib[pkey][str], i)
                    end
                end
            end
        end
    end
    core.log("action", "[craftlib] Groups: " .. dump(groups))
    local registrars = {
        "registered_nodes",
        "registered_craftitems",
        "registered_tools"
    }
    for _, registrar in ipairs(registrars) do
        for name, def in pairs(core[registrar]) do
            if clear_crafts then
                core.clear_craft({
                    output = name
                })
            end
            for _, key in ipairs(keys) do
                if craftlib[key .. 's'] == nil then
                    craftlib[key .. 's'] = {}
                end
                for igroup, i in pairs(groups[key]) do
                    for group, _ in pairs(def.groups) do
                        if group == igroup then
                            if craftlib[key .. 's'][name] == nil then
                                craftlib[key .. 's'][name] = {}
                            end
                            table.insert(craftlib[key .. 's'][name], i)
                        end
                    end
                end
            end
            if registrar == "registered_nodes" then
                if craftlib.bases[name] then
                    local old_on_rightclick = def.on_rightclick
                    local old_on_dig = def.on_dig
                    core.override_item(name, {
                        -- on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
                        --     -- local item = string.match(itemstack:get_name(), "^([^ ]+)")
                        --     -- core.chat_send_player("singleplayer", "Rightclicked " .. core.get_node(pos).name)
                        --     -- core.chat_send_player("singleplayer", dump(craftlib.bases[core.get_node(pos).name]))
                        --     if craftlib.bases[core.get_node(pos).name] ~= nil then
                        --         -- core.chat_send_player("singleplayer", "Found node in list of bases")
                        --         local controls = clicker:get_player_control()
                        --         -- core.log("action", "Player control table: "..dump(controls))
                        --         if controls.aux1 then
                        --             core.chat_send_player("singleplayer", "Toggling crafting on node")
                        --             -- if crafting is inactive, activate and create inventory
                        --             -- if crafting is active, deactivate and drop inventory
                        --             craftlib.toggle_crafting(pos, node, clicker, itemstack, pointed_thing)
                        --             return itemstack
                        --         elseif craftlib.is_crafting_active(pos) then -- take player itemstack and add to inventory
                        --             core.chat_send_player("singleplayer", "Crafting is active on node")
                        --             -- if empty hand, remove last item from inventory
                        --             if itemstack:is_empty() == false then
                        --                 local meta = core.get_meta(pos)
                        --                 local inv = meta:get_inventory()
                        --                 local taken = itemstack:take_item(1)
                                    
                        --                 inv:add_item(craftlib.meta_keys.inv, taken)
                        --                 return itemstack
                        --             end
                        --         else
                        --             core.chat_send_player("singleplayer", "Either player is not pressing aux1 or crafting isn't active")
                        --         end
                        --     end
                        --     if old_on_rightclick then
                        --         core.chat_send_player("singleplayer", "Running old on_rightclick")
                        --         return old_on_rightclick(pos, node, clicker, itemstack, pointed_thing)
                        --     else
                        --         core.chat_send_player("singleplayer", "Default on_rightclick behavior")
                        --         local new_stack, _ = core.item_place_node(itemstack, clicker, pointed_thing)
                        --         return new_stack
                        --     end
                        -- end,
                        on_dig = function(pos, node, digger)
                            if craftlib.is_crafting_active(pos) then
                                craftlib.attempt_craft(pos, node, digger)
                                return false
                            end
                            if old_on_dig then
                                return old_on_dig(pos, node, digger)
                            end
                        end
                    })
                else
                    -- for group, _ in pairs(def.groups) do
                        --
                    -- end
                end
            end
        end
    end
    core.log("action", "[craftlib] Bases: " .. dump(craftlib.bases))
    core.log("action", "[craftlib] Inputs: " .. dump(craftlib.inputs))
    core.log("action", "[craftlib] Outputs: " .. dump(craftlib.outputs))
    core.log("action", "[craftlib] Tools: " .. dump(craftlib.tools))
end)

core.register_on_joinplayer(function(player)
    local inv = player:get_inventory()
    inv:set_size("craft", 4)
    inv:set_width("craft", 2)
end)
controls.register_on_press(function(player, key)
  local ctrl = player:get_player_control()
  if not (key == "place" and ctrl.sneak) then
    return
  end
    if craftlib.bases[core.get_node(under).name] ~= nil then
        -- core.chat_send_player("singleplayer", "Found node in list of bases")
        local controls = placer:get_player_control()
        -- core.log("action", "Player control table: "..dump(controls))
        if controls.sneak then
            core.remove_node(pos)
            core.chat_send_player("singleplayer", "Toggling crafting on node")
            -- if crafting is inactive, activate and create inventory
            -- if crafting is active, deactivate and drop inventory
            craftlib.toggle_crafting(under, newnode, placer, itemstack, pointed_thing)
            return true
        elseif craftlib.is_crafting_active(under) then -- take player itemstack and add to inventory
            core.chat_send_player("singleplayer", "Crafting is active on node")
            -- if empty hand, remove last item from inventory
            if itemstack:is_empty() == false then
                core.remove_node(pos)
                local meta = core.get_meta(under)
                local inv = meta:get_inventory()
                local taken = itemstack:take_item(1)
            
                inv:add_item(craftlib.meta_keys.inv, taken)
                return true
            end
        else
            core.chat_send_player("singleplayer", "Either player is not pressing sneak or crafting isn't active")
        end
    end
end)

if core.global_exists("sfinv") then
    local S = minetest.get_translator("sfinv")
    sfinv.override_page("sfinv:crafting", {
        title = S("Crafting"),
        get = function(self, player, context)
            return sfinv.make_formspec(player, context, [[
				list[current_player;craft;2,1;2,2;]
				list[current_player;craftpreview;5,1.5;1,1;]
				image[4,1.5;1,1;sfinv_crafting_arrow.png]
				listring[current_player;main]
				listring[current_player;craft]
			]], true)
        end
    })
end
