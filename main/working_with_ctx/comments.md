## Notes
The current configuration is an improvement over `ctx.actions.run` as we can completely drop the `.sh` script generation as well as the `write` action. 

### Generating the name
Although we could specifically create an attribute to enter a name, this will make the source slighly more verbose, plus we can't actually use the word `name` as it's reserved for the target.

That's why a better way is to directly reference the `label.name`.

### Observations
I noticed that most code examples use `ctx.actions.run` when working with directory creation, but in the majority of those cases the authors were executing complicated additional scripts. I tend to prefer this minimal style.

## Generating files inside the folder
Currently this is the only way I managed to create files and place them in the folder, although I'm not satisfied with this approach. For one the files are invisible for the bazel graph and are generated as a side effect.

Also this doesn't allow me to write content in them. Will revisit if I stumble upon a more elegant solution.