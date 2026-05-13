craftlib.register_craft = function (def) {
    -- Expects def to be {
    --      container | surface = list<node|group>,
    --      input = list<node|item|tool|group>,
    --      tool = tool,
    --      output = list<node|item|tool|group>
    -- }
    -- node, item, tool, and group are strings, optionally followed by a quantity
    if def.surface ~= nil {
        local surface_def = core.registered_nodes[def.surface]
        core.override_item(def.surface, {
            on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
                if clicker then
                else
                    return surface_def.on_rightclick(pos, node, clicker, itemstack, pointed_thing)
                end
            end
        })
    }

}