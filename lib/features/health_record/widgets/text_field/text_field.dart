import 'package:flutter/material.dart';

class HRMSTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const HRMSTextField(
      {super.key, this.onChanged, this.label, this.hintText, this.controller});

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
            onChanged: widget.onChanged,
            controller: widget.controller,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                hintText: '${widget.hintText}',
                border: InputBorder.none),
            maxLines: 2,
          ),
        ),
        const SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
