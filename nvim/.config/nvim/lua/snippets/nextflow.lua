local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- process block
  s("proc", fmt([[
    process {} {{
        input:
            {}

        output:
            {}

        script:
            """
            {}
            """
    }}
  ]], {
    i(1, "process_name"),
    i(2, "// input specification"),
    i(3, "// output specification"),
    i(4, "echo Hello World"),
  })),

  -- workflow block with take/main/emit
  s("wf", fmt([[
    workflow {} {{
        take:
            {}

        main:
            {}

        emit:
            {}
    }}
  ]], {
    i(1, "workflow_name"),
    i(2, "// input channels"),
    i(3, "// workflow logic"),
    i(4, "// output channels"),
  })),

  -- include statement
  s("inc", fmt([[include {{ {} }} from '{}']], {
    i(1, "function_name"),
    i(2, "module_name"),
  })),
}
