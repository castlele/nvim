---@class EditorActionsModule
local M = {}

local function assertCompletionEngine(engine)
   assert(engine.type, "You have to provide `type` property for engine to be able to understand what completion engine is used")

   if engine.type ~= "cmp" then
      vim.notify(string.format("Engine type %s isn't supported yet", engine.type), vim.log.levels.WARN)
   end
end

function M.goToDeclaration(opts)
   vim.lsp.buf.declaration(opts)
end

function M.goToDefinition(opts)
   vim.lsp.buf.definition(opts)
end

function M.goToReferences(context, opts)
   vim.lsp.buf.references(context, opts)
end

function M.showHelp(config)
   vim.lsp.buf.hover(config)
end

function M.rename(new_name, opts)
   vim.lsp.buf.rename(new_name, opts)
end

function M.showDiagnostics(opts, ...)
   vim.diagnostic.open_float(opts, ...)
end

function M.showSignatureHelp(config)
   vim.lsp.buf.signature_help(config)
end

---@param engine table completion engine
---@return fun()
function M.activateCompletions(engine)
   assertCompletionEngine(engine)

   return engine.mapping.complete()
end

---@param engine table completion engine
---@return fun()
function M.confirmCompletionSelection(engine)
   assertCompletionEngine(engine)

   return engine.mapping.confirm { select = true }
end

---@param engine LuaSnip snippet engine
---@return fun()
function M.moveNextArg(engine)
   return function ()
      if engine.expand_or_jumpable() then
         engine.expand_or_jump()
      end
   end
end

---@param engine LuaSnip snippet engine
---@return fun()
function M.movePrevArg(engine)
   return function ()
      if engine.jumpable(-1) then
         engine.jump(-1)
      end
   end
end

return M
