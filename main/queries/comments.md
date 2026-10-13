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
@@platforms//os:os
@@platforms//os:windows
@rules_python//command_line_option:enable_runfiles
@rules_python//python:none
@rules_python//python/private:sentinel
```

Note some of them still go through like for the OS and runfiles and sentinel.

This is actually a great opportunity to demonstrate `somepath()`
In situations where we don't see what's connecting two targets we can use `somepath()`

```bash
bazel query 'somepath(//cafe:main, @rules_python//python/private:sentinel)'
//cafe:main
@rules_python//python/private:uncachable_version_file <--- This is the connector target
@rules_python//python/private:sentinel
```

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

### Using the action query.
Action queries or `aquery` for short is very useful if we want to inspect a target in the POST-analysis phase.
**Note** `aquery` outputs a wall of artifacts, which I usually disable:

```bash
bazel aquery //ingredients:milk --noinclude_artifacts

INFO: Analyzed target //ingredients:milk (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
action 'Python precompiling bin/python3 into ingredients/__pycache__/milk.cpython-314.pyc'
  Mnemonic: PyCompile
  Target: //ingredients:milk
  Configuration: k8-fastbuild
  Execution platform: @@platforms//host:host
  ActionKey: ################################################################
  Environment: [PYTHONHASHSEED=0, PYTHONNOUSERSITE=1, PYTHONSAFEPATH=1]
  Command Line: (exec external/rules_python++python+python_3_14_x86_64-unknown-linux-gnu/bin/python3 \
    bazel-out/k8-opt-exec/bin/external/rules_python+/tools/precompiler/precompiler_.py \
    --invalidation_mode \
    checked_hash \
    --src \
    ingredients/milk.py \
    --src_name \
    ingredients/milk.py \
    --pyc \
    bazel-out/k8-fastbuild/bin/ingredients/__pycache__/milk.cpython-314.pyc \
    --optimize \
    0 \
    --python_version \
    3.14)
    ...
```
