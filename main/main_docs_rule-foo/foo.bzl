def _foo_binary_impl(ctx):
    #Discoverable only with cquery
    print("Analyzing", ctx.label)
    print(type(ctx.file.username))

    out = ctx.actions.declare_file(ctx.label.name)
    ctx.actions.write(
        output = out,
        content = "Hello {}!".format(ctx.file.username),
    )

    return DefaultInfo(files = depset([out]))

foo_binary = rule(
    implementation = _foo_binary_impl,
    attrs = {
        "username": attr.label(
            allow_single_file = True,
        ),
    }
)

print("bzl file evaluation")