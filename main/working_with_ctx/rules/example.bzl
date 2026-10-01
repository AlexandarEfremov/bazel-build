def _create_directory(ctx):
    out = ctx.actions.declare_directory(ctx.attr.dirname + "_dir")
    print(out)

    # ctx.actions.run_shell(
    #     outputs = [outputs],
    #     command = "mkdir {dir} && echo {dir}_dir was successfully created".format(dir = ctx.attr.dirname),
    # )

    ctx.actions.run_shell(
        inputs = 
        outputs = [out],
        command = "mkdir -p {dir} && touch {dir}/first_file.txt".format(dir = ctx.attr.dirname)
    )
    # ctx.actions.run(
    #     executable = "bash",
    #     arguments = ["-c", "mkdir -p %s/pear && touch %s/pear/grape" % (out.path, out.path)],
    #     outputs = [out],
    # )
    return [
        DefaultInfo(
            files = depset([out]),
        ),
    ]

create_directory = rule(
    implementation = _create_directory,
    attrs = {
        "dirname": attr.string(
            mandatory = True,
            doc = "The name of the directory"
        ),
    }
)