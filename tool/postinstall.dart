import 'dart:io';
import 'package:path/path.dart' as p;

main() async {
  var binRoot = p.dirname(Platform.resolvedExecutable);
  var sdkRoot = p.dirname(binRoot);
  var libRoot = p.join(sdkRoot, 'lib');
  var ddcRoot = p.join(libRoot, 'dev_compiler');
  var ddcAmdRoot = p.join(ddcRoot, 'amd');
  var sdkFile = new File(p.join(ddcAmdRoot, 'dart_sdk.js'));
  print('Preparing for DDC dev...');

  if (!await sdkFile.exists()) {
    stderr.writeln('$sdkFile does not exist. Running via DDC will not work.');
    exitCode = 1;
  } else {
    var targetFile =
        new File.fromUri(Platform.script.resolve('../web/dart_sdk.js'));
    await sdkFile.copy(targetFile.path);
    print('Copied $sdkFile -> $targetFile');

    var sdkPackageDir =
        new Directory.fromUri(targetFile.parent.uri.resolve('packages/\$sdk'));
    if (!await sdkPackageDir.exists())
      await sdkPackageDir.create(recursive: true);

    // Link DDC into sdkPackageDir
    var link = new Link.fromUri(sdkPackageDir.uri.resolve('dev_compiler'));
    await link.create(ddcRoot, recursive: true);
    print('Linked $ddcRoot -> $link');
  }
}
