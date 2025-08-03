import 'package:flutter_test/flutter_test.dart';
import 'package:logitracker/core/utility/extension.dart';

void main() {
  group('Extensions', () {
    group('Iterables groupBy', () {
      test('should group items by key function', () {
        final items = ['apple', 'banana', 'apricot', 'blueberry'];
        final grouped = items.groupBy((item) => item[0]);

        expect(grouped['a'], ['apple', 'apricot']);
        expect(grouped['b'], ['banana', 'blueberry']);
      });
    });

    group('StatusCodeExtension', () {
      test('should return true for success status codes', () {
        expect(200.isSuccessStatusCode(), true);
        expect(201.isSuccessStatusCode(), true);
        expect(299.isSuccessStatusCode(), true);
      });

      test('should return false for non-success status codes', () {
        expect(404.isSuccessStatusCode(), false);
        expect(500.isSuccessStatusCode(), false);
        expect(100.isSuccessStatusCode(), false);
      });

      test('should return false for null status code', () {
        int? nullCode;
        expect(nullCode.isSuccessStatusCode(), false);
      });
    });

    group('FileExtension', () {
      test('should extract file name correctly', () {
        expect('/path/to/file.txt'.getFileName, 'file');
      });

      test('should extract file extension correctly', () {
        expect('/path/to/file.txt'.getFileExtension, 'txt');
      });

      test('should identify network files', () {
        expect('http://example.com/file.jpg'.isNetworkFile, true);
        expect('https://example.com/file.jpg'.isNetworkFile, true);
        expect('/local/file.jpg'.isNetworkFile, false);
      });

      test('should identify asset files', () {
        expect('assets/images/logo.png'.isAssetFile, true);
        expect('/local/file.jpg'.isAssetFile, false);
      });
    });
  });
}
