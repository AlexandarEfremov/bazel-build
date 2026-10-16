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

def _extract_from_tarball(ctx):
    src = ctx.file.src
    ctx.file.src.basename
    # out = ctx.actions.declare_file(sr)

extract_from_tarball = rule(
    implementation = _extract_from_tarball,
    attrs = {
        "src": attr.label(allow_single_file = True),
    }
)

# TODO 3 research attr.output this is a major help towards sliming down custom rules