import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../functins.dart';

class Loading extends StatelessWidget {
  final Random rand = Random();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.blue,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '...Please Wait...\nSome processes may take more time',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 15),
            ),
            SizedBox(height: h(20, context)),
            SpinKitDoubleBounce(
              color: Colors.white,
              size: h(100, context),
            ),
            SizedBox(
              height: h(20, context),
            ),
          ]),
    );
  }
}
