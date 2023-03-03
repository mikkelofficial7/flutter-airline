import 'package:flutter/material.dart';
import 'package:sample_flutter/constants/colorconstant.dart';
import '../appbar.dart';
import 'component/component_main_fragment.dart';

class MainFragment extends StatelessWidget {
  const MainFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar("List of Air Line", ColorConstant.blue),
      body: const MainFragmentContainer()
    );
  }
}