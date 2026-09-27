def _shell_script_impl(ctx):
    output_file = ctx.actions.declare_file(ctx.label.name + ".sh")
    script_content = """#!/bin/bash
printf '\n\n\t\tThis is my executable script output. Hope you liked it :D\n\n'
"""
    # The shell command must be typed this way otherwise it's going to be offside.
    ctx.actions.write(
        output = output_file,
        content = script_content,
    )

    return [
        DefaultInfo(
            executable = output_file
            # using 'files` here won't work if we want to run with 'bazel run //...'
        )
    ]


generate_shell_script = rule(
    implementation = _shell_script_impl,
    executable = True,
)