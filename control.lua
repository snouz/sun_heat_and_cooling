local function initialize_moshine_storage()
    if not storage.moshine_smoke_entities then storage.moshine_smoke_entities = {} end
    if not storage.moshine_patch_entities then storage.moshine_patch_entities = {} end
end

script.on_init(function()
    initialize_moshine_storage()
end)

script.on_configuration_changed(function()
    initialize_moshine_storage()
end)


local destroy_filters = {
  {filter = "name", name = "sun_heat_cooler_1" },
  {filter = "name", name = "sun_heat_cooler_2" },
}

local function on_entity_created(event)
    local entity = event.entity
    if entity.valid and (entity.name == "sun_heat_cooler_1" or entity.name == "sun_heat_cooler_2") then
        local smoke = nil
        local patch = nil
        if entity.name == "sun_heat_cooler_1" then
            smoke = entity.surface.create_entity({
                name = "sun-heat-cooler-particle-source-small",
                snap_to_grid = false,
                position = {
                    entity.position.x,
                    entity.position.y
                }
            })
            patch = entity.surface.create_entity({
                name = "sun_heat_cooler_1_cables_on_the_ground",
                snap_to_grid = false,
                position = {
                    entity.position.x,
                    entity.position.y
                }
            })
        elseif entity.name == "sun_heat_cooler_2" then
            smoke = entity.surface.create_entity({
                name = "sun-heat-cooler-particle-source",
                snap_to_grid = false,
                position = {
                    entity.position.x,
                    entity.position.y
                }
            })
            patch = entity.surface.create_entity({
                name = "sun_heat_cooler_2_cables_on_the_ground",
                snap_to_grid = false,
                position = {
                    entity.position.x,
                    entity.position.y
                }
            })
        end

        if smoke then
            storage.moshine_smoke_entities[entity.unit_number] = smoke
        end

        if patch then
            storage.moshine_patch_entities[entity.unit_number] = patch
        end
    end
end

script.on_event(defines.events.on_built_entity, on_entity_created, destroy_filters)
script.on_event(defines.events.on_robot_built_entity, on_entity_created, destroy_filters)
script.on_event(defines.events.script_raised_built, on_entity_created, destroy_filters)
script.on_event(defines.events.script_raised_revive, on_entity_created, destroy_filters)


local function on_entity_removed(event)
    local entity = event.entity
    if entity.valid then
        if not entity.unit_number then return end
        if entity.name == "sun_heat_cooler_1" or entity.name == "sun_heat_cooler_2" then
            local smoke = storage.moshine_smoke_entities[entity.unit_number]
            local patch = storage.moshine_patch_entities[entity.unit_number]
            if smoke and smoke.valid then
                smoke.destroy()
            end
            if patch and patch.valid then
                patch.destroy()
            end
            storage.moshine_smoke_entities[entity.unit_number] = nil
            storage.moshine_patch_entities[entity.unit_number] = nil
        end
    end
end


script.on_event(defines.events.on_entity_died, on_entity_removed, destroy_filters)
script.on_event(defines.events.on_pre_player_mined_item, on_entity_removed, destroy_filters)
script.on_event(defines.events.script_raised_destroy, on_entity_removed, destroy_filters)
script.on_event(defines.events.on_robot_pre_mined, on_entity_removed, destroy_filters)




