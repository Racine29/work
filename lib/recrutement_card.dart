import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:work/recrutement.dart';
import 'package:work/recrutement_detail.dart';
import 'package:work/widget/full_time.dart';
import 'package:work/widget/text_sub.dart';

import 'apply_btn.dart';
import 'widget/profil.dart';
import 'widget/year_experience.dart';

class RecrutementCard extends StatelessWidget {
  Function(DragEndDetails)? onPanEnd;
  Function(DragUpdateDetails)? onPanUpdate;
  double sizePercent;
  int index;
  int cardLength;
  double cardPositionX;
  double angle;
  Recrutement recrutement;
  double position;
  double cardHeight;
  double cardWidth;
  int milliseconds;
  Animation? animation;

  RecrutementCard({
    required this.onPanEnd,
    required this.onPanUpdate,
    this.animation,
    required this.sizePercent,
    required this.index,
    required this.cardLength,
    required this.cardPositionX,
    required this.angle,
    required this.position,
    required this.recrutement,
    required this.milliseconds,
    required this.cardWidth,
    required this.cardHeight,
  });

  late AnimationController animationButton;

  double turns() {
    return index == cardLength - 1
        ? ((cardLength - 1) / (cardPositionX + .0002)).clamp(-0.01, 0.0)
        : angle;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: onPanEnd,
      onPanUpdate: onPanUpdate,
      child: Center(
        child: AnimatedScale(
          duration: const Duration(milliseconds: 500),
          scale: sizePercent.clamp(0.0, 1.0),
          child: AnimatedRotation(
            turns: turns(),
            duration: const Duration(milliseconds: 400),
            child: AnimatedContainer(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: cardHeight,
              width: cardWidth,
              duration: Duration(milliseconds: milliseconds),
              transform: Matrix4.identity()
                ..translate(
                    lerpDouble(
                        cardWidth * 2, cardPositionX, animation?.value ?? 0.0),
                    position / 1.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Hero(
                        tag: "bg-$index",
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -150,
                      top: -10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: SizedBox(
                          width: cardWidth,
                          height: cardHeight,
                          child: Image.asset(
                            "asset/map.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.asset(
                                          recrutement.profilImage,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              recrutement.name,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "${recrutement.rating}/5",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Hero(
                                tag: "likeIcon-$index",
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.1),
                                          blurRadius: 10,
                                          offset: Offset.zero,
                                          spreadRadius: 2,
                                        )
                                      ]),
                                  child: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .7,
                            child: Hero(
                              tag: "title-$index",
                              flightShuttleBuilder: (flightContext,
                                  animation,
                                  flightDirection,
                                  fromHeroContext,
                                  toHeroContext) {
                                switch (flightDirection) {
                                  case HeroFlightDirection.pop:
                                    return ScaleTransition(
                                      scale: animation.drive(
                                          Tween<double>(begin: 1, end: 1.2)),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Text(
                                          recrutement.job,
                                          style: const TextStyle(
                                            fontSize: 26,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  case HeroFlightDirection.push:
                                    return ScaleTransition(
                                      scale: animation.drive(
                                          Tween<double>(begin: 1, end: 1.2)),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Text(
                                          recrutement.job,
                                          style: const TextStyle(
                                            fontSize: 26,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                }
                              },
                              child: Material(
                                color: Colors.transparent,
                                child: SizedBox(
                                  width: cardWidth / 1.1,
                                  child: Text(
                                    recrutement.job,
                                    style: const TextStyle(
                                      fontSize: 26,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Hero(
                                tag: "price-$index",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    "\$${recrutement.price}k",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Hero(
                                tag: "year-$index",
                                child: const Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    "/year",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 68,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        right: cardWidth / 4.5,
                        top: cardHeight / 4.5,
                        child: Column(
                          children: [
                            Hero(
                              tag: "place-rounded-icon-$index",
                              flightShuttleBuilder: (flightContext,
                                  animation,
                                  flightDirection,
                                  fromHeroContext,
                                  toHeroContext) {
                                return ScaleTransition(
                                  scale: animation
                                      .drive(Tween<double>(begin: 1, end: 1.3)),
                                  child: Icon(
                                    Icons.place_rounded,
                                    size: 30,
                                    color: Color.fromARGB(255, 82, 185, 159),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.place_rounded,
                                size: 30,
                                color: Color.fromARGB(255, 82, 185, 159),
                              ),
                            ),
                            Hero(
                              tag: "place-rounded-text-$index",
                              flightShuttleBuilder: (flightContext,
                                  animation,
                                  flightDirection,
                                  fromHeroContext,
                                  toHeroContext) {
                                return FadeTransition(
                                    opacity: CurvedAnimation(
                                      curve: const Interval(0.9, 1,
                                          curve: Curves.easeInOut),
                                      parent: animation,
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        recrutement.city ?? "",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ));
                              },
                              child: Material(
                                color: Colors.transparent,
                                child: Opacity(
                                  opacity: 0,
                                  child: Text(
                                    recrutement.city ?? "",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Positioned(
                      bottom: 150,
                      child: Hero(
                        tag: "bachelor-$index",
                        flightShuttleBuilder: (flightContext, animation,
                            flightDirection, fromHeroContext, toHeroContext) {
                          return FadeTransition(
                              opacity: CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(0.2, .5)),
                              child: const TextSub(
                                  title: "Bachelor's", subtitle: "Degree"));
                        },
                        child: const Opacity(
                            opacity: 0,
                            child: TextSub(
                                title: "Bachelor's", subtitle: "Degree")),
                      ),
                    ),
                    Positioned(
                      bottom: 180,
                      left: 120,
                      child: Hero(
                        tag: "day-work-$index",
                        flightShuttleBuilder: (flightContext, animation,
                            flightDirection, fromHeroContext, toHeroContext) {
                          return FadeTransition(
                              opacity: CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(0.6, .8)),
                              child: const TextSub(
                                  title: "Day-work",
                                  subtitle: "Day shifts only"));
                        },
                        child: const Opacity(
                            opacity: 0,
                            child: TextSub(
                                title: "Day-work",
                                subtitle: "Day shifts only")),
                      ),
                    ),

                    Positioned(
                        bottom: 20,
                        left: -10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                              tag: "profil-$index",
                              flightShuttleBuilder: (flightContext,
                                  animation,
                                  flightDirection,
                                  fromHeroContext,
                                  toHeroContext) {
                                return FadeTransition(
                                    opacity: CurvedAnimation(
                                        parent: animation,
                                        curve: const Interval(0.8, 1)),
                                    child: Profil(
                                        recrutement: recrutement,
                                        width: 60,
                                        height: 60));
                              },
                              child: Opacity(
                                opacity: 0,
                                child: Profil(
                                    recrutement: recrutement,
                                    width: 50,
                                    height: 50),
                              ),
                            ),
                            Hero(
                              tag: "profil-icon-$index",
                              flightShuttleBuilder:
                                  (___, animation, flightDirection, _, __) {
                                return ScaleTransition(
                                  scale: CurvedAnimation(
                                    parent: animation,
                                    curve: const Interval(.9, 1),
                                  ),
                                  child: RotationTransition(
                                    turns: CurvedAnimation(
                                      parent: animation,
                                      curve: const Interval(.9, 1),
                                    )..drive(
                                        Tween<double>(begin: 0.001, end: 0)),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 241, 243, 243),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Icon(
                                        Icons.chat_bubble_outline_rounded,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Opacity(
                                opacity: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 241, 243, 243),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),

                    Hero(
                        tag: "full-time-$index",
                        flightShuttleBuilder:
                            (___, animation, flightDirection, __, _) {
                          return ScaleTransition(
                              scale: CurvedAnimation(
                                  curve: const Interval(0.85, .98),
                                  parent: animation),
                              child: FullTime(width: 170));
                        },
                        child:
                            Opacity(opacity: 0, child: FullTime(width: 170))),
                    Hero(
                      flightShuttleBuilder: (flightContext, animation,
                          flightDirection, fromHeroContext, toHeroContext) {
                        return ScaleTransition(
                          scale: CurvedAnimation(
                              curve: const Interval(0.9, 1), parent: animation),
                          child: YearExperience(width: 170),
                        );
                      },
                      tag: "exp-$index",
                      child: Opacity(
                          opacity: 0, child: YearExperience(width: 170)),
                    ),
                    //  button d'action apply for the job----------------------------
                    Positioned(
                      right: 10,
                      left: 10,
                      bottom: 10,
                      child: Hero(
                        tag: "applyBtn-$index",
                        child: ApplyBtn(
                          context: context,
                          tag: "$index",
                          recrutement: recrutement,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
