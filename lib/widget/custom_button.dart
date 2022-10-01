import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Color colors;

  String text;
  CustomButton({Key? key, required this.text, this.onTap, required this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: colors,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 10, 6, 10),
        child: Text(
          text,
          maxLines: 1,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onPressed: onTap,
      shape: const StadiumBorder(),
    );
  }
}
