import 'dart:io';

String readFixture(String name) {
  return File('./lib/api/fixtures/$name').readAsStringSync();
}
