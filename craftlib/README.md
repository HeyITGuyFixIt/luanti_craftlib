# craftlib

Immersive crafting library mod for Luanti.

## API

### Basic Crafts

```lua
craftlib.register_craft({
    type = "craft",
    base = {"group:soil"},
    input = {"group:tree"},
    tool = {"group:axe"},
    output = {"group:slab 2"}
})
```

Example usage of the API to register a craft to split a tree node with an axe, outputting two wood slabs. In this example, a user would place a tree node on the dirt while sneaking, then they would dig it with an axe to result in the output of two wood slabs.

You can set the `base` to a list of any node or group that can be crafted on. For example, this can be a soil or stone group to craft on the ground, or can be set to a craft table or anvil for a work surface.

You can set the `input` to a list of any item, node, or group that the player can craft with. This follows the same logic as a shapeless recipe. The player must sneak and place in the same spot to trigger this.

You can set the `tool` to any item, tool, or group to specify what tool the player crafts with. The player can dig with this tool to trigger this action. If the tool is an item, it is consumed. If it is a tool, it receives damage based on its `tool_capabilities`. To register a "hand craft", you can set the tool to an empty string (`tool = {""}`); this applies to the other types of crafts below.

You can set the `output` to a list of items that are created from this craft. Instead of replacements, like in craft recipes, specify the output of a replacement here. So if the `input` includes a bucket of water, add an empty bucket to the `output`, alongside the regular output of the craft.

Using a group in the output allows for a more dynamic craft. The library matches the input items to potential output items with the output group. If there is a match, it uses it. So if the input is "group:tree" and the output is "group:slab", and the player inputs "default:pine_tree", it will match it to "stairs:slab_pine_wood", based off a registered association between tree and wood.

Due to the dependency on the mod `group_any`, you can use the following groups to target items at a high level:

* `group:any`: all registered items (except for entities)
* `group:node`: all nodes from `core.registered_nodes`.
* `group:craftitem`: all craft items from `core.registered_craftitems`.
* `group:tool`: all tools from `core.registered_tools`.

An example of using these groups would be to use `group:node` as a base to target all nodes as a base for the craft, or `group:tool` as a tool to target all tools as a usable tool for the craft.

### Mixing Crafts

```lua
craftlib.register_craft({
    type = "mix",
    base = {"cooking:mortar"},
    input = {"farming:wheat 4"},
    tool = {"group:stick"},
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
    tool = {"anvil:hammer"}
})
```

### Other Functions

* `craftlib.is_crafting_active(pos)`: Checks if the node at `pos` has a metadata key specifying if it is setup to craft or not. Returns true or false.
* `craftlib.toggle_crafting(pos, node, clicker, itemstack, pointed_thing)`: Used in `on_rightclick` in a node definition to prepare a base for crafting or to cancel a craft. It sets up the node with an inventory to store input items and takes one item from the player's itemstack. If toggled off, it removes the inventory and drops the items. It is only ran if the node is a base in any registered craft.
* `craftlib.attempt_craft(pos, node, digger)`: Used in `on_dig` in a node definition to attempt a craft with the provided inputs. This is applied to all node definitions and is only ran after a successful check from `craftlib.is_crafting_active`.
* `craftlib.get_output(recipe, provided)`: Returns an itemstring for the output of a recipe using the provided items.
* `craftlib.register_association(input_type, output_type)`: Register types of inputs to types of outputs. For example, "tree" to "wood", so that "default:tree" will be associated with "stairs:slab_wood" and "default:pine_tree" will be associated with "stairs:slab_pine_wood". Expect both parameters to be passed to `string.match()`.
* `craftlib.register_replacement(input, replacement)`: Register replacements. This checks for groups or item names in the input string, but expects item names in the replacement list.
