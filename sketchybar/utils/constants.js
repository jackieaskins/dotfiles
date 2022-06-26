const { execSync } = require("child_process");

const output = execSync("~/.config/sketchybar/utils/env.sh");
module.exports = JSON.parse(output.toString().trim());
