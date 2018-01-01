import 'dart:html';

void main() {
  var h1 = new Element.tag('h1')..text = 'Running DDC within Electron!';
  var i = new Element.tag('i')..text = 'Boldly go where no Dartisan has gone before.';
  document.body.children.addAll([h1, i]);
}
