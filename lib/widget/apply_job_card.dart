import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:work/recrutement.dart';
import 'package:work/widget/profil.dart';
import 'package:work/widget/title.dart';

import 'full_time.dart';
import 'year_experience.dart';

class ApplyJobCard extends StatelessWidget {
  final Recrutement recrutement;
  const ApplyJobCard({super.key, required this.recrutement});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double cardHeight = size.height * .45;
    double cardWidth = size.width * .92;
    return Transform.scale(
      scale: .85,
      child: SizedBox(
        width: cardWidth / 1.1,
        height: cardHeight / 1.1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              Positioned(
                right: size.width * .1,
                top: size.height * .1,
                child: const Icon(
                  Icons.place_rounded,
                  size: 30,
                  color: Color.fromARGB(255, 82, 185, 159),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.scale(
                            scale: .95,
                            child: CardTitle(recrutement: recrutement)),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: Text(
                                "\$${recrutement.price}k",
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            const Material(
                              color: Colors.transparent,
                              child: Text(
                                "/year",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Profil(recrutement: recrutement),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    SizedBox(
                      height: 80,
                      child: Stack(
                        children: [
                          Positioned(
                            left: -5,
                            child: Transform.scale(
                              scale: .9,
                              child: FullTime(width: 130),
                            ),
                          ),
                          Positioned(
                            left: 120,
                            child: Transform.scale(
                                scale: .9, child: YearExperience(width: 150)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2.0,
                  sigmaY: 2.0,
                ),
                child: Container(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
