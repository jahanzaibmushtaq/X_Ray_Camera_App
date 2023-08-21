import 'package:flutter/material.dart';

class CustomIconButtonWidget extends StatelessWidget {
  const CustomIconButtonWidget({
    super.key,
    required this.function,
    required this.iconData,
  });
  final Function function;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () =>function.call(),
        icon: Icon(
          iconData,
          color: Colors.white,
        ));
  }
}
