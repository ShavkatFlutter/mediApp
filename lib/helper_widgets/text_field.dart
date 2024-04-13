import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String hintText;
  final Widget label;
  final Widget? icon;
  final TextEditingController? controller;
  final bool obscureText;
  final void Function(String)? onSubmitted;

  const InputText(
      {super.key,
      required this.hintText,
      required this.label,
      this.icon,
      this.controller,
      required this.obscureText,
        this.onSubmitted,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 55,
        child: TextField(
          onSubmitted: onSubmitted,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: icon,
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            hintText: hintText,
            label: label,
          ),
        ),
      ),
    );
  }
}
