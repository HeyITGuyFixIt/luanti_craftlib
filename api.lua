craftlib.register_craft = function (def) {
    -- Expects def to be {
    --      type = "craft"|"mix"|"knap"|"toolrepair"
    --      base = list<node|group>,
    --      input? = list<node|item|tool|group>,
    --      tool? = tool,
    --      pattern? = list<list<0|1>>
    --      output? = list<node|item|tool|group>
    -- }
    -- node, item, tool, and group are strings, optionally followed by a quantity
    if def.base ~= nil and #def.base ~= 0 {
        for _, base in ipairs(def.base) do
            if string.match(base, "^group:") then -- base is a group
            else -- base is a node
            end
            local base_def = core.registered_nodes[base]
            if base_def then
                if craftlib.crafts[base] == nil then
                    craftlib.crafts[base] = {}
                end
                craftlib.crafts[base][#craftlib.crafts[base]] = def
            else
                core.log("warn", "[craftlib] base material ("..base..") is not a registered node.")
            end
        end
    } else {
        core.log("warn", "[craftlib] Registered craft is missing a base material: "..dump(def))
    }

}