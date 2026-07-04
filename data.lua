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
data:extend
{
  {
    type = "lightning",
    name = "sun_heat",
    icon = icons .. "sun_heat.png",
    subgroup = "obstacles",
    factoriopedia_simulation = simulations.factoriopedia_lightning,
    damage = {amount = 1, type = "fire"},
    energy = "100MJ",
    time_to_damage = 1,
    effect_duration = 30,
    --source_offset = {0, -25},
    --source_variance = {30, 6},
    --[[sound =
    {
      variations = sound_variations_with_volume_variations("__space-age__/sound/explosions/lightning-effect", 5, 0.25, 0.8),
      advanced_volume_control =
      {
        fades = {fade_in = {curve_type = "S-curve", from = {control = 0.3, volume_percentage = 50.0}, to = {2.5, 100.0 }}},
      },
      aggregation = {max_count = 3, remove = true, count_already_playing = true},
      audible_distance_modifier = 2.25
    },]]
    --attracted_volume_modifier = 0.4,
    strike_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          --[[{
            type = "create-particle",
            repeat_count = 5,
            particle_name = "fulgora-stone-particle-big",
            offset_deviation = {{-0.8984, -0.5}, {0.8984, 0.5}},
            initial_height = 0.3,
            initial_vertical_speed = 0.03,
            initial_vertical_speed_deviation = 0.15,
            speed_from_center = 0.08,
            speed_from_center_deviation = 0.15,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 10,
            particle_name = "fulgora-stone-particle-medium",
            offset_deviation = {{-0.8984, -0.5}, {0.8984, 0.5}},
            initial_height = 0.5,
            initial_vertical_speed = 0.05,
            initial_vertical_speed_deviation = 0.15,
            speed_from_center = 0.08,
            speed_from_center_deviation = 0.15,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 25,
            particle_name = "fulgora-stone-particle-small",
            offset_deviation = {{-0.8984, -0.5}, {0.8984, 0.5}},
            initial_height = 0.5,
            initial_height_deviation = 0.5,
            initial_vertical_speed = 0.08,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.05,
            speed_from_center_deviation = 0.05,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 30,
            particle_name = "big-rock-stone-particle-tiny",
            offset_deviation = {{-0.8984, -0.5}, {0.8984, 0.5}},
            initial_height = 0.5,
            initial_height_deviation = 0.5,
            initial_vertical_speed = 0.08,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.05,
            speed_from_center_deviation = 0.05,
            only_when_visible = true
          },]]
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
    --[[graphics_set =
    {
      relative_cloud_fork_length = 0.30,
      cloud_fork_orientation_variance = 0.2,
      cloud_detail_level = 4,
      bolt_detail_level = 5,
      bolt_half_width = 0.04,
      bolt_midpoint_variance = 0.05,
      max_bolt_offset = 0.25,
      max_fork_probability = 1,
      fork_intensity_multiplier = 0.5,
      min_ground_streamer_distance = 2,
      max_ground_streamer_distance = 4,
      ground_streamer_variance = 4,
      shader_configuration =
      {
        {color = {0.0, 0.6, 1, 0.8}, distortion =  0.20, thickness = 0.20, power = 0.25},
        {color = {0.0, 0.6, 1, 1.0}, distortion =  0.40, thickness = 1.00, power = 0.25},
        {color = {0.2, 0.6, 1, 1.0}, distortion =  0.55, thickness = 1.00, power = 0.25},
        {color = {0.7, 0.6, 1, 0.6}, distortion =  0.70, thickness = 0.75, power = 0.25},
        {color = {0.4, 0.2, 1, 0.3}, distortion =  1.00, thickness = 0.50, power = 0.10},
        {color = {0.0, 0.2, 1, 0.0}, distortion = 20.00, thickness = 0.50, power = 0.01}
      },
      cloud_background = util.sprite_load("__space-age__/graphics/entity/lightning/lightning-cloud",
        {
          draw_as_glow = true,
          scale = 1,
          frame_count = 4,
          tint = {0.5, 0.5, 0.5, 0.5}
        }),
      explosion =
      {
        util.sprite_load("__space-age__/graphics/entity/lightning/lightning-explosion",{
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 36
        }),
        util.sprite_load("__space-age__/graphics/entity/lightning/lightning-explosion-2",{
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 36
         })
      },
      attractor_hit_animation = util.sprite_load("__space-age__/graphics/entity/lightning/lightning-attractor-hit-anim",{
        draw_as_glow = true,
        scale = 1,
        frame_count = 36
      }),
      ground_streamers =
      {
        util.sprite_load("__space-age__/graphics/entity/lightning/lightning-streamer-1",{
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 36
         }),
         util.sprite_load("__space-age__/graphics/entity/lightning/lightning-streamer-2",{
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 36
         }),
         util.sprite_load("__space-age__/graphics/entity/lightning/lightning-streamer-3",{
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 36
         }),
         util.sprite_load("__space-age__/graphics/entity/lightning/lightning-streamer-4",{
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 36
         }),
         util.sprite_load("__space-age__/graphics/entity/lightning/lightning-streamer-5",{
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 36
         }),
         util.sprite_load("__space-age__/graphics/entity/lightning/lightning-streamer-6",{
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 36
         }),
         util.sprite_load("__space-age__/graphics/entity/lightning/lightning-streamer-7",{
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 36
         }),
         util.sprite_load("__space-age__/graphics/entity/lightning/lightning-streamer-8",{
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 36
         }),
      },
      --light = {intensity = 5.0, size = 50, color = {0.1, 0.15, 1}}
    }]]
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
    color = util.premul_color{1,1,1, 0.20},
    cyclic = true,
    affected_by_wind = false,
    animation = {
      filename = entity .. "heat-smoke/nothing.png",
      flags = { "smoke" },
      --blend_mode = "additive",
      line_length = 8,
      width = 1,
      height = 1,
      frame_count = 60,
      --shift = {0, 0.5},
      priority = "high",
      animation_speed = 0.15,
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


  {
    type = "lightning-attractor",
    name = "sun_heat_cooler_1",
    icon = icons .. "sun_heat_cooler_1.png",
    --efficiency = 0.1,
    range_elongation = 21.0,
    --[[energy_source =
    {
      type = "electric",
      buffer_capacity = "500MJ",
      usage_priority = "primary-output",
      output_flow_limit = "500MJ",
      drain = "2.5MJ"
    },]]
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "sun_heat_cooler_1"},
    max_health = 200,
    corpse = "sun_heat_cooler_1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    factoriopedia_simulation = simulations.factoriopedia_lightning_rod,
    surface_conditions = {{ property = "pressure", min = 701, max = 701}},
    resistances =
    {
      {
        type = "fire",
        percent = 100
      },
    },
    collision_box = {{-1.15, -1.15}, {1.15, 1.15}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    lightning_strike_offset = {0, -1},
    damaged_trigger_effect = hit_effects.entity({{-1.2, -1.2},{1.2, 1.2}}),
    --drawing_box_vertical_extension = 4.3,
    open_sound = sounds.electric_network_open,
    close_sound = sounds.electric_network_close,
    working_sound =
    {

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
          --match_volume_to_activity = true,
          --activity_to_volume_modifiers = {offset = 2, inverted = true},
        },
      },
      max_sounds_per_prototype = 3,
    },
    chargable_graphics = {
      picture = {
        layers = {
          {
            filename = entity .. "sun_heat_cooler_1/sun_heat_cooler_1.png",
            width = 320,
            height = 320,
            line_length = 1,
            priority = "high",
            scale = 0.5,
          },
          {
            filename = entity .. "sun_heat_cooler_1/sun_heat_cooler_1-shadow.png",
            width = 320,
            height = 320,
            line_length = 1,
            priority = "high",
            draw_as_shadow = true,
            scale = 0.5,
          }
        }
      },
      charge_animation = {
        layers =
        {
          {
            filename = entity .. "sun_heat_cooler_1/sun_heat_cooler_1-charge.png",
            run_mode = "forward",
            width = 320,
            height = 320,
            line_length = 4,
            frame_count = 8,
            priority = "high",
            --blend_mode = "additive",
            scale = 0.5,
            --draw_as_glow = true,
            animation_speed = 1/10,
          }
        }
      },
      charge_animation_is_looped = true,
      charge_cooldown = 10,
      --[[
      charge_animation = {
        layers =
        {
          {
            filename = entity .. "sun_heat_cooler_1/sun_heat_cooler_1-charge.png",
            run_mode = "forward-then-backward",
            width = 320,
            height = 320,
            line_length = 8,
            priority = "high",
            blend_mode = "additive",
            scale = 0.5,
            frame_count = 16,
            draw_as_glow = true,
            animation_speed = 1/10,
          }
        }
      },
      charge_animation_is_looped = true,
      charge_cooldown = 0,
      
      discharge_animation = {
        layers = {
          {
            filename = entity .. "sun_heat_cooler_1/sun_heat_cooler_1-discharge.png",
            width = 62,
            height = 314,
            shift = util.by_pixel( 0.0, -69.5),
            line_length = 8,
            priority = "high",
            blend_mode = "additive",
            scale = 0.5,
            frame_count = 24,
            draw_as_glow = true,
          }
        }
      },
      ]]
      --discharge_cooldown = 60
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
        scale = 5
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
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    tile_width = 1,
    tile_height = 1,
    expires = false,
    animation = {
      filename = entity .. "sun_heat_cooler_1/sun_heat_cooler_1-remnants.png",
      width = 320,
      height = 320,
      line_length = 1,
      direction_count = 1,
      scale = 0.5
    }
  },

  {
    type = "item",
    name = "sun_heat_cooler_1",
    icon = icons .. "sun_heat_cooler_1.png",
    subgroup = "environmental-protection",
    order = "e[sun_heat_cooler_1]",
    inventory_move_sound = item_sounds.electric_small_inventory_move,
    pick_sound = item_sounds.electric_small_inventory_pickup,
    drop_sound = item_sounds.electric_small_inventory_move,
    place_result = "sun_heat_cooler_1",
    stack_size = 50,
    default_import_location = "moshine",
    random_tint_color = item_tints.iron_rust
  },

  {
    type = "recipe",
    name = "sun_heat_cooler_1",
    categories = {"crafting", "electromagnetics"},
    surface_conditions = {{ property = "pressure", min = 701, max = 701}},
    energy_required = 5,
    ingredients =
    {
      {type = "item", name = "silicon", amount = 3},
      {type = "item", name = "pump", amount = 1},
    },
    results = {{type="item", name="sun_heat_cooler_1", amount=1}},
    enabled = false
  },

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
    prerequisites = {"moshine-tech-silicon-carbide"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 30
    }
  },


  {
    type = "build-entity-achievement",
    name = "moshine_build_sun_cooler",
    order = "a[progress]-a[automate-this]",
    to_build = "sun_heat_cooler_1",
    icon = technology .. "moshine_build_sun_cooler.png",
    icon_size = 128
  },
}
end