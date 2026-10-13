## Queries
I'm mixing these from the official bazel docs and others I found online.

### Show everything
```bash
bazel query --noimplicit_deps 'deps(//cafe:main)'

//cafe:main
//cafe:main.py
//coffee_types:americano
//coffee_types:americano.py
//coffee_types:cappuccino
//coffee_types:cappuccino.py
//customers:Alex
//customers:Ewcia
//customers:alex.py
//customers:ewcia.py
//ingredients:arabica_beans
//ingredients:arabica_beans.py
//ingredients:ethiopian_beans
//ingredients:ethiopian_beans.py
//ingredients:milk
//ingredients:milk.py
@bazel_tools//src/conditions:windows
@bazel_tools//src/main/cpp/util:blaze_exit_code
@bazel_tools//src/main/cpp/util:errors
@bazel_tools//src/main/cpp/util:errors.h
@bazel_tools//src/main/cpp/util:errors_posix.cc
@bazel_tools//src/main/cpp/util:errors_windows.cc
@bazel_tools//src/main/cpp/util:exit_code.h
```

As you can see this shows everything plus others that we never defined in deps. Those are implicit ones.
They can be removed with:

```bash
bazel query --noimplicit_deps 'deps(//cafe:main)'
//cafe:main
//cafe:main.py
//coffee_types:americano
//coffee_types:americano.py
//coffee_types:cappuccino
//coffee_types:cappuccino.py
//customers:Alex
//customers:Ewcia
//customers:alex.py
//customers:ewcia.py
//ingredients:arabica_beans
//ingredients:arabica_beans.py
//ingredients:ethiopian_beans
//ingredients:ethiopian_beans.py
//ingredients:milk
//ingredients:milk.py
```

Note some of them still go through like for the OS and runfiles.

### Targets that depend on another target (reverse dependency)
Let's say we want to find out how many other targets are using our arabica beans.

```bash
bazel query 'rdeps(//..., //ingredients:arabica_beans)'
//cafe:main
//coffee_types:americano
//ingredients:arabica_beans
```
So not counting itself we have 2 other targets that have a dependency to `arabica_beans`

### Find targets by using specific attributes (tags)
We have two customers that like drinking `Cappuccino`, but what if there are hundreds?

```bash
bazel query 'attr(tags, "Cappuccino", //customers/...)'
//customers:Ewcia
//customers:Ron
```

With this query we can print out everyone using the specified `tags` attribute.