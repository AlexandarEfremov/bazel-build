def _create_directory(ctx):
    output_dir = ctx.actions.declare_directory(ctx.attr.directory_name + "_dir")
    dir_path = output_dir.path

    args = ctx.actions.args()
    all_files = []

    for file in ctx.attr.files:
        current_file = ctx.actions.declare_file(file)
        ctx.actions.write(
            output = current_file,
            content = "Nada",
        )

        all_files.append(current_file)

    ctx.actions.run_shell(
        outputs = [output_dir],
        arguments = [args],
        command = "echo HI",
    )

    return DefaultInfo(
        files = depset([all_files])
    )

create_directory = rule(
    implementation = _create_directory,
    attrs = {
        "directory_name": attr.string(),
        "files": attr.string_list(),
    }
)