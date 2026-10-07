def _str_implementation(ctx):
   str_list = ctx.attr.strs
   elements = [e for e in str_list[2].elems()]
   print(str_list) #["first", "FIRST", "weIRd", "lazt"]
   print(elements) #["w", "e", "I", "R", "d"]

   space = "    "
   print("Nothing but space" if space.isspace() else "Text")
   print("Joined elements: {}".format("#".join(elements))) #w#e#I#R#d

   lstripped = str_list[1]
   print(lstripped.lstrip("F")) #IFRST -- Note: only the first one goes

   atg = str_list[4]
   print(atg.partition("the")) #("alexander", "the", "great")

   prefix = str_list[5]
   print(prefix.removeprefix("BUILD.")) #bazel

   suffix = str_list[5]
   print(suffix.removesuffix(".bazel")) #BUILD

   lazt = str_list[3]
   print(lazt.replace("z", "s")) #last

   spl = str_list[6]
   print(spl.split(".")) #["test", "if", "i", "can", "split", "this"]

string_members = rule(
    implementation = _str_implementation,
    attrs = {
        "strs": attr.string_list(),
    }
)