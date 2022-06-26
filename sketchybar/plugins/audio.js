#!/usr/bin/env node

// TODO: Show current volumne, change icon if muted
const { spawnSync } = require("child_process");
const { setSketchybarItem } = require("../utils/shell");

const { stdout } = spawnSync("system_profiler", [
  "SPAudioDataType",
  "SPBluetoothDataType",
  "-json",
  "-detailLevel",
  "basic",
  "2>/dev/null",
]);
const { SPAudioDataType: audioData, SPBluetoothDataType: bluetoothData } =
  JSON.parse(stdout.toString().trim());

const activeItem = audioData[0]._items.find(
  (item) => item.coreaudio_default_audio_output_device
);
const {
  _name: name,
  coreaudio_output_source: source,
  coreaudio_device_transport: transport,
} = activeItem;

const icon = (() => {
  if (source === "External Headphones") return "􀑈";
  if (source === "MacBook Pro Speakers") return "";

  if (transport === "coreaudio_device_type_bluetooth") {
    const { device_productID: productId } =
      bluetoothData[0].device_connected[0][name];
    if (productId === "0x200E") return "􀪷";
    if (productId === "0x2002") return "􀟥";
  }

  return "蓼";
})();

setSketchybarItem(process.env.NAME, { icon });
