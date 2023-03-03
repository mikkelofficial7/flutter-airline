import 'package:flutter/material.dart';
import 'package:sample_flutter/constants/defaultconstant.dart';
import 'package:sample_flutter/fragment/main_fragment.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: DefaultConstant.appName,
      home: MainFragment(),
    );
  }
}
