import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:work/recrutement.dart';
import 'package:work/recrutement_card.dart';

import 'bottom_nav.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<double> cardPositions = [];

  List<Recrutement> newRecrutements = [];

  late AnimationController animation;

  List<Animation> animations = [];

  ValueNotifier<bool> animatedPositionNotifier = ValueNotifier<bool>(false);
  @override
  void initState() {
    newRecrutements = recrutements;
    cardPositions = List.generate(cardLength, (index) => 0.0);
    animation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    animations = List.generate(
        3,
        (index) => CurvedAnimation(
            parent: animation,
            curve: Interval(index == 0 ? 0.0 : (index / 10) + .2, 1.0,
                curve: Curves.ease))).reversed.toList();

    animation.forward();

    super.initState();
  }

  int milliseconds = 0;
  int cardLength = 3;

  double plus = 0;
  double angle = 0;

  double percent = 0;
  double sizePercent = 0;
  double position = 0.0;

  double newCardPosition = 0.0;
  double newPlus = 0;
  double newAngle = 0;

  double newPercent = 0;
  double newSizePercent = 0.5;
  List<Recrutement> recrutements = [
    Recrutement(
      name: "Uno restaurant",
      location: "location",
      job: "Network engineer",
      price: 180,
      rating: "5",
      profilImage: "asset/uno-restaurant.jpg",
      city: "Oakland,California",
    ),
    Recrutement(
      name: "Moose cafe",
      location: "location",
      job: "Human resources manager",
      price: 200,
      rating: "4",
      profilImage: "asset/moose-cafe.jpg",
      city: "Oakland,California",
    ),
    Recrutement(
      name: "Under the sea",
      location: "location",
      job: "Personnel manager",
      price: 180,
      rating: "5",
      profilImage: "asset/under-sea.jpg",
      city: "Oakland,California",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double cardHeight = size.height * .45;
    double cardWidth = size.width * .92;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animatedPositionNotifier.value = true;
    });
    return Scaffold(
      body: ValueListenableBuilder<bool>(
          valueListenable: animatedPositionNotifier,
          builder: (context, animatedPositionValue, _) {
            return Stack(
              children: [
                BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 126, 125, 150)
                                .withOpacity(0.4),
                            const Color.fromARGB(255, 46, 38, 66)
                                .withOpacity(0.9),
                          ],
                          begin: AlignmentDirectional.topStart,
                          end: AlignmentDirectional.bottomEnd,
                        ),
                      ),
                    )),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 9000),
                  curve: Curves.slowMiddle,
                  left: animatedPositionValue ? -size.width * 5 : size.width,
                  top: size.height * .12,
                  child: const Text(
                    "WORKWORKWORKWORKWORKWORKWORKWORKWORK",
                    style: TextStyle(
                      fontSize: 140,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.17,
                  width: size.width,
                  padding: MediaQuery.paddingOf(context),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        top: 10,
                        left: animatedPositionValue ? 10 : 80,
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                        child: AnimatedOpacity(
                          opacity: animatedPositionValue ? 1 : 0,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 800),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                  height: 80,
                                  width: 60,
                                  child: Image.asset("asset/personal.jpg",
                                      fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "James Defuo",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Personnal Manager",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: (size.height * 0.17 / 2) - 24,
                        child: AnimatedScale(
                          scale: animatedPositionValue ? 1 : 0,
                          duration: Duration(milliseconds: 1000),
                          child: AnimatedRotation(
                            turns: animatedPositionValue ? 0 : (pi / 5),
                            duration: Duration(milliseconds: 1000),
                            child: const Icon(
                              Icons.menu,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: size.height * .22,
                  child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, _) {
                        return RecrutementCard(
                            animation: animations.first,
                            onPanEnd: (details) async {
                              if (newCardPosition < -50) {
                                newCardPosition = -size.width;
                                milliseconds = 600;

                                await Future.delayed(
                                    Duration(milliseconds: milliseconds));

                                cardLength--;
                                setState(() {});
                              } else {
                                newCardPosition = 0;
                                milliseconds = 200;
                                setState(() {});
                              }
                            },
                            onPanUpdate: (details) {
                              milliseconds = 0;
                              final position = details.delta.dx;

                              newCardPosition += position;

                              setState(() {});
                            },
                            sizePercent: newSizePercent,
                            index: 100,
                            cardLength: 100,
                            cardPositionX: 0.0,
                            angle: 0.01,
                            position: newCardPosition / 4,
                            recrutement: Recrutement(
                              name: "Under the sea",
                              location: "location",
                              job: "Personnel manager",
                              price: 180,
                              rating: "5",
                              profilImage: "asset/under-sea.jpg",
                            ),
                            milliseconds: milliseconds,
                            cardWidth: cardWidth,
                            cardHeight: cardHeight);
                      }),
                ),
                Positioned(
                  top: -size.height * .07,
                  left: 0,
                  right: 0,
                  height: size.height,
                  child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, _) {
                        return Stack(
                          children: List.generate(recrutements.length, (index) {
                            Recrutement recrutement = recrutements[index];

                            angle =
                                ((recrutements.length - 1) - index).toDouble();

                            //  Choisir l'angle de chaque card --------------
                            if (recrutements.length >= 3) {
                              if (index == 0) {
                                plus = 2.3;
                                angle = angle * .005;
                              }
                              if (index == 1) {
                                plus = 1.7;
                                angle = -(angle * .01);
                              }
                              if (index == 2) {
                                plus = 1;
                              }
                            } else if (recrutements.length == 2) {
                              if (index == 0) {
                                plus = 1.7;
                                angle = -(angle * .005);
                                newAngle = angle * .05;
                              }
                              if (index == 1) {
                                plus = 1;
                              }
                            } else if (recrutements.length == 1) {
                              plus = 1;
                            }
                            // Fin Choisir l'angle de chaque card --------------

                            // Faire avancer un card au moment ou on swipe------
                            if (cardLength == 2) {
                              newAngle = angle * .5;
                              if (index == 0) {
                                plus = 1.7;
                                angle = (angle * 2);
                              }
                              if (index == 1) {
                                plus = 1;
                              }
                              if (index == 2) {
                                plus = 1;
                              }
                            }
                            if (cardLength == 1) {
                              plus = 1;
                              angle = (angle * .3);
                            }
                            //----- fin Faire avancer un card au moment ou on swipe------

                            percent = index / recrutements.length;
                            sizePercent = (index + plus) / cardLength;

                            position = cardLength <= 2
                                ? cardHeight /
                                    (plus / sizePercent.clamp(0.68, 0.7))
                                : cardHeight * percent;
                            final cardAnimation = animations[index];
                            double cardPosition = cardPositions[index];
                            return RecrutementCard(
                                animation: cardAnimation,
                                onPanEnd: index == recrutements.length - 1
                                    ? (details) {
                                        if (cardPosition < -60) {
                                          milliseconds = 600;
                                          cardPositions[index] = -size.width;

                                          cardLength--;
                                          newCardPosition =
                                              -(position / cardPosition) / 2;

                                          newSizePercent = newSizePercent + .2;

                                          Future.delayed(Duration(
                                                  milliseconds: milliseconds))
                                              .whenComplete(() {
                                            recrutements
                                                .remove(recrutements[index]);
                                            setState(() {});
                                          });
                                        } else {
                                          cardPositions[index] = 0;
                                          milliseconds = 200;
                                          setState(() {});
                                        }
                                      }
                                    : null,
                                onPanUpdate: index == recrutements.length - 1
                                    ? (details) {
                                        milliseconds = 0;
                                        final position = details.delta.dx;

                                        cardPositions[index] += position;

                                        setState(() {});
                                      }
                                    : null,
                                sizePercent: sizePercent,
                                index: index,
                                cardLength: cardLength,
                                cardPositionX: cardPosition,
                                angle: angle,
                                position: position,
                                recrutement: recrutement,
                                milliseconds: milliseconds,
                                cardWidth: cardWidth,
                                cardHeight: cardHeight);
                          }),
                        );
                      }),
                ),
                AnimatedBuilder(
                    animation: animation,
                    builder: (context, _) {
                      double bottom = animation.value > .2 ? 0 : -80;
                      return BottomNav(
                        bottom: bottom,
                        currentIndex: 0,
                        icons: icons,
                      );
                    }),
              ],
            );
          }),
    );
  }
}
