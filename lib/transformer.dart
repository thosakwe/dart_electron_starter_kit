import 'package:barback/barback.dart';
import 'package:html/parser.dart';

class ScriptRewriterTransformer extends Transformer {
  ScriptRewriterTransformer.asPlugin();

  @override
  String get allowedExtensions => '.html';

  @override
  apply(Transform transform) async {
    var contents = await transform.readInputAsString(transform.primaryInput.id);
    var doc = parse(contents);

    var devScripts = doc.querySelectorAll('script[data-electron-ddc]');

    for (int i = 0; i < devScripts.length; i++) {
      if (i == 0) {
        var script = doc.createElement('script')
          ..attributes['src'] = 'main.dart.js'
          ..attributes['type'] = 'text/javascript';
        devScripts[i].replaceWith(script);
      } else {
        devScripts[i].remove();
      }
    }

    if (devScripts.isNotEmpty) {
      contents = doc.outerHtml;
    }

    transform
        .addOutput(new Asset.fromString(transform.primaryInput.id, contents));
  }
}
