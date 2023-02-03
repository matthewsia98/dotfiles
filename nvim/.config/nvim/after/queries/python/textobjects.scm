;extends

(call
    function: (identifier) @name (#eq? @name "print")
    arguments: (argument_list "(" (_) @print.inner ")")
) @print.outer

(assignment
    left: (identifier) @assignment.left
    right: (_) @assignment.right
) @assignment.outer

(call
    function: (identifier)
    arguments: (argument_list
        (_) @argument.inner
    )
)

(string) @string.outer

((string) @string.inner (#offset! @string.inner 0 1 0 -1))
