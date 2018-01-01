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
    var requireMain = doc.querySelector('[data-main="require_main"]');

    if (requireMain != null) {
      var script = doc.createElement('script')
        ..attributes['src'] = 'main.dart.js'
        ..attributes['type'] = 'text/javascript';
      requireMain.replaceWith(script);
      contents = doc.outerHtml;
    }

    transform
        .addOutput(new Asset.fromString(transform.primaryInput.id, contents));
  }
}
