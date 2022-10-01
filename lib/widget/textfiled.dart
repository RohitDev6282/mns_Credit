import 'package:flutter/material.dart';
import 'package:mns_management/constant/constant.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final Widget label;
  final String hinttest;
  final validiate;
  var keyType;
  final TextEditingController controller;

  TextFieldWidget({
    Key? key,
    this.keyType,
    this.maxLines = 1,
    required this.hinttest,
    this.validiate,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.label,
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: kLightGreyColor)],
            ),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              keyboardType: widget.keyType,
              validator: widget.validiate,
              controller: widget.controller,
              style: kBLTextStyle,
              obscureText: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(26, 18, 4, 18),
                hintText: widget.hinttest,
                hintStyle: ktextFieldText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: kWhiteColor, width: 0.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: kWhiteColor, width: 0.0),
                ),
              ),
              maxLines: widget.maxLines,
            ),
          ),
        ],
      );
}
