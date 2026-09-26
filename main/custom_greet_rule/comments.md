## Build
To build all three targets execute:

```bash
bazel build //...
```

This will produce in your `bazel-bin` the following output:

```bash
bazel-bin/
├── greeting-alex.txt
├── greeting-james.txt
└── greeting-unknown.txt
```

The contents are the following:

```bash
$ for file in bazel-bin/*; do cat $file; done
Hi there, Alex!
Hi there, James!
Hi there, Unknown!
```

As we can see bazel used the 'person' attr where it could and defaulted to 'Unknown' where it wasn't provided.