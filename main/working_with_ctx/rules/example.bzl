def _create_directory(ctx):
    out = ctx.actions.declare_directory(ctx.label.name + "_dir")

    ctx.actions.run_shell(
        outputs = [out],
        command = "mkdir -p {dirname}".format(dirname = out.path),
    )
    return [DefaultInfo(files = depset([out]))]


create_directory = rule(
    implementation = _create_directory,
)

# TODO extend to use files (explore how they can be dynamically passed to depset)
# TODO experiment with labels
# TODO experiment with nested folder structures