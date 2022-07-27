const ICONS = {
  "Amazon Chime": "",
  "Brave Browser": "爵",
  Calendar: "",
  FaceTime: "",
  Finder: "",
  Firefox: "",
  "Google Chrome": "",
  kitty: "􀩼",
  Messages: "",
  "Microsoft Outlook": "",
  Notes: "",
  Spotify: "",
  "System Preferences": "",
  TV: "",
};

function getIcon(app) {
  return ICONS[app] ?? "􀿨";
}

module.exports = {
  getIcon,
};
