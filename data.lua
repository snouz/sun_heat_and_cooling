local graphics = "__sun_heat_and_cooling__/graphics/"
local sound = "__sun_heat_and_cooling__/sound/"
local icons = "__sun_heat_and_cooling__/graphics/icons/"
local technology = "__sun_heat_and_cooling__/graphics/technology/"
local entity = "__sun_heat_and_cooling__/graphics/entity/"



--require ("sound-util")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")
local sounds = require("__base__.prototypes.entity.sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")

if mods["Moshine"] then
  local damage = 100
  if settings.startup["moshine_heat_damage_amount"] and settings.startup["moshine_heat_damage_amount"].value then
    damage = settings.startup["moshine_heat_damage_amount"].value
  end


  local sunheatsim =
  {
    planet = "moshine",
    init =
    [[
      game.simulation.camera_position = {0, 2.5}
      for x = -8, 8, 1 do
        for y = -3, 4 do
          game.surfaces[1].set_tiles{{position = {x, y}, name = "moshine-hot-swamp"}}
        end
      end
    ]]
  }


  local make_collector_simulation = function(name, zoom, X, Y)
    return
    [[
      require("__core__/lualib/story")
      game.simulation.camera_zoom = ]]..zoom..[[
      game.simulation.camera_position = {]]..X..[[, ]]..Y..[[}
      game.surfaces[1].create_entity{name = "]]..name..[[", position = {0, 0}}
      for x = -8, 8, 1 do
        for y = -3, 4 do
          game.surfaces[1].set_tiles{{position = {x, y}, name = "moshine-hot-swamp"}}
        end
      end
      local story_table =
      {
        {
          {
            name = "start",
            action = function() game.surfaces[1].execute_lightning{name = "sun_heat", position = {0, 2}} end
          },
          {
            condition = story_elapsed_check(1),
            action = function() story_jump_to(storage.story, "start") end
          }
        }
      }
      tip_story_init(story_table)
    ]]
  end
  local sun_heat_cooler_1sim = { planet = "moshine", init = make_collector_simulation("sun_heat_cooler_1", "3", "0.5", "0") }
  local sun_heat_cooler_2sim = { planet = "moshine", init = make_collector_simulation("sun_heat_cooler_2", "2", "1", "0") }




data:extend({

--    ██   ██ ███████  █████  ████████ 
--    ██   ██ ██      ██   ██    ██    
--    ███████ █████   ███████    ██    
--    ██   ██ ██      ██   ██    ██    
--    ██   ██ ███████ ██   ██    ██    
  {
    type = "lightning",
    name = "sun_heat",
    icon = icons .. "sun_heat.png",
    subgroup = "obstacles",
    flags = {"not-selectable-in-game"},
    factoriopedia_simulation = sunheatsim,
    damage = 
    {
      amount = 0.15 * (damage/100),
      type = "fire"
    },
    --energy = "0J",
    time_to_damage = 1,
    effect_duration = 30,
    strike_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-trivial-smoke",
            smoke_name = "sun_heat_smoke",
            offsets = {{0, 0}},
            offset_deviation = {{-0.9, -0.7}, {0.9, 0.7}},
            speed = {0, 0},
            initial_height = 0,
            speed_from_center = 0.08,
            speed_from_center_deviation = 0.015,
            only_when_visible = true
          }
        }
      }
    },
  },

  {
    type = "trivial-smoke",
    name = "sun_heat_smoke",
    duration = 1200,
    fade_in_duration = 600,
    fade_away_duration = 600,
    glow_fade_away_duration = 600,
    spread_duration = 1200,
    start_scale = 0.62,
    end_scale = 0.75,
    color = util.premul_color{1,1,1, 0.25},
    cyclic = true,
    affected_by_wind = false,
    animation = {
      filename = entity .. "heat-smoke/nothing.png",
      flags = { "smoke" },
      width = 1,
      height = 1,
      repeat_count = 60,
      frame_count = 1,
      priority = "high",
      animation_speed = 0.15,
      blend_mode = "additive",
    },
    glow_animation = {
      filename = entity .. "heat-smoke/heat-smoke-glow.png",
      flags = { "smoke" },
      blend_mode = "additive",
      line_length = 8,
      width = 253,
      height = 210,
      frame_count = 60,
      --shift = {-0.265625, -0.09375},
      priority = "high",
      animation_speed = 0.15,
    },
    movement_slow_down_factor = 0.1,
  },
  --cooler smokes
  {
    type = "trivial-smoke",
    name = "sun-heat-cooler-smoke-small",
    animation =
    {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = {0, 0},
      priority = "high",
      animation_speed = 0.1,
      filename = entity .. "sun_heat_cooler_2/smoke.png", --"__base__/graphics/entity/smoke/smoke.png",
      flags = { "smoke" },
      --scale = 1.5,
    },
    cyclic = true,
    duration = 240,
    fade_in_duration = 120,
    fade_away_duration = 120,
    start_scale = 0.3,
    end_scale = 1.2,
    color = {1, 1, 1, 0.2},
    affected_by_wind = false,
    movement_slow_down_factor = 0.1
  },
  {
    type = "trivial-smoke",
    name = "sun-heat-cooler-smoke",
    animation =
    {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = {0, 0},
      priority = "high",
      animation_speed = 0.3,
      filename = entity .. "sun_heat_cooler_2/smoke.png", --"__base__/graphics/entity/smoke/smoke.png",
      flags = { "smoke" },
      --scale = 1.5,
    },
    cyclic = true,
    duration = 240,
    fade_in_duration = 120,
    fade_away_duration = 120,
    start_scale = 0.7,
    end_scale = 5,
    color = {1, 1, 1, 0.5},
    affected_by_wind = false,
    movement_slow_down_factor = 0.5
  },
  {
    type = "particle-source",
    name = "sun-heat-cooler-particle-source-small",
    flags = {"not-on-map", "not-blueprintable", "not-deconstructable", "not-selectable-in-game"},
    collision_mask = {layers = {}},
    time_to_live = 4294967295,
    time_before_start = 50,
    height = 0,
    height_deviation = 0,
    vertical_speed = -0.02,
    vertical_speed_deviation = 0.01,
    horizontal_speed = 0,
    horizontal_speed_deviation = 0.01,
    smoke =
    {
      {
        name = "sun-heat-cooler-smoke-small",
        frequency = 0.008,
        position = {0, 0},
        deviation = {0, 0},
        height = 0,
        height_deviation = 0,
        starting_vertical_speed = 0.03,
        starting_vertical_speed_deviation = 0.01,
        vertical_speed_slowdown = 0.2
      }
    },
  },
  {
    type = "particle-source",
    name = "sun-heat-cooler-particle-source",
    flags = {"not-on-map", "not-blueprintable", "not-deconstructable", "not-selectable-in-game"},
    collision_mask = {layers = {}},
    time_to_live = 4294967295,
    time_before_start = 100,
    height = 0.5,
    height_deviation = 0,
    vertical_speed = -0.02,
    vertical_speed_deviation = 0.01,
    horizontal_speed = 0,
    horizontal_speed_deviation = 0.01,
    smoke =
    {
      {
        name = "sun-heat-cooler-smoke",
        frequency = 0.015,
        position = {-0.5, 0},
        deviation = {0, 0},
        height = 0,
        height_deviation = 0,
        starting_vertical_speed = -0.01,
        starting_vertical_speed_deviation = 0.01,
        vertical_speed_slowdown = 0.965
      }
    },
  },
  {
    -- it's actually green
    name = "sun_heat_cooler_1_cables_on_the_ground",
    type = "simple-entity",
    order = "z",
    hidden = true,
    flags = {"not-selectable-in-game"},
    --collision_box = {{-0.01, -0.01}, {0.01, 0.01}},
    collision_box = {{-5, -5}, {5, 5}},
    collision_mask = {layers = {}},
    lower_render_layer = "decals",
    lower_pictures =
    {
      {
        filename = entity .. "sun_heat_cooler_1/sun_heat_cooler_1-cables.png",
        flags = {"terrain"},
        width = 640,
        height = 640,
        line_length = 1,
        priority = "low",
        scale = 0.5,
        blend_mode = "additive",
      },
    },
  },
  {
    -- it's actually green
    name = "sun_heat_cooler_2_cables_on_the_ground",
    type = "simple-entity",
    order = "z",
    hidden = true,
    flags = {"not-selectable-in-game"},
    --collision_box = {{-0.01, -0.01}, {0.01, 0.01}},
    collision_box = {{-23, -23}, {23, 23}},
    collision_mask = {layers = {}},
    lower_render_layer = "ground-patch",
    --render_layer = "elevated-higher-object",
    lower_pictures =
    --pictures =
    {
      {
        filename = entity .. "sun_heat_cooler_2/sun_heat_cooler_2-shield.png",
        --width = 2048,
        --height = 2048,
        flags = {"terrain"},
        width = 1618,
        height = 1618,
        scale = 0.9,
        --draw_as_glow = true,
        blend_mode = "additive",
        --occludes_light = false,
        --apply_special_effect = true,
        --tint = {1,1,1,0.2},
      },
      --[[
      {
        filename = entity .. "sun_heat_cooler_2/sun_heat_cooler_2-cables.png",
        width = 640,
        height = 640,
        scale = 0.5,
      },
      ]]
    },
    --[[render_layer = "elevated-higher-object",
    pictures =
    {
      {
        filename = entity .. "sun_heat_cooler_2/sun_heat_cooler_2-shield.png",
        width = 4096,
        height = 4096,
        scale = 0.5,
        draw_as_glow = true,
        blend_mode = "additive",
      },
    },]]
  },

--    ██   ██ ███████  █████  ████████          █████  ████████ ████████ ██████   █████   ██████ ████████  ██████  ██████           ██ 
--    ██   ██ ██      ██   ██    ██            ██   ██    ██       ██    ██   ██ ██   ██ ██         ██    ██    ██ ██   ██         ███ 
--    ███████ █████   ███████    ██            ███████    ██       ██    ██████  ███████ ██         ██    ██    ██ ██████           ██ 
--    ██   ██ ██      ██   ██    ██            ██   ██    ██       ██    ██   ██ ██   ██ ██         ██    ██    ██ ██   ██          ██ 
--    ██   ██ ███████ ██   ██    ██    ███████ ██   ██    ██       ██    ██   ██ ██   ██  ██████    ██     ██████  ██   ██ ███████  ██ 

{
    type = "lightning-attractor",
    name = "sun_heat_cooler_1",
    icon = icons .. "sun_heat_cooler_1.png",
    range_elongation = 4.0, -------------------------------------------------------------------------------------RANGE
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.2, result = "sun_heat_cooler_1"},
    max_health = 200,
    corpse = "sun_heat_cooler_1-remnants",
    dying_explosion =  "selector-combinator-explosion",
    factoriopedia_simulation = sun_heat_cooler_1sim,
    surface_conditions = {{ property = "pressure", min = 701, max = 701}},
    resistances =
    {
      {
        type = "fire",
        percent = 100
      },
    },
    collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    lightning_strike_offset = {0, 0},
    damaged_trigger_effect = hit_effects.entity({{-0.2, -0.2},{0.2, 0.2}}),
    open_sound = sounds.metal_small_open,
    close_sound = sounds.metal_small_close,
    working_sound = nil,
    --[[{

      main_sounds =
      {
        {
          fade_in_ticks = 120,
          fade_out_ticks = 280,
          sound =
          {
            filename = sound .. "sun_heat_cooler_1-charge.ogg",
            volume = 1,
            audible_distance_modifier = 0.5,
          },
        },
      },
      max_sounds_per_prototype = 3,
    },]]
    chargable_graphics = {
      picture = {
        layers = {
          {
            filename = entity .. "sun_heat_cooler_1/sun_heat_cooler_1.png",
            width = 128,
            height = 128,
            line_length = 1,
            priority = "high",
            scale = 0.5,
          },
          --[[
          {
            filename = entity .. "sun_heat_cooler_1/sun_heat_cooler_1-shadow.png",
            width = 128,
            height = 128,
            line_length = 1,
            priority = "high",
            draw_as_shadow = true,
            scale = 0.5,
          },
          ]]
          --[[
          {
            filename = entity .. "sun_heat_cooler_1/sun_heat_cooler_1-cables.png",
            width = 640,
            height = 640,
            line_length = 1,
            priority = "low",
            draw_as_shadow = true,
            scale = 0.5,
          },
          ]]
        }
      },
      charge_animation = nil,
      charge_animation_is_looped = true,
      charge_cooldown = 10,
    },
    water_reflection =
    {
      pictures =
      {
        filename = entity .. "sun_heat_cooler_1/sun_heat_cooler_1-reflection.png",
        priority = "extra-high",
        width = 36,
        height = 30,
        shift = util.by_pixel(0, 50),
        variation_count = 1,
        scale = 1.5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },

  {
    type = "corpse",
    name = "sun_heat_cooler_1-remnants",
    icon = icons .. "sun_heat_cooler_1.png",
    flags = {"placeable-neutral", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "environmental-protection-remnants",
    order = "a-k-b",
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    tile_width = 1,
    tile_height = 1,
    expires = false,
    animation = {
      filename = entity .. "sun_heat_cooler_1/sun_heat_cooler_1-remnants.png",
      width = 128,
      height = 128,
      line_length = 1,
      direction_count = 1,
      scale = 0.5
    }
  },

--    ██   ██ ███████  █████  ████████          █████  ████████ ████████ ██████   █████   ██████ ████████  ██████  ██████          ██████  
--    ██   ██ ██      ██   ██    ██            ██   ██    ██       ██    ██   ██ ██   ██ ██         ██    ██    ██ ██   ██              ██ 
--    ███████ █████   ███████    ██            ███████    ██       ██    ██████  ███████ ██         ██    ██    ██ ██████           █████  
--    ██   ██ ██      ██   ██    ██            ██   ██    ██       ██    ██   ██ ██   ██ ██         ██    ██    ██ ██   ██         ██      
--    ██   ██ ███████ ██   ██    ██    ███████ ██   ██    ██       ██    ██   ██ ██   ██  ██████    ██     ██████  ██   ██ ███████ ███████ 

  {
    type = "lightning-attractor",
    name = "sun_heat_cooler_2",
    icon = icons .. "sun_heat_cooler_2.png",
    range_elongation = 47.0, -------------------------------------------------------------------------------------RANGE
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "sun_heat_cooler_2"},
    max_health = 200,
    corpse = "sun_heat_cooler_2-remnants",
    dying_explosion = "chemical-plant-explosion",
    factoriopedia_simulation = sun_heat_cooler_2sim,
    surface_conditions = {{ property = "pressure", min = 701, max = 701}},
    alert_icon_scale = 0,
    resistances =
    {
      {
        type = "fire",
        percent = 100
      },
    },
    collision_box = {{-1.15, -1.15}, {1.15, 1.15}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    lightning_strike_offset = {0, 0},
    damaged_trigger_effect = hit_effects.entity({{-1.2, -1.2},{1.2, 1.2}}),
    open_sound = sounds.metal_small_open,
    close_sound = sounds.metal_small_close,
    build_sound = {
      filename = sound .. "cooler2_placing.ogg",
      volume = 0.9,
      --audible_distance_modifier = 0.5,
    },
    working_sound = 
    {
      main_sounds =
      {
        {
          fade_in_ticks = 120,
          fade_out_ticks = 280,
          sound =
          {
            filename = sound .. "sun_heat_cooler_2-charge.ogg",
            volume = 0.3,
            audible_distance_modifier = 400,
          },
        },
      },
      max_sounds_per_prototype = 3,
    },
    --efficiency = 0,
    --[[energy_source =
    {
      type = "electric",
      buffer_capacity = "10MJ",
      usage_priority = "primary-output",
      output_flow_limit = "10MJ",
      drain = "2.5MJ"
    },]]
    chargable_graphics = {
      picture = {
        layers = {
          {
            filename = entity .. "sun_heat_cooler_2/sun_heat_cooler_2.png",
            width = 320,
            height = 320,
            line_length = 1,
            priority = "high",
            scale = 0.5,
          },
          {
            filename = entity .. "sun_heat_cooler_2/sun_heat_cooler_2-shadow.png",
            width = 320,
            height = 320,
            line_length = 1,
            priority = "high",
            draw_as_shadow = true,
            scale = 0.5,
          },
        }
      },
      charge_animation = nil,
      charge_animation_is_looped = true,
      charge_cooldown = 100,
    },
    water_reflection =
    {
      pictures =
      {
        filename = entity .. "sun_heat_cooler_2/sun_heat_cooler_2-reflection.png",
        priority = "extra-high",
        width = 36,
        height = 30,
        shift = util.by_pixel(0, 50),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },

  {
    type = "corpse",
    name = "sun_heat_cooler_2-remnants",
    icon = icons .. "sun_heat_cooler_2.png",
    flags = {"placeable-neutral", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "environmental-protection-remnants",
    order = "a-k-b",
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    tile_width = 3,
    tile_height = 3,
    expires = false,
    animation = {
      filename = entity .. "sun_heat_cooler_2/sun_heat_cooler_2-remnants.png",
      width = 320,
      height = 320,
      line_length = 1,
      direction_count = 1,
      scale = 0.5
    }
  },
--    ██ ████████ ███████ ███    ███ 
--    ██    ██    ██      ████  ████ 
--    ██    ██    █████   ██ ████ ██ 
--    ██    ██    ██      ██  ██  ██ 
--    ██    ██    ███████ ██      ██ 
  {
    type = "item",
    name = "sun_heat_cooler_1",
    icon = icons .. "sun_heat_cooler_1.png",
    subgroup = "moshine-production-machine",
    order = "ffi",
    inventory_move_sound = item_sounds.electric_small_inventory_move,
    pick_sound = item_sounds.electric_small_inventory_pickup,
    drop_sound = item_sounds.electric_small_inventory_move,
    place_result = "sun_heat_cooler_1",
    stack_size = 50,
    default_import_location = "moshine",
    random_tint_color = item_tints.iron_rust
  },
  {
    type = "item",
    name = "sun_heat_cooler_2",
    icon = icons .. "sun_heat_cooler_2.png",
    subgroup = "moshine-production-machine",
    order = "ffj",
    inventory_move_sound = item_sounds.electric_small_inventory_move,
    pick_sound = item_sounds.electric_small_inventory_pickup,
    drop_sound = item_sounds.electric_small_inventory_move,
    place_result = "sun_heat_cooler_2",
    stack_size = 50,
    default_import_location = "moshine",
    random_tint_color = item_tints.iron_rust
  },
--    ██████  ███████  ██████ ██ ██████  ███████ 
--    ██   ██ ██      ██      ██ ██   ██ ██      
--    ██████  █████   ██      ██ ██████  █████   
--    ██   ██ ██      ██      ██ ██      ██      
--    ██   ██ ███████  ██████ ██ ██      ███████ 
  {
    type = "recipe",
    name = "sun_heat_cooler_1",
    categories = {"crafting", "electromagnetics"},
    --surface_conditions = {{ property = "pressure", min = 701, max = 701}},
    energy_required = 1,
    ingredients =
    {
      {type = "item", name = "offshore-pump", amount = 1},
      {type = "item", name = "ice", amount = 10},
    },
    results = {{type="item", name="sun_heat_cooler_1", amount=1}},
    enabled = false
  },
  {
    type = "recipe",
    name = "sun_heat_cooler_2",
    categories = {"cryogenics"},
    --surface_conditions = {{ property = "pressure", min = 701, max = 701}},
    energy_required = 5,
    ingredients =
    {
      {type = "item", name = "silicon-carbide", amount = 10},
      {type = "item", name = "electric-engine-unit", amount = 5},
      {type = "item", name = "energy-shield-equipment", amount = 1},
      {type = "fluid", name = "fluoroketone-cold", amount = 10},
    },
    results = {{type="item", name="sun_heat_cooler_2", amount=1}},
    enabled = false,
    sort_item_ingredients = false,
    
  },

--    ████████ ███████  ██████ ██   ██ 
--       ██    ██      ██      ██   ██ 
--       ██    █████   ██      ███████ 
--       ██    ██      ██      ██   ██ 
--       ██    ███████  ██████ ██   ██ 
  {
    type = "technology",
    name = "sun_heat_cooler_1_tech",
    icon = technology .. "sun_heat_cooler_1_tech.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "sun_heat_cooler_1",
      }
    },
    prerequisites = {"planet-discovery-moshine"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1}
      },
      time = 30
    }
  },
  {
    type = "technology",
    name = "sun_heat_cooler_2_tech",
    icon = technology .. "sun_heat_cooler_2_tech.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "sun_heat_cooler_2",
      }
    },
    prerequisites = {"sun_heat_cooler_1_tech","moshine-tech-silicon-carbide","cryogenic-science-pack"},
    unit =
    {
      count = 460,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"cryogenic-science-pack", 1},
      },
      time = 30
    }
  },

--     █████   ██████ ██   ██ ██ ███████ ██    ██ ███████ ███    ███ ███████ ███    ██ ████████ 
--    ██   ██ ██      ██   ██ ██ ██      ██    ██ ██      ████  ████ ██      ████   ██    ██    
--    ███████ ██      ███████ ██ █████   ██    ██ █████   ██ ████ ██ █████   ██ ██  ██    ██    
--    ██   ██ ██      ██   ██ ██ ██       ██  ██  ██      ██  ██  ██ ██      ██  ██ ██    ██    
--    ██   ██  ██████ ██   ██ ██ ███████   ████   ███████ ██      ██ ███████ ██   ████    ██    
  {
    type = "build-entity-achievement",
    name = "moshine_build_sun_cooler",
    order = "m[moshine]-ggg",
    to_build = "sun_heat_cooler_2",
    icon = technology .. "moshine_build_sun_cooler.png",
    icon_size = 128
  },
  --[[{
    type = "kill-achievement",
    name = "moshine_sun_heat_destroyed",
    order = "f[kill]-l[moshine_sun_heat_destroyed]",
    type_to_kill = {"big-demolisher", },
    --personally = false,
    damage_dealer = "sun_heat",
    amount = 1,
    icon = technology .. "moshine_sun_heat_destroyed.png",
    icon_size = 128
  },]]
})
end