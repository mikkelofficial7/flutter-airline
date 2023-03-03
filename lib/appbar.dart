import 'package:flutter/material.dart';
import 'package:sample_flutter/constants/colorconstant.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget{
  final String titleName;
  final Color? backgroundColor;

  Appbar(this.titleName, this.backgroundColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(titleName),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}