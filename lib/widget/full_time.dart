import 'package:flutter/material.dart';

class FullTime extends StatelessWidget {
  double width;
  FullTime({required this.width});

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
          Icon(Icons.timer_outlined, size: 26),
          Material(
            color: Colors.transparent,
            child: Text(
              "Full time job",
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
