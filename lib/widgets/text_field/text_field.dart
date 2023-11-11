import 'package:flutter/material.dart';

class HRMSRoundedTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? Function(String?)? validator;
  const HRMSRoundedTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.validator,
      this.obscureText});

  @override
  State<HRMSRoundedTextField> createState() => _HRMSRoundedTextFieldState();
}

class _HRMSRoundedTextFieldState extends State<HRMSRoundedTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: widget.obscureText == null ? false : true,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
          hintText: '${widget.hintText}',
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator);
  }
}
