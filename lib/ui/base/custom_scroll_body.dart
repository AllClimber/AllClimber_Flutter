import 'package:flutter/material.dart';

class CustomScrollBody extends StatelessWidget {
  const CustomScrollBody({
    super.key,
    this.padding = const EdgeInsets.all(0),
    this.children = const <Widget>[],
  });
  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
