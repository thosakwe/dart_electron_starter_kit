import 'package:build_runner/build_runner.dart';
import 'package:build_web_compilers/build_web_compilers.dart';

const String package = 'app';
const List<String> inputs = const ['web/main.dart'];

final List<BuildAction> buildActions = [
  // First, create the DDC module
  new BuildAction(
    new ModuleBuilder(),
    package,
    inputs: inputs,
  ),

  // Then, compile the entry point.
  new BuildAction(
    new DevCompilerBootstrapBuilder(),
    package,
    inputs: inputs,
  ),
];