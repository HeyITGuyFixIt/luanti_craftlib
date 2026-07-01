# craftlib

Immersive crafting library mod for Luanti.

To start crafting, hold the sneak key (e.g. shift) and use the dig control (e.g. left-click) on a node. If the node is a base in a registered recipe, this creates an inventory in the node, and items can be added to it by placing the items on the node. If you do this while holding a node, the held node is placed and an inventory is created in it instead of in the pointed node.

To attempt a craft, dig the node. At this point, the craftlib mod evaluates if the tool used is in any of the base node's registered recipes, then checks if the inventory matches any of those recipes. If it matches, it performs the craft, otherwise, nothing changes.

## API

### Common Parameters

These are the parameters that recipes can have. Not all are required. The ones marked with an asterisk are required for all recipes. The [carve recipe type](#carve) and [heat recipe type](#heat) have additional parameters not described here.

* `type`*: Can be set to craft, mix, carve, heat, or restore. See the [below](#recipe-types) sections for explanations of each recipe type.
* `base`*: Can be set to a list of any node or group that can be crafted on. For example, this can be a soil or stone group to craft on the ground, or can be set to a craft table or anvil for a work surface.
* `input`*: Can be set to a list of any item, node, or group that the player can craft with.
* `tool`*: Can be set to any item, tool, or group to specify what tool the player crafts with. The player can dig with this tool to trigger this action. If the tool is an item, it is consumed. If it is a tool, it receives damage based on its `tool_capabilities`. To register a "hand recipe", you can set the tool to an empty string (`tool = {""}`).
* `output`: Can be set to a list of items that are created from this recipe. Instead of replacements, like in craft recipes, specify the output of a replacement here. So if the `input` includes a bucket of water, add an empty bucket to the `output`, alongside the regular output of the craft. This is required for all crafts except for restore.
* `base_replacement`: Can be set to a list of nodes or groups that the base node is replaced with after crafting. For example, if a mix recipe is registered with a base of `bucket:bucket_water`, it can be replaced with `bucket:bucket_empty` (if those craftitems were redefined as nodes).

### Group Usage

Using a group in the any of the parameters allows for a more dynamic craft. The library matches the input items to potential output items with the output group. If there is a match, it uses it. So if the input is "group:tree" and the output is "group:slab", and the player inputs "default:pine_tree", it will match it to "stairs:slab_pine_wood", based off a registered association between the strings "tree" and "wood" (see [Other Functions](#other-functions) below).

Due to the dependency on the mod `group_any`, you can use the following groups to target items at a high level:

* `group:any`: all registered items (except for entities)
* `group:node`: all nodes from `core.registered_nodes`.
* `group:craftitem`: all craft items from `core.registered_craftitems`.
* `group:tool`: all tools from `core.registered_tools`.

An example of using these groups would be to use `group:node` as a base to target all nodes as a base for the craft, or `group:tool` as a tool to target all tools as a usable tool for the craft.

### Recipe Types

#### craft

```lua
craftlib.register_craft({
    type = "craft",
    base = { "group:soil" },
    input = { "group:tree" },
    tool = { "group:axe" },
    output = { "group:slab 2" },
    base_replacement = { "footprints:trail" }
})
```

Example usage of the API to register a craft to split a tree node with an axe, outputting two wood slabs. In this example, a user would place a tree node on the dirt while sneaking, then they would dig it with an axe to result in the output of two wood slabs.

#### mix

```lua
craftlib.register_craft({
    type = "mix",
    base = { "cooking:mortar" },
    input = { "farming:wheat 4" },
    tool = { "group:stick" },
    output = { "farming:flour" }
})
```

Here is another type of craft that uses a container instead of a surface base. In this example, set the `base` to a list of any node or group that can contain items. An entity is created to fit inside of it and display the input. The rest of the parameters work the same as with basic crafts.

#### heat

```lua
craftlib.register_craft({
    type = "mix",
    time = 15
    base = { "default:furance" },
    input = { "cooking:dough" },
    output = { "farming:bread" },
    tool = { "cooking:bread_pan" }
    tool_in_furnace = true
})
```

The heat type is used for cooking or melting recipes. It has an additional parameter called `time` that is equivalent to `cooktime` in `core.register_recipe()`. The base is the type of material that can consume inputs and produce outputs after the specified amount of time. The tool can be an empty string to specify the player's hand, or you can set it to a node name that can be picked up and attached to the player (via the i_have_hands mod). Anything the attached entity has in its inventory will be placed inside the base's inventory. If `tool_in_furnace` is set to true, the carried item will be placed in the base's inventory as well.

For example, a `cooking:pan` can be picked up by the player, containing `cooking:cookie_dough 8` in its inventory. The player sneaks and right-clicks `cooking:pan` and picks it up, then they walk it over to an oven (e.g. `default:furnance`), and sneaks and left-clicks the oven. If `tool_in_furnace` were set to true, both the `cooking:pan` and its inventory items will be added to the oven's inventory. After the time set, the `cooking:cookie_dough 8` will be replaced with `farming:cookie 8`. When the player right-clicks the oven, the `cooking:pan` will be picked up by the player, containing `farming:cookie 8` in the pan's inventory. The player can place the pan by sneaking and right-clicking a node, placing the pan on top of the node. The player can then right-click the pan to pick up the cookies.

#### carve

```lua
craftlib.register_craft({
    type = "carve",
    base = { "group:slab group:wood" },
    tool = { "group:chisel", "group:axe" },
    pattern = {
        {0, 0, 0, 0, 0, 0, 0, 0},
        {0, 1, 1, 1, 1, 1, 1, 0},
        {0, 0, 1, 1, 1, 1, 1, 0},
        {0, 0, 0, 1, 1, 0, 0, 0},
        {0, 0, 0, 1, 1, 0, 0, 0},
        {0, 0, 1, 1, 1, 1, 0, 0},
        {0, 1, 1, 1, 1, 1, 1, 0},
        {0, 0, 0, 0, 0, 0, 0, 0}
    },
    output = { "metalworking:pattern_anvil" },
    texture = "default_wood.png"
})
```

This is type of craft allows you to either use a tool or material to carve out a pattern. The idea is you strike two materials together in an orderly way (knapping), and you can make toolheads from that, or you can use a chisel to carve out a pattern. Due to the uniqueness of this method, it has a slightly different set of parameters.

* `tool`: For knapping, you can use the same value as `base`, otherwise you can specify tools that can be used to carve out the pattern.

* `pattern`: This is a list of lists, each containing a series of 1s and 0s. This creates an 8x8 grid that the player has to tap to remove chunks from the input material. 1s are kept while 0s are removed.

* `texture`: This is the texture displayed on the entity while knapping. If not specified, it uses the texture of the base item.

#### restore

```lua
craftlib.register_craft({
    type = "restore",
    base = { "anvil:anvil" },
    input = { "group:repairable_tool" },
    tool = { "anvil:hammer" }
})
```

This type of recipe allows you to repair a tool or refill a consumable.

### Other Functions

* `craftlib.is_crafting_active(pos)`: Checks if the node at `pos` has a metadata key specifying if it is setup to craft or not. Returns true or false.
* `craftlib.toggle_crafting(pos, node, clicker, itemstack, pointed_thing)`: Used in `on_rightclick` in a node definition to prepare a base for crafting or to cancel a craft. It sets up the node with an inventory to store input items and takes one item from the player's itemstack. If toggled off, it removes the inventory and drops the items. It is only ran if the node is a base in any registered craft.
* `craftlib.attempt_craft(pos, node, digger)`: Used in `on_dig` in a node definition to attempt a craft with the provided inputs. This is applied to all node definitions and is only ran after a successful check from `craftlib.is_crafting_active`.
* `craftlib.get_output(recipe, provided)`: Returns an itemstring for the output of a recipe using the provided items.
* `craftlib.register_association(input_type, output_type)`: Register types of inputs to types of outputs. For example, "tree" to "wood", so that "default:tree" will be associated with "stairs:slab_wood" and "default:pine_tree" will be associated with "stairs:slab_pine_wood". Expect both parameters to be passed to `string.match()`.
* `craftlib.register_replacement(input, replacement)`: Register replacements. This checks for groups or item names in the input string, but expects item names in the replacement list.
