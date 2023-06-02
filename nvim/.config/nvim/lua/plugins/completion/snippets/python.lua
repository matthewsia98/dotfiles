local ls = require("luasnip")
local e = require("luasnip.extras")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local l = e.lambda
local dl = e.dynamic_lambda
local sn = ls.sn
local rep = e.rep

local utils = require("plugins.completion.snippets.utils")

return {
    s(
        {
            trig = "([%a_]+)%+%+",
            regTrig = true,
            snippetType = "autosnippet",
            dscr = "i++",
        },
        f(function(_, snip)
            return snip.captures[1] .. " += 1"
        end)
    ),
    s(
        {
            trig = "([%a_]+)%-%-",
            regTrig = true,
            snippetType = "autosnippet",
            dscr = "i--",
        },
        f(function(_, snip)
            return snip.captures[1] .. " -= 1"
        end)
    ),
    s(
        {
            trig = "printn",
            snippetType = "autosnippet",
        },
        fmt([[print({}, "\n")]], {
            i(1, ""),
        })
    ),
    s(
        {
            trig = "printf",
            snippetType = "autosnippet",
        },
        fmt([[print(f"{}{{{}}}{}")]], {
            i(1, ""),
            i(2, ""),
            i(3, ""),
        })
    ),
    s(
        {
            trig = "def ",
            -- snippetType = "autosnippet",
            condition = utils.expand_node,
        },
        fmt(
            [[
        def {}({}):
            {}
        ]],
            {
                i(1, "function_name"),
                i(2, "args"),
                i(3, "pass"),
            }
        )
    ),

    s(
        { trig = "mydef" },
        fmt(
            [[
            def {}({}){}:{}
                {}
                {}
            ]],
            {
                c(1, {
                    sn(nil, {
                        i(1, "function_name"),
                    }),
                    t(""),
                }),
                i(2, "args"),
                c(3, {
                    sn(nil, {
                        t(" -> "),
                        i(1, "None"),
                    }),
                    t(""),
                }),
                c(4, {
                    d(nil, function(args)
                        local splits = vim.split(args[1][1], ", ")
                        local inserted_args_header = false
                        local inserted_kwargs_header = false
                        local texts = { "" }
                        table.insert(texts, '\t"""')
                        for _, split in ipairs(splits) do
                            if #split > 0 then
                                local is_kwarg = split:match("=")
                                if not inserted_kwargs_header and is_kwarg then
                                    if inserted_args_header then
                                        table.insert(texts, "")
                                    end
                                    table.insert(texts, "\tKwargs:")
                                    inserted_kwargs_header = true
                                elseif not inserted_args_header and not is_kwarg then
                                    table.insert(texts, "\tArgs:")
                                    inserted_args_header = true
                                end

                                local matches = split:gmatch([[([%w_'"]+)]])
                                local idx = 1
                                local name = ""
                                local type = ""
                                local default = ""
                                for match in matches do
                                    if idx == 1 then
                                        -- variable name
                                        name = match
                                    elseif idx == 2 then
                                        -- variable type
                                        type = match
                                    elseif idx == 3 then
                                        -- variable default
                                        default = match
                                    end
                                    idx = idx + 1
                                end

                                if #default > 0 then
                                    table.insert(texts, "        " .. name .. " (" .. type .. "):")
                                    table.insert(texts, "            " .. "Default value = " .. default)
                                elseif #type > 0 then
                                    table.insert(texts, "        " .. name .. " (" .. type .. "):")
                                else
                                    if name ~= "self" then
                                        table.insert(texts, "        " .. name .. ":")
                                    end
                                end
                            end
                        end

                        if #args[2][1] > 0 then
                            -- Return type specified
                            local return_type = args[2][1]:gsub(" %-> ", "")
                            -- return_type = return_type:match('([%s%w%[%]%,]+)')

                            if #return_type > 0 then
                                table.insert(texts, "")
                                table.insert(texts, "    Returns:")
                                table.insert(texts, "        " .. return_type)
                            end
                        end
                        table.insert(texts, '    """')

                        return sn(nil, {
                            t(texts),
                            i(1),
                        })
                    end, { 2, 3 }),
                    t(""),
                }),
                i(5, "# Function Body"),
                c(6, {
                    d(nil, function(args)
                        local text = args[1][1]
                        local return_type = text:gsub(" %-> ", "")
                        local return_value = "None"

                        if #return_type > 0 then
                            if return_type == "int" then
                                return_value = "-1"
                            elseif return_type == "str" then
                                return_value = '""'
                            elseif return_type:match("list") then
                                return_value = "[]"
                            elseif return_type:match("dict") then
                                return_value = "{}"
                            elseif return_type:match("set") then
                                return_value = "set()"
                            end

                            return sn(nil, {
                                t("return "),
                                i(1, return_value),
                            })
                        else
                            return sn(nil, {
                                t(""),
                            })
                        end
                    end, { 3 }),
                    -- sn(nil, {
                    --     t('return '),
                    --     i(1, 'None')
                    -- }),
                    t(""),
                }),
            }
        )
    ),
    s(
        { trig = "myclass" },
        fmt(
            [[
            class {}{}:
                """
                {}
                """
                def __init__(self, {}):
                    {}
            ]],
            {
                i(1, "ClassName"),
                c(2, {
                    sn(nil, {
                        t("("),
                        i(1, "BaseClass"),
                        t(")"),
                    }),
                    t(""),
                }),
                dl(3, "Docstring for " .. l._1, 1),
                i(4, "args"),
                d(5, function(args)
                    local splits = vim.split(args[1][1], ", ")
                    local texts = {}
                    for idx, split in ipairs(splits) do
                        split = split:match("([%w_]*)=?")
                        local curr
                        if idx == 1 then
                            curr = "self." .. split .. " = " .. split
                        else
                            curr = "        self." .. split .. " = " .. split
                        end
                        table.insert(texts, curr)
                    end
                    return sn(nil, t(texts))
                end, { 4 }),
            }
        )
    ),
    s(
        { trig = "myinit" },
        fmt(
            [[
            def __init__(self, {}):
                {}
            ]],
            {
                i(1, "args"),
                d(2, function(args)
                    local splits = vim.split(args[1][1], ", ")
                    local texts = {}
                    for idx, split in ipairs(splits) do
                        split = split:match("([%w_]*)=?")
                        local curr
                        if idx == 1 then
                            curr = "self." .. split .. " = " .. split
                        else
                            curr = "    self." .. split .. " = " .. split
                        end
                        table.insert(texts, curr)
                    end
                    return sn(nil, t(texts))
                end, { 1 }),
            }
        )
    ),
    s(
        { trig = "pd_groupby" },
        fmt([[{}.groupby([{}]{}{}).{}]], {
            i(1, "df"),
            i(2, "column"),
            c(3, {
                sn(nil, {
                    t(", as_index="),
                    i(1, "False"),
                }),
                t(""),
            }),
            c(4, {
                t(", axis='index'"),
                t(", axis='columns'"),
                t(""),
            }),
            c(5, {
                sn(nil, {
                    t("apply("),
                    i(1, "function"),
                    t(")"),
                }),
                t(""),
            }),
        })
    ),
    s(
        { trig = "pd_apply" },
        fmt([[{}{}.apply({}{})]], {
            i(1, "df"),
            c(2, {
                sn(nil, {
                    t("["),
                    i(1, "column"),
                    t("]"),
                }),
                t(""),
            }),
            c(3, {
                sn(nil, {
                    t("lambda "),
                    i(1, "x"),
                    t(": "),
                    i(2),
                }),
                t(""),
            }),
            c(4, {
                t(", axis='index'"),
                t(", axis='columns'"),
                t(""),
            }),
        })
    ),
    s(
        { trig = "torch_imports" },
        t({
            "import torch",
            "import torch.nn as nn",
            "import torch.nn.functional as F",
            "import torch.optim as optim",
            "",
            "from torch.utils.data import Dataset, DataLoader",
        })
    ),
    s(
        { trig = "torch_dataloader" },
        fmt([[{} = DataLoader({}, batch_size={}{}{}{}{}){}]], {
            i(1, "dataloader"),
            i(2, "dataset"),
            i(3, "BatchSize"),
            c(4, {
                sn(nil, {
                    t(", shuffle="),
                    i(1, "True"),
                }),
                t(""),
            }),
            c(5, {
                sn(nil, {
                    t(", sampler="),
                    i(1, "sampler"),
                }),
                t(""),
            }),
            c(6, {
                sn(nil, {
                    t(", collate_fn="),
                    i(1, "sampler"),
                }),
                t(""),
            }),
            c(7, {
                sn(nil, {
                    t(", num_workers="),
                    i(1, "sampler"),
                }),
                t(""),
            }),
            i(0),
        })
    ),
    s(
        { trig = "torch_dataset" },
        fmt(
            [[
            class {}({}):
                def __init__(self, {}):
                    {}
                    {}
                    {}

                def __len__(self):
                    {}
                    return {}

                def __getitem__(self, idx):
                    {}
                    return {}
            ]],
            {
                i(1, "MyDataset"),
                i(2, "Dataset"),
                i(3, "args"),
                i(4, "# Before setting instance variables"),
                d(5, function(args)
                    local splits = vim.split(args[1][1], ", ")
                    local texts = {}
                    -- if #args[1][1] > 0 then
                    --     table.insert(texts, '')
                    -- end
                    for idx, split in ipairs(splits) do
                        split = split:match("([%w_]*)=?")
                        local curr
                        if idx == 1 then
                            curr = "self." .. split .. " = " .. split
                        else
                            curr = "        self." .. split .. " = " .. split
                        end
                        -- local curr = 'self.' .. split .. ' = ' .. split
                        table.insert(texts, curr)
                    end
                    -- table.insert(texts, '')
                    -- table.insert(texts, '')
                    return sn(nil, t(texts))
                end, { 3 }),
                i(6, "# After setting instance variables"),
                i(7, "# Before returning length"),
                i(8, "None"),
                i(9, "# Before returning item"),
                i(10, "None"),
            }
        )
    ),
    s(
        { trig = "torch_model" },
        fmt(
            [[
            class {}(nn.Module):
                def __init__(self{}):
                    super({}).__init__()
                    {}
            {}
                    {}

                def forward(self, {}):
                    {}

                    return {}
            ]],
            {
                i(1, "MyModel"),
                c(2, {
                    sn(nil, {
                        t(", "),
                        i(1, "args"),
                    }),
                    t(""),
                }),
                c(3, {
                    dl(nil, l._1 .. ", self", 1),
                    t(""),
                }),
                i(4, "# Before setting instance variables"),
                d(5, function(args)
                    local splits = vim.split(args[1][1], ", ")
                    local texts = {}
                    for idx, split in ipairs(splits) do
                        if idx > 1 then
                            split = split:match("([%w_]*)=?")
                            local curr = "        self." .. split .. " = " .. split
                            table.insert(texts, curr)
                        end
                    end

                    return sn(nil, t(texts))
                end, { 2 }),
                d(6, function()
                    return sn(nil, {
                        i(1, "# Layers"),
                    })
                end),
                i(7, "x"),
                d(8, function(args)
                    local x = args[2][1]
                    local indented = false
                    local texts = {}
                    for _, line in ipairs(args[1]) do
                        local match = line:match("(self[%s%w_%.]*)=?")
                        if match ~= nil then
                            match = string.gsub(match, "%s", "")
                            if #match > 0 then
                                local res = x .. " = " .. match .. "(" .. x .. ")"
                                if indented then
                                    res = "        " .. res
                                end
                                table.insert(texts, res)
                                indented = true
                            end
                        end
                    end

                    return sn(nil, {
                        t(texts),
                    })
                end, { 6, 7 }),
                rep(7),
            }
        )
    ),
    s(
        { trig = "torch_train" },
        fmt(
            [[
            for {} in {}:
                for {}, {} in enumerate({}):
                    {}.zero_grad()

                    {}

                    {} = {}({}, {})
                    {}.backward()
                    {}.step()
            ]],
            {
                i(1, "epoch"),
                d(2, function()
                    local imported_tqdm = false
                    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                    for _, line in ipairs(lines) do
                        if string.match(line, "import tqdm") then
                            imported_tqdm = true
                            break
                        end
                    end
                    if imported_tqdm then
                        return sn(nil, {
                            t("tqdm(range("),
                            i(1, "EPOCHS"),
                            t("))"),
                        })
                    else
                        return sn(nil, {
                            t("range("),
                            i(1, "EPOCHS"),
                            t(")"),
                        })
                    end
                end),
                i(3, "batch_num"),
                c(4, {
                    sn(nil, {
                        t("("),
                        i(1, "batch_Xs"),
                        t(", "),
                        i(2, "batch_ys"),
                        t(")"),
                    }),
                    i(1, "batch"),
                }),
                d(5, function()
                    local imported_tqdm = false
                    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                    for _, line in ipairs(lines) do
                        if string.match(line, "import tqdm") then
                            imported_tqdm = true
                            break
                        end
                    end
                    if imported_tqdm then
                        return sn(nil, {
                            t("tqdm("),
                            i(1, "dataloader"),
                            t(")"),
                        })
                    else
                        return sn(nil, {
                            i(1, "dataloader"),
                        })
                    end
                end),
                i(6, "optimizer"),
                i(7, "# Model Forward"),
                i(8, "loss"),
                i(9, "loss_function"),
                i(10, "outputs"),
                i(11, "batch_ys"),
                f(function(args)
                    return args[1][1]
                end, { 8 }),
                f(function(args)
                    return args[1][1]
                end, { 6 }),
            }
        )
    ),
}
