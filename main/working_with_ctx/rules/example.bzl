def _create_directory(ctx):
    out = ctx.actions.declare_directory(ctx.label.name + "_dir")
    file_array = ''
    out_files = []

    # TODO finish script so that the files can be moved in the directory
    # TODO clean up
    for file in ctx.attr.files:
        out_file = ctx.actions.declare_file(file.replace(".txt", ".out"))
        ctx.actions.write(
            output = out_file,
            content = "This is {file}".format(file = file)
        )
        out_files.append(out_file)

    ctx.actions.run_shell(
        outputs = [out],
        command = "mkdir -p {dirname}".format(dirname = out.path),
    )
    
    # depset has to be passed the list of outputs, were I to pass [output, [something]]
    # it would fail as it's mutable

    out_files.append(out)
    return [DefaultInfo(files = depset(out_files))]


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