import 'dart:async';
import 'dart:convert';
import 'package:build/build.dart';

/// Generates a require_config.js file.
class RequireConfigBuilder implements Builder {
  static const String dartToolPath = '../.dart_tool/build/generated';
  final List<String> dependencies;

  const RequireConfigBuilder(this.dependencies);

  @override
  Map<String, List<String>> get buildExtensions {
    return {
      '.dart': ['.config.js']
    };
  }

  @override
  Future build(BuildStep buildStep) async {
    /*
    requirejs.config({
        paths: {
            'packages/string_scanner/src': '../.dart_tool/build/generated/string_scanner/lib/src',
        }
    });
     */
   var paths = <String, String>{};

   for (var dep in dependencies) {
     paths['packages/$dep'] = '$dartToolPath/$dep/lib';
   }

   var scriptContents = '''
       requirejs.config({
        paths: ${JSON.encode(paths)}
    });
   ''';
   buildStep.writeAsString(buildStep.inputId.changeExtension('.config.js'), scriptContents);
  }
}
