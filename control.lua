local moshine_smoke_entities = {}
local moshine_patch_entities = {}

script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity, defines.events.script_raised_built, defines.events.script_raised_revive}, function(event)
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
            moshine_smoke_entities[entity.unit_number] = smoke
        end
        if patch then
            moshine_patch_entities[entity.unit_number] = patch
        end
    end
end)

script.on_event({defines.events.on_entity_died, defines.events.on_pre_player_mined_item, defines.events.script_raised_destroy, defines.events.on_robot_pre_mined}, function(event)
    local entity = event.entity
    if entity.valid then
        if not entity.unit_number then return end
        if (entity.name == "sun_heat_cooler_1" or entity.name == "sun_heat_cooler_2") then
            local smoke = moshine_smoke_entities[entity.unit_number]
            local patch = moshine_patch_entities[entity.unit_number]
            if smoke and smoke.valid then
                smoke.destroy()
            end
            if patch and patch.valid then
                patch.destroy()
            end
            moshine_smoke_entities[entity.unit_number] = nil
            moshine_patch_entities[entity.unit_number] = nil
        end
    end
end)

