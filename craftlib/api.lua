-- Expects def to be {
--      type = "craft"|"mix"|"knap"|"toolrepair"
--      base = list<node|group>,
--      input? = list<node|item|tool|group>,
--      tool? = tool,
--      pattern? = list<list<0|1>>
--      output? = list<node|item|tool|group>
--      base_replacement = list<node|group>
-- }
craftlib.register_craft = function(def)
    -- node, item, tool, and group are strings, optionally followed by a quantity
    if def.base ~= nil and #def.base ~= 0 then
        table.insert(craftlib.registered_crafts, def)
    else
        core.log("warn", "[craftlib] Failed to register craft. Missing a base material: " .. dump(def))
    end
end


craftlib.register_association = function(input_type, output_type)
    if craftlib.registered_associations[input_type] == nil then
        craftlib.registered_associations[input_type] = {}
    end
    table.insert(craftlib.registered_associations[input_type], output_type)
end

craftlib.register_replacement = function(input, replacement)
    if craftlib.registered_associations[input] == nil then
        craftlib.registered_associations[input] = {}
    end
    table.insert(craftlib.registered_associations[input], replacement)
end

craftlib.register_consumable = function(itemname, uses)
end

craftlib.is_crafting_active = function(pos)
    local base = core.get_node(pos).name
    if craftlib.bases[base] then
        local meta = core.get_meta(pos)
        if meta:get_int(craftlib.meta_keys.active) == 1 then
            return true
        end
    end
    return false
end

craftlib.toggle_crafting = function(pos, node, clicker, itemstack, pointed_thing)
    local base = core.get_node(pos).name
    if craftlib.bases[base] then
        -- local upos = { x = pos.x, y = pos.y - 1, z = pos.z }
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        if craftlib.is_crafting_active(pos) then
            meta:set_int(craftlib.meta_keys.active, 0)
            if inv:is_empty(craftlib.meta_keys.inv) == false then
                -- Drop items from inv list
                local list = inv:get_list(craftlib.meta_keys.inv)
                if list ~= nil then
                    for _, item in ipairs(list) do
                        core.add_item(
                        { x = pos.x + (((math.random(1, 70) / 100) - 0.35)), y = pos.y, z = pos.z +
                        (((math.random(1, 70) / 100) - 0.35)) }, item)
                    end
                end
                inv:set_list(craftlib.meta_keys.inv, {})
            end
            inv:set_size(craftlib.meta_keys.inv, 0)
        else
            meta:set_int(craftlib.meta_keys.active, 1)
            -- might change these values later
            inv:set_size(craftlib.meta_keys.inv, 9)
            inv:set_width(craftlib.meta_keys.inv, 3)
            if itemstack and itemstack:is_empty() == false then
                local taken = itemstack:take_item(1)
                inv:add_item(craftlib.meta_keys.inv, taken)
            end
        end
    end
end

local function isEqualTable(t1, t2)
    for k, v in pairs(t1) do
        if type(v) == "table" then
            if not isEqualTable(v, t2[k]) then
                return false
            end
        else
            if v ~= t2[k] then
                return false
            end
        end
    end
    for k, v in pairs(t2) do
        if type(v) == "table" then
            if not isEqualTable(v, t1[k]) then
                return false
            end
        else
            if v ~= t1[k] then
                return false
            end
        end
    end
    return true
end

craftlib.attempt_craft = function(pos, node, digger)
    local base = core.get_node(pos).name
    local recipes_i = craftlib.bases[base]
    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local list = inv:get_list(craftlib.meta_keys.inv)
    local plain_list = {}
    local recipe_i = nil
    for _, stack in ipairs(list) do
        table.insert(plain_list, stack:to_string())
    end
    for _, i in ipairs(recipes_i) do
        if craftlib.registered_crafts[i] then
            if isEqualTable(craftlib.registered_crafts[i].input, plain_list) then
                recipe_i = i
                break
            end
        end
    end
    if recipe_i ~= nil then
        local recipe = craftlib.registered_crafts[recipe_i]
        local wielded = digger:get_wielded_item()
        local toolname = wielded:get_name()
        local is_right_tool = false
        -- for _, tool in ipairs(recipe.tool) do
        if craftlib.tools[toolname] then
            for _, i in ipairs(craftlib.tools[toolname]) do
                if i == recipe_i then
                    is_right_tool = true
                    break
                end
            end
        end
        if is_right_tool then
            local output = craftlib.get_output(recipe, list, digger)
            for _, stack in ipairs(list) do
                inv:remove_item(craftlib.meta_keys.inv, stack)
            end
            for _, item in output do
                inv:add_item(craftlib.meta_keys.inv, ItemStack(item))
            end
        end
        if recipe.type == "toolrepair" then
            return
        else
            -- ...
            craftlib.toggle_crafting(pos, node, digger)
        end
    else
        craftlib.toggle_crafting(pos, node, digger)
    end
end

craftlib.get_output = function(recipe, provided, player)
    local output = {}
    local tool = player:get_wielded_item()
    if recipe.type == "toolrepair" then
        for _, item in pairs(provided) do
            local groups = core.registered_items[item:get_name()]
            if groups.disable_repair ~= 1 and groups.not_repaired_by_anvil ~= 1 then
                local tool_cap = wielded:get_tool_capabilities()
                item:add_wear(-5000)
                tool:add_wear(100)
                player:set_wielded_item(tool)
            end
            table.insert(output, item)
        end
    else
        -- assume type is "craft" if not anything else
        for _, item in pairs(provided) do
            local name = item:get_name()
            local count = item:get_count()
            local def = core.registered_items[name]
        end
    end
    return output
end

craftlib.get_pointed_thing = function(player)
    local tool = player:get_wielded_item()
    --Get the position of the player's eyes, to determine pointed_thing
    local pos = player:get_pos()
    pos.y = pos.y + player:get_properties().eye_height
    --Get the tool's definition, to check its digparams and range
    local def = tool:get_definition()
    --Create a ray between the player's eyes and where they're looking, limited by their tool's range
    local ray = Raycast(pos,
        vector.add(pos, vector.multiply(player:get_look_dir(), def.range or core.registered_items[""].range or 4)))

    --Store a pointed_thing based on the first walkable node found
    local pointed_thing = nil
    for pt in ray do
        if pt.type == "node" then
            pointed_thing = pt
            break
        end
    end
    return pointed_thing
end
