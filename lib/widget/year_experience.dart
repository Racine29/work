import 'package:flutter/material.dart';

class YearExperience extends StatelessWidget {
  double width;
  YearExperience({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      width: width,
      height: 80,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 241, 243, 243),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: Colors.transparent,
            child: Text(
              "3-4",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Text(
              "Years experience",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
