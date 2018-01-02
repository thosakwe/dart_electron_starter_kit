import 'dart:async';
import 'dart:html';
import 'package:string_scanner/string_scanner.dart' deferred as string_scanner;

void main() {
  var h1 = new Element.tag('h1')..text = 'Running DDC within Electron!';
  var i = new Element.tag('i')..text = 'Boldly go where no Dartisan has gone before.';
  document.body.children.addAll([h1, i]);

  string_scanner.loadLibrary().then((_) {
    var scanner = new string_scanner.StringScanner('hello world');
    scanner.expect('hello');
    print(scanner.lastMatch.pattern);
  });

  new Timer(const Duration(seconds: 2), () {
    print('Hello, dart:async!');
  });
}
