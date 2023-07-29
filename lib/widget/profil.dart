import 'package:flutter/material.dart';
import 'package:work/recrutement.dart';

class Profil extends StatelessWidget {
  Recrutement recrutement;
  double? width;
  double? height;
  Profil({required this.recrutement, this.width = 50, this.height = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: width! * 4,
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                recrutement.profilImage,
                width: width,
                height: height,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    recrutement.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Material(
                color: Colors.transparent,
                child: Text(
                  "${recrutement.rating}/5",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
