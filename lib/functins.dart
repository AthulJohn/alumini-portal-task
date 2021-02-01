import 'package:flutter/material.dart';
import 'dart:io';

//Function for dynamic height
double h(double no, context) {
  return no * (MediaQuery.of(context).size.height) / 812;
}

//Function for dynamic width
double w(double no, context) {
  return no * (MediaQuery.of(context).size.width) / 375;
}

//testing internet connection
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
