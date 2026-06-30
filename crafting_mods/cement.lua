craftlib.register_craft({
    type = "mix",
    base = {"bucket:bucket_empty"},
    input = {"group:sand", "default:gravel"},
    tool = {"group:stick"},
    output = {"cement:dry 2"}
})

craftlib.register_craft({
    type = "mix",
    base = {"bucket:bucket_water"},
    input = {"group:sand", "default:gravel"},
    tool = {"group:stick"},
    output = {"cement:wet 2"},
    base_replacement = {"bucket:bucket_empty"}
})

craftlib.register_craft({
    type = "craft",
    base = {"crafting_mtg:crafttable"},
    input = {
        "default:steel_ingot",
        "group:stick",
        "dye:blue",
        "default:paper 2",
        "group:wood",
        "group:sand 2"
    },
    output = {"cement:sanding_tool"},
    tool = {""}
})