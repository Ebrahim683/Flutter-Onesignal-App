import 'package:logger/logger.dart';

class PrintLogger {
  final _logger = Logger();

  void message(tag, message) {
    _logger.d('$tag: $message');
  }

  void error(tag, message) {
    _logger.e('$tag: $message');
  }
}

final printLogger = PrintLogger();
