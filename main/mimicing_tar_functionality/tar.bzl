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

def _read_tarball(ctx):
    src = ctx.file.src #results.tar
    output_dir = ctx.actions.declare_directory("out_tar")
    args = ctx.actions.args()

    args.add("-tvf")
    args.add(src)

    ctx.actions.run(
        executable = "tar",
        arguments = [args],
        inputs = [src],
        outputs = [output_dir],
        use_default_shell_env = True,
    )

    return DefaultInfo(files = depset([output_dir]))

read_tarball = rule(
    implementation = _read_tarball,
    attrs = {
        "src": attr.label(allow_single_file = True),
    }
)
