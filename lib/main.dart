import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'presentation/injection.dart';

void main() {
  configureInjection(Environment.dev);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(),
    );
  }
}
