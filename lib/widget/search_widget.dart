import 'package:flutter/material.dart';
import 'package:mns_management/constant/constant.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final BorderRadius circular;

  const SearchWidget({
    Key? key,
    required this.circular,
    required this.text,
    this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String? currentItem;

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle styleActive = const TextStyle(color: Colors.black);
    TextStyle styleHint = const TextStyle(color: Colors.black54);
    TextStyle style = widget.text.isEmpty ? styleHint : styleActive;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 50,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(
          borderRadius: widget.circular,
          color: kLightGreyColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: style,
            border: InputBorder.none,
          ),
          style: style,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}
