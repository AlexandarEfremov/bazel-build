def _create_directory(ctx):
    # label name is taken directly from the name of the target
    out = ctx.actions.declare_directory(ctx.label.name + "_dir")
    script = ctx.actions.declare_file(ctx.label.name + ".sh")
    cmds = "mkdir -p {dirname}".format(dirname = out.path)

    ctx.actions.write(
        output = script,
        content = cmds,
    )

    # All code examples ive seen use 'run' I havent seen a single declare dir done
    # with run_shell. It kind of defeats the purpose because inputs and outputs are 
    # basically the same
    ctx.actions.run(
        executable = script,
        outputs = [out],
    )
    return [DefaultInfo(files = depset([out]))]


create_directory = rule(
    implementation = _create_directory,
)

# TODO tidy up and create comments.md
# TODO extend to use files (explore how they can be dynamically passed to depset)
# TODO experiment with labels
# TODO experiment with nested folder structures