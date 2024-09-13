local barrun = {}

barrun.commands = {
    py = function(filepath) return "python3 "..filepath end,

    js = function(filepath) return "node "..filepath end,

    html = function(filepath) return "open "..filepath end,

    rs = function(filepath)
      local filename = string.match(filepath, "[^/]+$"):sub(1,-4)
      local filedir = filepath:sub(1, filepath:match(".+()/"))
      local dir_to_src = filedir:match("(.-)/src")
      if dir_to_src then

        local handle = io.popen("(cd "..dir_to_src.." && ls)")

        if handle then
          local is_cargo = string.find(handle:read("*a"), "Cargo.toml")
          handle:close()

          if is_cargo then
            return "(cd "..filedir.." && cargo run)"
          end
        end

      end

      return "(cd "..filedir.." && rustc "..filepath.." && ./"..filename..")"
    end,

    lua = function(filepath) return "lua "..filepath end,

    java = function(filepath)
      local filename = string.match(filepath, "[^/]+$"):sub(1,-6)
      local filedir = filepath:sub(1, filepath:match(".+()/"))
      return "(cd "..filedir.." && javac "..filepath.." && java "..filename..")"
    end,

    svelte = function(filepath)
      local filedir = filepath:sub(1, filepath:match(".+()/"))
      return "(cd "..filedir.." && npm run dev)"
    end,
}



function barrun:runfile(file)
  local filetype = file:match("%.([%w_]+)$")
  require("nvchad.term").runner {
      pos = "float",
      cmd = self.commands[filetype](file),
      id = "floatTerm",
      clear_cmd = false
  }
end


return barrun
