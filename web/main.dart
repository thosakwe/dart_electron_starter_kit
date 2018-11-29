import 'dart:html';
import 'package:app/interop.dart';
import 'package:node_interop/node.dart' hide require;
import 'package:node_interop/path.dart';

void main() {
  var p = require<Path>('path');
  window
    ..console.info(p.join(process.cwd(), 'foo', 'bar'))
    ..alert('Hello, Dart! Electron version: ${process.version}');
}
