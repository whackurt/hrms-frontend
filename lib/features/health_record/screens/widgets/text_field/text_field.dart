import 'package:flutter/material.dart';

class HRMSTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const HRMSTextField(
      {super.key,
      this.onChanged,
      this.onSaved,
      this.label,
      this.hintText,
      this.controller,
      this.validator,
      this.readOnly = false});

  @override
  State<HRMSTextField> createState() => _HRMSTextFieldState();
}

class _HRMSTextFieldState extends State<HRMSTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${widget.label}',
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
            ),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .90,
          child: TextFormField(
            readOnly: widget.readOnly,
            onChanged: widget.onChanged,
            controller: widget.controller,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                hintText: '${widget.hintText}',
                border: InputBorder.none),
            maxLines: 1,
            validator: widget.validator,
            onSaved: widget.onSaved,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        const SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
