import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tartibat App Tests', () {
    test('Simple math test', () {
      expect(1 + 1, 2);
    });

    test('String concatenation', () {
      expect('Hello' ' ' 'World', 'Hello World');
    });

    test('List operations', () {
      final list = [1, 2, 3];
      expect(list.length, 3);
      expect(list.first, 1);
      expect(list.last, 3);
    });
  });
}
