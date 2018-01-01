import 'dart:html';

void main() {
  var el = new Element.tag('i')..text = 'Running DDC within Electron!';
  document.body.append(el);
}
