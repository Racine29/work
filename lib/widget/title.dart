import 'package:flutter/material.dart';
import 'package:work/recrutement.dart';

class CardTitle extends StatelessWidget {
  Recrutement recrutement;
  CardTitle({required this.recrutement});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        recrutement.job,
        style: const TextStyle(
          fontSize: 26,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
