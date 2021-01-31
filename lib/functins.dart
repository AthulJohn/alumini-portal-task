import 'package:flutter/material.dart';
import 'dart:io';

double h(double no, context) {
  return no * (MediaQuery.of(context).size.height) / 812;
}

double w(double no, context) {
  return no * (MediaQuery.of(context).size.width) / 375;
}

Future<bool> testcon() async {
  {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
  return false;
}
