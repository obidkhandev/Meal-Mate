import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldItem extends StatefulWidget {
  const TextFieldItem(
      {super.key,
        required this.exp,
        required this.hintText,
        required this.controller,
        required this.isPassword,
        required this.errorText,
        required this.iconPath});

  final RegExp exp;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final String errorText;
  final Icon iconPath;

  @override
  State<TextFieldItem> createState() => _TextFieldItemState();
}

class _TextFieldItemState extends State<TextFieldItem> {
  var eye = CupertinoIcons.eye;
  bool obscureText = false;

  @override
  void initState() {
    if (widget.isPassword) {
      obscureText = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.4,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? obscureText : false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String? value) {
          if (value != null && widget.exp.hasMatch(value)) {
            return null;
          } else {
            return widget.errorText;
          }
        },
        style: TextStyle(color: Colors.blueAccent),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 13),
          fillColor: Colors.white,
          border: InputBorder.none,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.iconPath,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
            onPressed: () {
              if (obscureText) {
                obscureText = false;
                eye = CupertinoIcons.eye_slash;
              } else {
                obscureText = true;
                eye = CupertinoIcons.eye;
              }
              setState(() {});
            },
            icon: Icon(eye),
          )
              : null,
        ),
      ),
    );
  }
}
