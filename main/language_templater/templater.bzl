def _language_templater_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name + "_templated.txt")
    ctx.actions.expand_template(
        output = out,
        template = ctx.file.template,
        substitutions = {
            "{NAME}": ctx.attr.username,
            "{TIME}": ctx.attr.time,
        }
    )

    return DefaultInfo(files = depset([out]))

lang_templater = rule(
    implementation = _language_templater_impl,
    attrs = {
        "username": attr.string(
            default = "N/A"
        ),
        "time": attr.string(
            default = "N/A",
        ),
        "template": attr.label(
            allow_single_file = True,
            mandatory = False,
            default = "//templates:generic.txt",
        )
    }
)
