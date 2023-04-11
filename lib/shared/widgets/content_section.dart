import 'package:flutter/material.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({Key? key, required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.maxFinite,
      padding: const EdgeInsets.all(15),
      child: content,
    );
  }
}
