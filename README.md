# electron_ddc
Build Electron apps using the Dart Dev Compiler.

![Screenshot](screenshots/main.png)

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
https://github.com/thosakwe/electron_ddc <project-name>
cd <project-name>
pub get
npm install
```

Afterwards, run `npm run watch` to start developing.

## Building
To build for production, all you need to do is run `npm build`.
The output directory, `build/web/` contains a `package.json` pointing to the built
application, and can be run as follows:

```bash
cd build/web
npm install
npm start
```