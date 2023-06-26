import 'dart:developer' as developer;

void log({required String location, String msg = ''}) {
  print('From $location. $msg');
}

/// Prints colorfull outputs
/// 
/// Members are:
/// - info => blue
/// - success => green
/// - warning => yellow
/// - error => red
abstract class Logger {
  // Blue text
  static void info(String msg) {
    developer.log('\x1B[34m$msg\x1B[0m');
  }

// Green text
  static void success(String msg) {
    developer.log('\x1B[32m$msg\x1B[0m');
  }

// Yellow text
  static void warning(String msg) {
    developer.log('\x1B[33m$msg\x1B[0m');
  }

// Red text
  static void error(String msg) {
    developer.log('\x1B[31m$msg\x1B[0m');
  }
}
