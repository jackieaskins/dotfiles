--@type LazySpec
return {
  'saghen/blink.pairs',
  build = 'cargo build --release',
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
