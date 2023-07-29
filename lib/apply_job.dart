import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:work/recrutement.dart';
import 'package:work/widget/apply_job_card.dart';
import 'package:work/widget/full_time.dart';
import 'package:work/widget/profil.dart';
import 'package:work/widget/title.dart';

import 'bottom_nav.dart';
import 'home.dart';
import 'widget/year_experience.dart';

class ApplyJob extends StatefulWidget {
  Recrutement recrutement;
  String tag;
  Animation<double> animation;
  ApplyJob(
      {required this.recrutement, required this.tag, required this.animation});

  @override
  State<ApplyJob> createState() => _ApplyJobState();
}

class _ApplyJobState extends State<ApplyJob> with TickerProviderStateMixin {
  ValueNotifier<bool> animationNotifier = ValueNotifier<bool>(false);
  late AnimationController cardAnimationController;
  late Animation firstAnimation;
  late Animation twoAnimation;
  late Animation threeAnimation;

  @override
  void initState() {
    cardAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 1200,
        ));

    firstAnimation = CurvedAnimation(
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOutQuad),
        parent: cardAnimationController);
    twoAnimation = CurvedAnimation(
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOutQuad),
        parent: cardAnimationController);

    cardAnimationController.forward();
    cardAnimationController.addStatusListener((status) {
      if (status != AnimationStatus.forward) {
        firstAnimation = CurvedAnimation(
            curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
            parent: cardAnimationController);
        threeAnimation = CurvedAnimation(
            curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
            parent: cardAnimationController);
        twoAnimation = CurvedAnimation(
            curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
            parent: cardAnimationController);

        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    cardAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double cardHeight = size.height * .45;
    double cardWidth = size.width * .92;

    return Scaffold(
      backgroundColor: Color(0xFF52B99F),
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            AnimatedBuilder(
                animation: cardAnimationController,
                builder: (context, _) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 9000),
                    curve: Curves.slowMiddle,
                    left: cardAnimationController.value > .1
                        ? -size.width * 5
                        : size.width,
                    top: size.height * .12,
                    child: const Text(
                      "ESPERONS ESPERONS ESPERONS ESPERONS",
                      style: TextStyle(
                        fontSize: 140,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
            AnimatedBuilder(
                animation: cardAnimationController,
                builder: (context, _) {
                  return Transform.rotate(
                    angle: lerpDouble(pi / 180, pi / 20, twoAnimation.value)!,
                    child: Transform.translate(
                        offset: Offset(
                            lerpDouble(size.width * 2, size.width * .3,
                                twoAnimation.value)!,
                            size.height * .04),
                        child: ApplyJobCard(
                          recrutement: Recrutement(
                              name: "Devs Op",
                              location: "Bamako,Mali",
                              job: "Administrator",
                              price: 100,
                              rating: "4/5",
                              profilImage: "asset/uno-restaurant.jpg"),
                        )),
                  );
                }),
            AnimatedBuilder(
                animation: cardAnimationController,
                builder: (context, _) {
                  return Transform.rotate(
                    angle:
                        lerpDouble(-pi / 180, -pi / 20, firstAnimation.value)!,
                    child: Transform.translate(
                        offset: Offset(
                            lerpDouble(size.width * .95, size.width * .1,
                                firstAnimation.value)!,
                            size.height * .5),
                        child: ApplyJobCard(
                          recrutement: Recrutement(
                              name: "Devs Op",
                              location: "California,Etat unis",
                              job: "Administrator",
                              price: 300,
                              rating: "3/5",
                              profilImage: "asset/moose-cafe.jpg"),
                        )),
                  );
                }),
            // current card
            Positioned(
              top: size.height / 2 - (cardHeight / 2),
              right: 10,
              child: AnimatedBuilder(
                  animation: cardAnimationController,
                  builder: (context, _) {
                    double value = 0;

                    if (cardAnimationController.status !=
                        AnimationStatus.forward) {
                      value = size.width * 2;
                    }
                    return Transform.translate(
                      offset: Offset(
                          lerpDouble(
                              value,
                              0,
                              cardAnimationController.status !=
                                      AnimationStatus.forward
                                  ? threeAnimation.value
                                  : 1)!,
                          0),
                      child: SizedBox(
                        width: cardWidth / 1.1,
                        height: cardHeight / 1.1,
                        child: Stack(
                          children: [
                            Hero(
                              tag: "bg-${widget.tag}",
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.15),
                                      offset: Offset(0, 0),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: size.width * .1,
                              top: size.height * .1,
                              child: Hero(
                                tag: "place-rounded-icon-${widget.tag}",
                                flightShuttleBuilder: (flightContext,
                                    animation,
                                    flightDirection,
                                    fromHeroContext,
                                    toHeroContext) {
                                  if (flightDirection ==
                                      HeroFlightDirection.pop) {
                                    return ScaleTransition(
                                      scale: animation.drive(
                                          Tween<double>(begin: 1, end: 1.3)),
                                      child: const Icon(
                                        Icons.place_rounded,
                                        size: 30,
                                        color:
                                            Color.fromARGB(255, 82, 185, 159),
                                      ),
                                    );
                                  }
                                  return ScaleTransition(
                                    scale: animation.drive(
                                        Tween<double>(begin: 1.3, end: 1)),
                                    child: const Icon(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Hero(
                                        flightShuttleBuilder: (_, animation,
                                            flightDirection, ___, __) {
                                          if (flightDirection ==
                                              HeroFlightDirection.pop) {
                                            return ScaleTransition(
                                                scale: animation.drive(
                                                    Tween<double>(
                                                        begin: 1.2, end: .95)),
                                                child: CardTitle(
                                                    recrutement:
                                                        widget.recrutement));
                                          }
                                          return ScaleTransition(
                                              scale: animation.drive(
                                                  Tween<double>(
                                                      begin: 1.2, end: .95)),
                                              child: CardTitle(
                                                  recrutement:
                                                      widget.recrutement));
                                        },
                                        tag: "title-${widget.tag}",
                                        child: Transform.scale(
                                            scale: .95,
                                            child: CardTitle(
                                                recrutement:
                                                    widget.recrutement)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Hero(
                                            tag: "price-${widget.tag}",
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Text(
                                                "\$${widget.recrutement.price}k",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                          Hero(
                                            tag: "year-${widget.tag}",
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
                                    ],
                                  ),
                                  Hero(
                                    tag: "profil-apply-${widget.tag}",
                                    child: Profil(
                                      recrutement: widget.recrutement,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: -5,
                                          child: Hero(
                                            tag: "full-time-${widget.tag}",
                                            flightShuttleBuilder:
                                                (flightContext,
                                                    animation,
                                                    flightDirection,
                                                    fromHeroContext,
                                                    toHeroContext) {
                                              return ScaleTransition(
                                                scale: animation.drive(
                                                    Tween<double>(
                                                        begin: 1.0, end: .9)),
                                                child: FullTime(width: 130),
                                              );
                                            },
                                            child: Transform.scale(
                                              scale: .9,
                                              child: FullTime(width: 130),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 120,
                                          child: Hero(
                                            tag: "exp-${widget.tag}",
                                            flightShuttleBuilder:
                                                (flightContext,
                                                    animation,
                                                    flightDirection,
                                                    fromHeroContext,
                                                    toHeroContext) {
                                              return ScaleTransition(
                                                scale: animation.drive(
                                                    Tween<double>(
                                                        begin: 1.0, end: .9)),
                                                child:
                                                    YearExperience(width: 150),
                                              );
                                            },
                                            child: Transform.scale(
                                                scale: .9,
                                                child:
                                                    YearExperience(width: 150)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            // App bar ----------
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () async {
                              await cardAnimationController.reverse();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/", (route) => false);
                            },
                            child: const Icon(
                              Icons.keyboard_double_arrow_left_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.star_rate_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            AnimatedBuilder(
                animation: cardAnimationController,
                builder: (context, _) {
                  double bottom = 0;
                  if (cardAnimationController.status ==
                      AnimationStatus.forward) {
                    bottom = -80;
                  } else {
                    bottom = 0;
                  }
                  return BottomNav(
                    currentIndex: icons.length - 2,
                    bottom: cardAnimationController.value > .2 ? 0 : bottom,
                    icons: icons,
                  );
                }),
          ],
        ),
      )),
    );
  }
}
