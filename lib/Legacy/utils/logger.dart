import 'dart:developer' as developer;

/// Prints colorfull outputs
///
/// Members are:
/// - info => blue
/// - success => green
/// - warning => yellow
/// - error => red
abstract class Logger {
  // Blue text
  static void info(String msg, [String? location]) {
    developer.log(
        '\x1B[34m$msg ${location != null ? "Location:" : ""} ${location != null ? location : ""}\x1B[0m');
  }

// Green text
  static void success(String msg, [String? location]) {
    developer.log(
        '\x1B[32m$msg ${location != null ? "Location:" : ""} ${location != null ? location : ""}\x1B[0m');
  }

// Yellow text
  static void warning(String msg, [String? location]) {
    developer.log(
        '\x1B[33m$msg ${location != null ? "Location:" : ""} ${location != null ? location : ""}\x1B[0m');
  }

// Red text
  static void error(String msg, [String? location]) {
    developer.log(
        '\x1B[31m$msg ${location != null ? "Location:" : ""} ${location != null ? location : ""}\x1B[0m');
  }
}

void log({required String location, String msg = ''}) {
  print('From $location. $msg');
}
