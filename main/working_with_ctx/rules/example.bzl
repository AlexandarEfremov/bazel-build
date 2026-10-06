def _create_directory(ctx):
    out = ctx.actions.declare_directory(ctx.label.name + "_dir")
    args = ctx.actions.args()

    for file in ctx.attr.files:
        args.add(file)

    ctx.actions.run_shell(
        outputs = [out],
        arguments = [args],
        command = "for arg in $@; do touch {dir}/$arg ; done".format(dir = out.path),
    )

    return DefaultInfo(files = depset([out]))

create_directory = rule(
    implementation = _create_directory,
    attrs = {
        "files": attr.string_list(
            mandatory = False,
            doc = "List of string file(s). Can be empty."
        )
    }
)

# TODO extend to use files (explore how they can be dynamically passed to depset)
# TODO explore the string members https://bazel.build/rules/lib/core/string#attr
# TODO experiment with labels
# TODO experiment with nested folder structures