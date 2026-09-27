## Run
Executable scripts can be directly started with the following command:

```bash
bazel run //...
```

In our example we have two potential points of failure:
- Returning a non executable:

```python
return [
    DefaultInfo(
        files = depset([output_file]),
    )
]
```

- Failing to define that the rule output is executable:

```python
generate_shell_script = rule(
    implementation = _shell_script_impl,
)
```

**Note** There seems to be a weird quirk that I don't fully understand which is that
when you compile a target as non executable bazel-bin still lists it as a file that
can be executed:

```bash
-r-xr-xr-x 1 alex alex 85 Sep 27 20:28 bazel-bin/my_gen_script.sh
```

The file can indeed be executed if you run it manually. It only fails if you try
`bazel run`.

```bash
ERROR: Cannot run target //:my_gen_script: Not executable
```
