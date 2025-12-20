local M = {}

--- Deep extend tables with specific behavior:
--- 1. Handles nil inputs gracefully
--- 2. Always merges recursively (like 'force' behavior)
--- 3. Extends lists (integer-indexed tables) instead of overwriting them
---@param ... table|nil
---@return table
function M.deep_extend(...)
  local result = {}
  local count = select('#', ...)

  -- Iterate over all passed arguments
  for i = 1, count do
    local t = select(i, ...)
    if t and type(t) == 'table' then
      for k, v in pairs(t) do
        local existing = result[k]

        if type(existing) == 'table' and type(v) == 'table' then
          -- Check if both are lists (array-like tables)
          local is_list = vim.islist or vim.tbl_islist
          if is_list(existing) and is_list(v) then
            -- Extend the list
            local new_list = vim.list_extend({}, existing)
            vim.list_extend(new_list, v)
            result[k] = new_list
          else
            -- Recurse for maps or mixed tables
            result[k] = M.deep_extend(existing, v)
          end
        else
          -- Overwrite (equivalent to 'force' behavior)
          if type(v) == 'table' then
            result[k] = vim.deepcopy(v)
          else
            result[k] = v
          end
        end
      end
    end
  end

  return result
end

--- Setup auto-formatting for specific files
---@param pattern string|table Glob pattern(s) to match files (e.g. "*.lua")
function M.auto_format(pattern)
  -- Create a unique group for this pattern to prevent duplicates
  local group_name = 'AutoFormat_'
    .. (type(pattern) == 'table' and table.concat(pattern, '_') or pattern)
  local group = vim.api.nvim_create_augroup(group_name, { clear = true })

  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    pattern = pattern,
    callback = function(args)
      local ok, conform = pcall(require, 'conform')
      if ok then
        conform.format({ bufnr = args.buf, lsp_fallback = true, timeout_ms = 2000 })
      else
        vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 2000 })
      end
    end,
  })
end

return M
