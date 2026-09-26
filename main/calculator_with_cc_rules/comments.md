## Breakdown
The following calculator examples shows how libs can be created and used in binaries.
The native `cc_library` rule produces always `.so` and `.a` files for linking.

```bash
├── libadd.a
├── libadd.a-0.params
├── libadd.so
├── libadd.so-0.params
└── _objs
    └── add
        ├── addition.pic.d
        └── addition.pic.o
```

To be more specific in execution we can use `cc_shared_library` or `cc_static_library`.

**Note** about `srcs` vs `hdrs`. As far as the bazel docs go whenever headers are directly
included in source code we can place them in `srcs`.

## Run
Build and execute your binary:

```bash
bazel build //...

./my_calculator
```

**Some examples**
```bash
Enter two integer numbers: 4 5
Enter an operation (+ - / *): /
4 / 5 = 0.8

Enter two integer numbers: 4 0
Enter an operation (+ - / *): /
4 / 0 = Cannot divide by 0

Enter two integer numbers: 1 8
Enter an operation (+ - / *): -
1 - 8 = -7
```
