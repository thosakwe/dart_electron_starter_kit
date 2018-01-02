import 'package:build_runner/build_runner.dart';
import 'build_actions.dart';

main() async {
  await watch(
    await buildActions(),
    deleteFilesByDefault: true,
    writeToCache: true,
  );
}
