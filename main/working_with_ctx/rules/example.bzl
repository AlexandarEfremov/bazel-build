def _create_directory(ctx):
    return_data = []
    out = ctx.actions.declare_directory(ctx.label.name + "_dir")
    return_data.append(out)

    for file in ctx.attr.files:
        current_file = ctx.actions.declare_file(file)
        ctx.actions.write(
            output = current_file,
            content = "This is {file}".format(file = file)
        )
        return_data.append(current_file)

    
    ctx.actions.run_shell(
        outputs = [out],
        command = "",
    )

    return DefaultInfo(files = depset(return_data))

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