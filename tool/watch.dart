import 'package:build_runner/build_runner.dart';
import 'build_actions.dart';

main() async {
  await watch(
    createBuildActions(packageGraph, builderApplications),
    deleteFilesByDefault: true,
    writeToCache: true,
    enableLowResourcesMode: true,
  );
}
