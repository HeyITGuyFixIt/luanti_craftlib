# luanti_craftlib

Immersive crafting library mod for Luanti.

## API

### Surface Crafts

```lua
craftlib.register_craft({
    surface = {"group:soil"},
    input = {"group:tree"},
    tool = "group:axe",
    output = {"group:slab 2"}
})
```

Example usage of the API to register a craft to split a tree node with an axe, outputting two wood slabs. In this example, a user would place a tree node on the dirt while sneaking, then they would dig it with an axe to result in the output of two wood slabs.

You can set the `surface` to a list of any node or group that can be crafted on. For example, this can be a soil or stone group to craft on the ground, or can be set to a craft table or anvil for a work surface.

You can set the `input` to a list of any item, node, or group that the player can craft with. This follows the same logic as a shapeless recipe. The player must sneak and place in the same spot to trigger this.

You can set the `tool` to any tool or group to specify what tool the player crafts with. The player can dig with this tool to trigger this action.

You can set the `output` to a list of items that are created from this craft. Instead of replacements, like in craft recipes, specify the output of a replacement here. So if the `input` includes a bucket of water, add an empty bucket to the `output`, alongside the regular output of the craft.

### Container Crafts

```lua
craftlib.register_craft({
    container = {"recipe:mortar"},
    input = {"farming:wheat 4"},
    tool = "group:stick",
    output = {"farming:flour"}
})
```

Here is another type of craft that uses a `container` instead of a `surface`. In this example, set the `container` to a list of any node or group that can contain items. An entity is created to fit inside of it and display the input. The rest of the parameters work the same as with `surface` crafts.
