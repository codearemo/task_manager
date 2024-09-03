import 'dart:developer';

import 'package:flutter/foundation.dart';

class DatasourceException implements Exception {
  final String message;

  const DatasourceException({
    required this.message,
  });

  void call() {
    if (kDebugMode) {
      log(message.toString(), name: 'ServerException');
    }
  }
}
