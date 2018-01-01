# electron_ddc_boilerplate
Build Electron apps using the Dart Dev Compiler. **Very experimental.**

## About
This package uses `package:build_web_compilers` and the DDC to compile a Dart app to JS on-the-fly,
without having to go through `pub serve`. 

`package:build`'s design gives this a much faster edit-refresh cycle than serving via `pub serve`.

Now, you can write your Electron app with Dart, leveraging exist interop libraries like
`package:node` and `package:electron`.

## Setup
Assuming you have both NPM and the Dart SDK installed, setup is simple:

```bash
# MUST be run in this order!!!
pub get
npm i
```

Afterwards, run `npm run watch` to start developing.