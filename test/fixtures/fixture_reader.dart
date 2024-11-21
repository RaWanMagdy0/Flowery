import 'dart:io';

String fixtureReader({
  required String folderName,
  required String fileName,
}) {
  final file = File('test/fixtures/$folderName/$fileName');
  return file.readAsStringSync();
}
