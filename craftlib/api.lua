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
        for _, base in ipairs(def.base) do
            if string.match(base, "^group:") then -- base is a group
                local group = string.match(base, "^group:([^ ]+)")
                for node, node_def in pairs(core.registered_nodes) do
                    if node_def.groups[group] ~= nil then
                        if craftlib.registered_crafts[node] == nil then
                            craftlib.registered_crafts[node] = {}
                        end
                        craftlib.registered_crafts[node][#craftlib.registered_crafts[node]] = def
                    end
                end
            else -- base is a node
                if core.registered_nodes[base] ~= nil then
                    if craftlib.registered_crafts[base] == nil then
                        craftlib.registered_crafts[base] = {}
                    end
                    craftlib.registered_crafts[base][#craftlib.registered_crafts[base]] = def
                else
                    core.log("warn", "[craftlib] base material ("..base..") is not a registered node.")
                end
            end
        end
    else
        core.log("warn", "[craftlib] Registered craft is missing a base material: "..dump(def))
    end
end

craftlib.is_crafting_activated = function(pos, node, digger)
    --
end
