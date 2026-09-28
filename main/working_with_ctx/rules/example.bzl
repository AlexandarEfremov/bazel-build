def _mish_mash_impl(ctx):
    output_file = ctx.actions.declare_file("Mish")
    output_file_two = ctx.actions.declare_file("Mosh")
    output_dir = ctx.actions.declare_directory("Mash")

    ctx.actions.write(
        output = output_file,
        content = "Cheese & Tomatoes"
    )

    ctx.actions.write(
        output = output_file_two,
        content = "Mac & Cheese"
    )

    # WIP

    my_files = ctx.actions.args()
    my_files.add_all(depset([output_file, output_file_two]))
    ctx.actions.write(
        output = output_dir,
        content = my_files
    )

    return DefaultInfo(
        files = depset([output_file, output_dir])
    )

mish_mash = rule(
    implementation = _mish_mash_impl
)