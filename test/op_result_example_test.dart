import 'package:test/test.dart';
import '../example/op_result_example.dart' as example;

Future<void> main() async {
  test('op_result_example.dart should run without throwing', () async {
    await example.main(); // Runs the examples
  });
}
