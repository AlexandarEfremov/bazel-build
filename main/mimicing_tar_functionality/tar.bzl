# tar -xvf <output> <input>

def _create_tarball(ctx):
    src = ctx.file.src
    out = ctx.outputs.out

    args = ctx.actions.args()
    args.add("-cvf")
    args.add(out)
    args.add_all([src])

    ctx.actions.run(
        executable = "tar",
        arguments = [args],
        inputs = [src],
        outputs = [out],
        use_default_shell_env = True,
    )

    return DefaultInfo(files = depset([out]))

create_tarball = rule(
    implementation = _create_tarball,
    attrs = {
        "src": attr.label(allow_single_file = True),
        "out": attr.output(mandatory = True),
    }
)

# TODO 1 add commentary explaining how file declarations could be dropped as they were
# only causing issues with generation requests i.e. no generating action for ...
# TODO 2 Explain the advantages of using labels (they create File object directly)
# TODO 3 research attr.output this is a major help towards sliming down custom rules

# What I believe is happening is that 'src' and 'out' are both implicitly declaring File
# objects hence why i dont need to do it manually at the same time they are perfectly 
# tied with my implementation and correctly resolve paths.