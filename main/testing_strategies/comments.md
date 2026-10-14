## Observation
Not that if I don't have `tags = ["external"]` for the py_test bazel will automatically
cache the result for me - provided it's passing.

```bash
INFO: Build completed successfully, 2 total actions
//:person_unit_tests                                            (cached) PASSED in 0.6s
//:unit_test                                                             PASSED in 0.1s
```

Obviously if I add the tag I will force a clean test rerun, regardless if it passed or 
not.

**tags = ["manual"]** 
Simply removes the test from being executed by `bazel test //...`. It does NOT however 
hide it from `bazel query //...`