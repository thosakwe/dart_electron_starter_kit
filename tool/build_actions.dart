import 'dart:async';
import 'package:build_runner/build_runner.dart';
import 'package:build_test/build_test.dart';
import 'package:build_web_compilers/build_web_compilers.dart';
import 'require_config_builder.dart';

const String package = 'app';

// Specify the entry point here.
const List<String> inputs = const [
  'web/main.dart',
];

// We have to manually list out our dependencies (for now),
// in order to have them built by DDC.
//
// They also must be specified in order
const List<String> dependencies = const [
  'charcode',
  'path',
  'source_span',
  'string_scanner',
];

Future<List<BuildAction>> buildActions() async {
  var actions = [];

  for (final dep in dependencies) {
    actions.addAll([
      // First, create the DDC module
      new BuildAction(
        const ModuleBuilder(),
        dep,
        inputs: const [
          'lib/**/*.dart',
          'lib/*.dart',
        ],
      ),

      // Build an unlinked summary
      new BuildAction(
        const UnlinkedSummaryBuilder(),
        dep,
      ),

      // Build a linked summary
      new BuildAction(
        const LinkedSummaryBuilder(),
        dep,
      ),

      // Next, output the module as .ddc.js
      new BuildAction(
        const DevCompilerBuilder(),
        dep,
      ),

      // Copy it to *.js, so that require.js can find our dependencies.
      new BuildAction(
        new CopyBuilder(
          inputExtension: '.ddc.js',
          extension: 'js',
        ),
        dep,
      ),
    ]);
  }

  actions.addAll([
    // Create a module from our own code
    new BuildAction(
      const ModuleBuilder(),
      package,
      inputs: inputs,
    ),

    // Build our entry point
    new BuildAction(
      const DevCompilerBuilder(),
      package,
    ),

    // Build a RequireJS config file
    new BuildAction(
      const RequireConfigBuilder(dependencies),
      package,
      inputs: inputs,
    ),
  ]);

  return actions;
}
