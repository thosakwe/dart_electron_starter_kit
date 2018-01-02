import 'package:build_runner/build_runner.dart';
import 'package:build_web_compilers/build_web_compilers.dart';

const String package = 'app';

// Specify the entry point here.
const List<String> inputs = const [
  'web/main.dart',
];

final PackageGraph packageGraph = new PackageGraph.forThisPackage();

// Add additional builders here.
final List builderApplications = [
  // Run all dependencies.
  apply(
    'build_compilers',
    'ddc',
    [
      (_) => new ModuleBuilder(),
      (_) => new UnlinkedSummaryBuilder(),
      (_) => new LinkedSummaryBuilder(),
      (_) => new DevCompilerBuilder(),
    ],
    toAllPackages(),
    isOptional: true,
  ),

  // Compile the entry point(s).
  applyToRoot(
    new DevCompilerBootstrapBuilder(),
    inputs: inputs,
  ),
];
