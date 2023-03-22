return {
    "Vimjas/vim-python-pep8-indent",
    -- ft = "python",
    event = "InsertEnter *.py",
    config = function()
        --[[
        This defaults to 0, which means that multiline strings are not indented.
        -1 and positive values will be used as-is, where -1 is a special value for Vim's indentexpr, and will keep the existing indent (using Vim's autoindent setting).
        -2 is meant to be used for strings that are wrapped with textwrap.dedent etc.
        It will add a level of indentation if the multiline string started in the previous line

        Without any content in it already:
            testdir.makeconftest("""
                _

        With content already, it will be aligned to the opening parenthesis:
            testdir.makeconftest("""def pytest_addoption(parser):
                        _
            ]]
        vim.g.python_pep8_indent_multiline_string = 0

        --[[
        By default (set to 0), closing brackets line up with the opening line:
            my_list = [
                1, 2, 3,
                4, 5, 6,
            ]
            result = some_function_that_takes_arguments(
                'a', 'b', 'c',
                'd', 'e', 'f',
            )

        With python_pep8_indent_hang_closing = 1, closing brackets line up with the items:
            my_list = [
                1, 2, 3,
                4, 5, 6,
                ]
            result = some_function_that_takes_arguments(
                'a', 'b', 'c',
                'd', 'e', 'f',
                )
        ]]
        vim.g.python_pep8_indent_hang_closing = 0
    end,
}
