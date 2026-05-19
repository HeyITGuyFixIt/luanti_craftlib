core.register_node("metalworking:anvil", {})

craftlib.register_craft({
    type = "craft",
    base = {"group:soil", "group:stone"},
    input = {""},
    output = {"metalworking:anvil"}
})

