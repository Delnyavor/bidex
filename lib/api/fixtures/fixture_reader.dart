import 'dart:io';

String readFixture(String name) {
  return File(name).readAsStringSync();
}
