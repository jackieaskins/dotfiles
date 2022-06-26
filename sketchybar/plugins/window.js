#!/usr/bin/env node

const { spawnSync } = require("child_process");
const { COLORS, SPACER_SIZE } = require("../utils/constants");
const { getIcon } = require("../utils/icons");
const { yabaiQuery } = require("../utils/shell");
const { truncate } = require("../utils/string");

const MAX_WIDTH = 40;
const { NAME } = process.env;

const { app, title, display } = yabaiQuery(["--windows", "--window"]);

const args = [];

if (app) {
  const displays = yabaiQuery(["--displays"]);
  const icon = getIcon(app);

  args.push(
    ...displays.flatMap(({ index }) => {
      const name = `${NAME}.${index}`;
      const color = display === index ? COLORS.CYAN : COLORS.LIGHT_GRAY;

      return [
        "--add",
        "item",
        name,
        "left",

        "--set",
        name,
        `associated_display=${index}`,
        `background.border_color=${color}`,
        `background.padding_right=${SPACER_SIZE}`,
        `icon=${icon}`,
        `icon.background.color=${color}`,
        `label=${truncate(title ? `${app} | ${title}` : app, MAX_WIDTH)}`,

        "--move",
        name,
        "after",
        NAME,
      ];
    })
  );
}

spawnSync("sketchybar", ["--remove", "/window./", ...args]);
