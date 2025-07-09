--@type LazySpec
return {
  'saghen/blink.pairs',
  build = 'nix --accept-flake-config run .#build-plugin',
  enabled = not MY_CONFIG.use_ultimate_autopair,
  --- @module 'blink.pairs'
  --- @type blink.pairs.Config
  opts = {
    highlights = {
      enabled = false,
      matchparen = {
        enabled = true,
        group = 'MatchParen',
      },
    },
  },
}
