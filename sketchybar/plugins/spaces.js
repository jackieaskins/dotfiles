#!/usr/bin/env node

const { spawnSync } = require("child_process");
const { yabaiQuery } = require("../utils/shell");
const { getIcon } = require("../utils/icons");
const { COLORS } = require("../utils/constants");

const { NAME } = process.env;

const ACCENT_COLOR = COLORS.ORANGE;

const allWindows = yabaiQuery(["--windows"]);
allWindows.sort((a, b) => a.app.localeCompare(b.app));
const windowsBySpace = allWindows.reduce((windows, window) => {
  const {
    app,
    "is-minimized": isMinimized,
    "is-sticky": isSticky,
    space,
    title,
  } = window;

  if (isSticky || isMinimized || (app === "Hammerspoon" && !title)) {
    return windows;
  }

  return {
    ...windows,
    [space]: [...(windows[space] ?? []), window],
  };
}, {});

const args = yabaiQuery(["--spaces"]).flatMap(
  ({ index: space, display, "is-visible": isVisible }) => {
    const name = `${NAME}.${space}`;
    const windows = windowsBySpace[space] ?? [];
    const color = isVisible ? ACCENT_COLOR : COLORS.FG;

    const windowIcons = windows.map(({ app }) => getIcon(app));
    const label = [space, ...windowIcons].join(" ");

    return [
      "--add",
      "space",
      name,
      "left",

      "--set",
      name,
      `associated_display=${display}`,
      `associated_space=${space}`,
      `background.border_color=${color}`,
      "background.padding_left=5",
      "icon.drawing=off",
      `label=${label}`,
      `label.color=${color}`,
    ];
  }
);

spawnSync("sketchybar", [
  "--remove",
  `/${NAME}./`,

  "--set",
  NAME,
  `icon.background.color=${ACCENT_COLOR}`,
  "label.drawing=off",

  ...args,
]);
