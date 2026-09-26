def _greet_impl(ctx):
    # Different filenames need to be declared for different people, so the 'person'
    # attribute is used as part of the naming.
    output = ctx.actions.declare_file(
        "greeting-{}.txt".format((ctx.attr.person).lower())
    )

    ctx.actions.write(
        output = output,
        content = "Hi there, {}!\n".format(ctx.attr.person)
    )

    return [
        DefaultInfo(
            # Using depsets avoids situations with quadratic copying
            files = depset([output])
        )
    ]

greet = rule(
    implementation = _greet_impl,
    attrs = {
        "person": attr.string(default = "unknown"),
        # https://bazel.build/rules/lib/toplevel/attr#string
        # If we want to force a 'person' to be passed as an arg we can enable 'mandatory = True'
    }
)