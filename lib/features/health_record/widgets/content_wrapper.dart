import 'package:flutter/cupertino.dart';

class HRMSContentWrapper extends StatefulWidget {
  final Widget? child;
  const HRMSContentWrapper({super.key, this.child});

  @override
  State<HRMSContentWrapper> createState() => _HRMSContentWrapperState();
}

class _HRMSContentWrapperState extends State<HRMSContentWrapper> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: widget.child,
      ),
    );
  }
}
