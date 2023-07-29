import 'package:flutter/material.dart';

class TextSub extends StatelessWidget {
  final String title;
  final String subtitle;
  const TextSub({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Material(
            color: Colors.transparent,
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
