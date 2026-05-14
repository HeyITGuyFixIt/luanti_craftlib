# craftlib

Immersive crafting library mod for Luanti.

## API

### Basic Crafts

```lua
craftlib.register_craft({
    type = "craft",
    base = {"group:soil"},
    input = {"group:tree"},
    tool = "group:axe",
    output = {"group:slab 2"}
})
```

Example usage of the API to register a craft to split a tree node with an axe, outputting two wood slabs. In this example, a user would place a tree node on the dirt while sneaking, then they would dig it with an axe to result in the output of two wood slabs.

You can set the `base` to a list of any node or group that can be crafted on. For example, this can be a soil or stone group to craft on the ground, or can be set to a craft table or anvil for a work surface.

You can set the `input` to a list of any item, node, or group that the player can craft with. This follows the same logic as a shapeless recipe. The player must sneak and place in the same spot to trigger this.

You can set the `tool` to any item, tool, or group to specify what tool the player crafts with. The player can dig with this tool to trigger this action. If the tool is an item, it is consumed. If it is a tool, it receives damage based on its `tool_capabilities`.

You can set the `output` to a list of items that are created from this craft. Instead of replacements, like in craft recipes, specify the output of a replacement here. So if the `input` includes a bucket of water, add an empty bucket to the `output`, alongside the regular output of the craft.

### Mixing Crafts

```lua
craftlib.register_craft({
    type = "mix",
    base = {"cooking:mortar"},
    input = {"farming:wheat 4"},
    tool = "group:stick",
    output = {"farming:flour"}
})
```

Here is another type of craft that uses a container instead of a surface base. In this example, set the `base` to a list of any node or group that can contain items. An entity is created to fit inside of it and display the input. The rest of the parameters work the same as with basic crafts.

### Knapping Crafts

```lua
craftlib.register_craft({
    type = "knap",
    base = {"group:stone"},
    pattern = {
        {1, 1, 0, 0, 0, 0, 0, 0},
        {1, 1, 1, 1, 1, 0, 0, 0},
        {0, 1, 1, 1, 1, 1, 0, 0},
        {0, 0, 1, 1, 1, 1, 1, 0},
        {0, 0, 0, 0, 1, 1, 1, 0},
        {0, 0, 0, 0, 1, 1, 1, 0},
        {0, 0, 0, 0, 0, 1, 1, 1},
        {0, 0, 0, 0, 0, 0, 1, 1}
    },
    output = {"knapping:pick_head_stone"},
    texture = "default_stone.png"
})
```

This is a unique type of craft called knapping. The idea is you strike two materials together in an orderly way, and you can make toolheads from that. Due to the uniqueness of this method, it has a slightly different set of parameters.

* `pattern`: This is a list of lists, each containing a series of 1s and 0s. This creates an 8x8 grid that the player has to tap to remove chunks from the input material.

* `texture`: This is the texture displayed on the entity while knapping. If not specified, it uses the texture of the base item.

### Chisel Craft

```lua
craftlib.register_craft({
    type = "chisel",
    base = {"group:slab"},
    pattern = {
        {1, 1, 1, 1, 1, 1, 1, 1},
        {1, 0, 0, 0, 0, 0, 0, 1},
        {1, 1, 0, 0, 0, 0, 0, 1},
        {1, 1, 1, 0, 0, 1, 1, 1},
        {1, 1, 1, 0, 0, 1, 1, 1},
        {1, 1, 0, 0, 0, 0, 1, 1},
        {1, 0, 0, 0, 0, 0, 0, 1},
        {1, 1, 1, 1, 1, 1, 1, 1}
    },
    output = { "metalworking:pattern_anvil" }
})
```

### Tool Repair

```lua
craftlib.register_craft({
    type = "toolrepair",
    base = {"anvil:anvil"},
    input = {"group:repairable_tool"},
    tool = "anvil:hammer"
})
```
