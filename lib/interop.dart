@JS()
library interop;

import 'package:js/js.dart';

@JS()
external Object _electronRequire(String path);

/// Require a Node package, or JavaScript file.
T require<T>(String path) => _electronRequire(path) as T;
