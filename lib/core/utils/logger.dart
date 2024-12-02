import 'dart:io';

enum Logger {
  // ignore: constant_identifier_names
  Black("30"),
  // ignore: constant_identifier_names
  Red("31"),
  // ignore: constant_identifier_names
  Green("32"),
  // ignore: constant_identifier_names
  Yellow("33"),
  // ignore: constant_identifier_names
  Blue("34"),
  // ignore: constant_identifier_names
  Magenta("35"),
  // ignore: constant_identifier_names
  Cyan("36"),
  // ignore: constant_identifier_names
  White("37");

  final String code;
  const Logger(this.code);

  void log(dynamic text) => stdout.write('\x1B[${code}m$text\x1B[0m\n');
}
