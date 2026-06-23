vim.lsp.start {
  name = 'laravel-language-server',
  cmd = {
    'npx',
    'ts-node',
    -- Update this with the path to your server.ts
    vim.fn.expand '~/code/laravel-language-server/server/src/server.ts',
  },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
}
