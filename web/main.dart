import 'dart:html';
import 'package:string_scanner/string_scanner.dart';

void main() {
  var scanner = new StringScanner('hello world');
  scanner.expect('hello');
  print(scanner.lastMatch.pattern);
  var h1 = new Element.tag('h1')..text = 'Running DDC within Electron!';
  var i = new Element.tag('i')..text = 'Boldly go where no Dartisan has gone before.';
  document.body.children.addAll([h1, i]);
}
