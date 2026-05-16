craftlib.register_craft = function (def)
    -- Expects def to be {
    --      type = "craft"|"mix"|"knap"|"toolrepair"
    --      base = list<node|group>,
    --      input? = list<node|item|tool|group>,
    --      tool? = tool,
    --      pattern? = list<list<0|1>>
    --      output? = list<node|item|tool|group>
    -- }
    -- node, item, tool, and group are strings, optionally followed by a quantity
    if def.base ~= nil and #def.base ~= 0 then
        table.insert(craftlib.registered_crafts, def)
        -- for _, base in ipairs(def.base) do
        --     if string.match(base, "^group:") then -- base is a group
        --         local group = string.match(base, "^group:([^ ]+)")
        --         for node, node_def in pairs(core.registered_nodes) do
        --             if node_def.groups[group] ~= nil then
        --                 if craftlib.registered_crafts[node] == nil then
        --                     craftlib.registered_crafts[node] = {}
        --                 end
        --                 table.insert(craftlib.registered_crafts[node], def)
        --             end
        --         end
        --     else -- base is a node
        --         if core.registered_nodes[base] ~= nil then
        --             if craftlib.registered_crafts[base] == nil then
        --                 craftlib.registered_crafts[base] = {}
        --             end
        --             table.insert(craftlib.registered_crafts[base], def)
        --         else
        --             core.log("warn", "[craftlib] base material ("..base..") is not a registered node.")
        --         end
        --     end
        -- end
    else
        core.log("warn", "[craftlib] Failed to register craft. Missing a base material: "..dump(def))
    end
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
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        if craftlib.is_crafting_active(pos) then
            meta:set_int(craftlib.meta_keys.active, 0)
            if inv:is_empty(craftlib.meta_keys.inv) == false then
                -- Drop items from inv list
                local list = inv:get_list(craftlib.meta_keys.inv)
                if list ~= nil then
                    for _, item in ipairs(list) do
                        core.add_item({x = pos.x + (((math.random(1, 70)/100)-0.35)), y = pos.y+1, z = pos.z + (((math.random(1, 70)/100)-0.35))}, item)
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
            if itemstack:is_empty() == false then
                local taken = itemstack:take_item(1)
                inv:add_item(craftlib.meta_keys.inv, taken)
            end
        end
    end
end

local isEqualTable = function(t1, t2)
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
    -- ...
    craftlib.toggle_crafting(pos, node, digger)
end

craftlib.register_association = function(input_type, output_type)

end
