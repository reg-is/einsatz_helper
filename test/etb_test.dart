import 'package:einsatz_helper/module_etb/model/etb_entry_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Taktische Zeit Converter', () {
    test('UTG Test 1', () {
      DateTime testDate = DateTime(2022, 12, 1, 8, 0);
      String dtg = toDTG(testDate);

      expect(dtg, '01 0800dec22');
    });
    test('UTG Test 2', () {
      DateTime testDate = DateTime(2102, 3, 4, 7, 1);
      String dtg = toDTG(testDate);

      expect(dtg, '04 0701mar02');
    });

    test('UTG Test 3', () {
      DateTime testDate = DateTime(2003, 1, 25, 23, 45);
      String dtg = toDTG(testDate);

      expect(dtg, '25 2345jan03');
    });

    test('UTG Test 4', () {
      DateTime testDate = DateTime.parse('1985-09-20 20:21');
      String dtg = toDTG(testDate);

      expect(dtg.replaceAll(' ', ''), '202021sep85');
    });

    test('UTG Test 5', () {
      DateTime testDate = DateTime.parse('2103-05-04 09:00');
      String dtg = toDTG(testDate);

      expect(dtg.replaceAll(' ', ''), '040900may03');
    });
  });
}
