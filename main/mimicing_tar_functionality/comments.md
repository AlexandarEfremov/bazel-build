## Observations
When using `label` and `output` you effectively receive ready made File objects and don't
need to declare them. This reduces the boilerplate quite a bit.

Trying to declare a file as a `attr.string()` simply doesn't work. I believe this is 
because it's not recognized in the bazel build graph.

### Converting strings to Files
This works however you later need a generating action to complete the action, but this
logically is not correct if you already have the source file.