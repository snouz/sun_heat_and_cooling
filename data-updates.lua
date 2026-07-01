local graphics = "__sun_heat_and_cooling__/graphics/"
local exemptlist = {
"logistic-robot","construction-robot","capture-robot","combat-robot",
"electric-pole","generator","fusion-generator","burner-generator","electric-energy-interface","boiler","solar-panel","accumulator","power-switch",
"pipe","pipe-to-ground","heat-pipe","valve","infinity-pipe","pump","offshore-pump","storage-tank",
"inserter","simple-entity",
"character","proxy-container","container","logistic-container","infinity-container","temporary-container","cargo-pod","cargo-landing-pad",
"curved-rail-a","elevated-curved-rail-a" ,"curved-rail-b","elevated-curved-rail-b" ,"half-diagonal-rail","elevated-half-diagonal-rail" ,"legacy-curved-rail","legacy-straight-rail","rail-ramp","straight-rail","elevated-straight-rail",
"rail-chain-signal","rail-signal","rail-support", "train-stop","locomotive","artillery-wagon","cargo-wagon","fluid-wagon",
"wall","gate","lamp","unit-spawner",
"lane-splitter","linked-belt","loader-1x1","loader","splitter","transport-belt","underground-belt",
"tile","optimized-decorative","entity-ghost","corpse","rail-remnants",
}


if data.raw.planet["moshine"] then
  data.raw.planet["moshine"].lightning_properties =
  {
    lightnings_per_chunk_per_tick = 1 / 20, --cca once per chunk every 10 seconds (600 ticks)
    search_radius = 10.0,
    lightning_types = {"sun_heat"},
    lightning_multiplier_at_day = 1,
    lightning_multiplier_at_night = 0,
    lightning_warning_icon = {
      filename = graphics .. "/icons/endangered-by-sun.png",
      priority = "extra-high-no-scale",
      width = 64,
      height = 64,
      scale = 0.8,
      flags = {"icon"}
    },
    priority_rules =
    {
      {
        type = "impact-soundset",
        string = "metal",
        priority_bonus = 1
      },
      {
        type = "id",
        string = "ai-trainer",
        priority_bonus = 1000,
      },
    },
    exemption_rules = 
    {
      {
        type = "countAsRockForFilteredDeconstruction",
        string = "true",
      },
      {
        type = "id",
        string = "foundry",
      },
    }
  }

  for _, proto in pairs(exemptlist) do
    table.insert(data.raw.planet["moshine"].lightning_properties.exemption_rules, {type = "prototype", string = proto})
  end
  for _, proto in pairs(data.raw["furnace"]) do
    if proto.name and not (proto.name == "ai-trainer") then
      table.insert(data.raw.planet["moshine"].lightning_properties.exemption_rules, {type = "id", string = proto.name})
    end
  end
  for _, proto in pairs(data.raw["mining-drill"]) do
    if proto.name and not (proto.name == "data-extractor") then
      table.insert(data.raw.planet["moshine"].lightning_properties.exemption_rules, {type = "id", string = proto.name})
    end
  end
end