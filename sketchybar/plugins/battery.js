#!/usr/bin/env node

const { spawnSync } = require("child_process");
const { setSketchybarItem } = require("../utils/shell");
const {
  COLORS: { GREEN, ORANGE, RED, YELLOW },
} = require("../utils/constants");

const { stdout } = spawnSync("pmset", ["-g", "batt"]);
const batteryInfo = stdout.toString();
const percentage = parseInt(batteryInfo.match(/(\d+)%/)[1]);
const charging = !batteryInfo.includes("discharging");

const color = (() => {
  if (charging) return ORANGE;

  if (percentage >= 60) return GREEN;
  if (percentage > 20) return YELLOW;

  return RED;
})();

const icon = (() => {
  if (charging) return "";
  if (percentage >= 90) return "";
  if (percentage > 70) return "";
  if (percentage > 40) return "";
  if (percentage > 5) return "";
  return "";
})();

setSketchybarItem(process.env.NAME, {
  "background.border_color": color,
  icon: icon,
  "icon.background.color": color,
  label: `${percentage}%`,
});
