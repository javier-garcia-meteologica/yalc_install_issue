This repository reproduces a bug in yalc.

https://github.com/wclr/yalc/issues/154

# 1. Build dependencies and publish to yalc

### Automatic

```bash
bash prepare.sh
```

### Manually

Build "chalk" and publish to both `/tmp` and yalc

```bash
cd chalk
npm i
npm pack
mv chalk-4.1.0.tgz /tmp
yalc publish
```

Build "dep2" and publish to both `/tmp` and yalc

```bash
cd dep2
npm i
npm pack
mv deps-dep2-0.0.1.tgz /tmp
yalc publish
```

Build "dep1" and publish to both `/tmp` and yalc

```bash
cd dep1
npm i
npm pack
mv deps-dep1-0.0.1.tgz /tmp
yalc publish
```

Build "project"

```bash
cd project
rm -r .yalc yalc.lock node_modules package-lock.json # Clean environment
npm i
```

It should install all packages successfully, the same as if the packages came from the registry.

# 2. Inject yalc dependencies

Now let's inject yalc dependencies

```bash
cd project
yalc add @deps/dep1 @deps/dep2
npm i
```

The error message that you'll see is non-deterministic, you may see:

```
npm WARN package@0.0.1 No description
npm WARN package@0.0.1 No repository field.

npm ERR! code ENOENT
npm ERR! syscall access
npm ERR! path /home/user/yalc_install_issue/project/.yalc/@deps/dep1/node_modules/tslib
npm ERR! errno -2
npm ERR! enoent ENOENT: no such file or directory, access '/home/user/yalc_install_issue/proj
ect/.yalc/@deps/dep1/node_modules/tslib'
npm ERR! enoent This is related to npm not being able to find a file.
npm ERR! enoent
```

or a reference to the "lint" and "build" scripts declared in the dependencies, indicating that execution of these scripts have failed.

```
> @deps/dep1@0.0.1 prepack /home/user/yalc_install_issue/project/.yalc/@deps/dep1
> npm run build



> @deps/dep1@0.0.1 prebuild /home/user/yalc_install_issue/project/.yalc/@deps/dep1
> npm run lint -- --quiet --cache


> @deps/dep1@0.0.1 lint /home/user/yalc_install_issue/project/.yalc/@deps/dep1
> eslint --ext=.js,.ts src "--quiet" "--cache"


Oops! Something went wrong! :(

ESLint: 7.14.0

No files matching the pattern "src" were found.
Please check for typing mistakes in the pattern.

npm ERR! code ELIFECYCLE
npm ERR! errno 2
npm ERR! @deps/dep1@0.0.1 lint: `eslint --ext=.js,.ts src "--quiet" "--cache"`
npm ERR! Exit status 2
npm ERR!
npm ERR! Failed at the @deps/dep1@0.0.1 lint script.
npm ERR! This is probably not a problem with npm. There is likely additional logging output above.

npm ERR! A complete log of this run can be found in:
npm ERR!     /home/user/.npm/_logs/2021-01-21T15_33_59_640Z-debug.log
npm ERR! code ELIFECYCLE
npm ERR! errno 2
npm ERR! @deps/dep1@0.0.1 prebuild: `npm run lint -- --quiet --cache`
npm ERR! Exit status 2
npm ERR!
npm ERR! Failed at the @deps/dep1@0.0.1 prebuild script.
npm ERR! This is probably not a problem with npm. There is likely additional logging output above.
```
