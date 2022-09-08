(call
    function: (identifier) @name (#eq? @name "print")
    arguments: (argument_list "(" (_) @print.inner ")")
) @print.outer

(assignment
    left: (identifier) @assignment.left
    right: (_) @assignment.right
) @assignment.outer
