const { spawnSync } = require("child_process");

function osa(action) {
  const { stdout } = spawnSync("osascript", ["-e", action]);
  return stdout.toString().trim();
}

function setSketchybarItem(name, properties) {
  spawnSync("sketchybar", [
    "--set",
    name,
    ...Object.entries(properties).map(([key, value]) => `${key}=${value}`),
  ]);
}

function yabaiCommand(args) {
  spawnSync("yabai", ["-m", ...args]);
}

function yabaiQuery(args) {
  const { stdout } = spawnSync("yabai", ["-m", "query", ...args]);
  try {
    return JSON.parse(stdout.toString().trim());
  } catch (_e) {
    return {};
  }
}

module.exports = {
  osa,
  setSketchybarItem,
  yabaiCommand,
  yabaiQuery,
};
