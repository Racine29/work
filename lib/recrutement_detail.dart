import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:work/recrutement.dart';
import 'package:work/widget/full_time.dart';
import 'package:work/widget/profil.dart';
import 'package:work/widget/year_experience.dart';

import 'apply_btn.dart';
import 'apply_job.dart';
import 'widget/text_sub.dart';

class RecrutementDetail extends StatefulWidget {
  String tag;
  Recrutement recrutement;
  Animation anim;
  RecrutementDetail(
      {required this.tag, required this.recrutement, required this.anim});

  @override
  State<RecrutementDetail> createState() => _RecrutementDetailState();
}

class _RecrutementDetailState extends State<RecrutementDetail>
    with TickerProviderStateMixin {
  late AnimationController animateWidgetController;

  @override
  void initState() {
    animateWidgetController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    widget.anim.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationNotifier.value = true;
      }
    });
    animateWidgetController.forward();

    super.initState();
  }

  @override
  dispose() {
    animateWidgetController.dispose();
    super.dispose();
  }

  ValueNotifier<bool> animationNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
              tag: "bg-${widget.tag}",
              child: Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            Positioned(
              top: size.height * .13,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Stack(
                    children: [
                      Positioned(
                          right: size.width * .08,
                          top: size.height * .13,
                          child: Column(
                            children: [
                              Hero(
                                tag: "place-rounded-icon-${widget.tag}",
                                flightShuttleBuilder:
                                    (_, animation, direction, ___, ____) {
                                  if (direction == HeroFlightDirection.pop) {
                                    return ScaleTransition(
                                      scale: animation.drive(
                                          Tween<double>(begin: 1.3, end: 1)),
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
                                        Tween<double>(begin: 1, end: 1.3)),
                                    child: const Icon(
                                      Icons.place_rounded,
                                      size: 30,
                                      color: Color.fromARGB(255, 82, 185, 159),
                                    ),
                                  );
                                },
                                child: Transform.scale(
                                  scale: 1.3,
                                  child: const Icon(
                                    Icons.place_rounded,
                                    size: 30,
                                    color: Color.fromARGB(255, 82, 185, 159),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * .01),
                              Hero(
                                tag: "place-rounded-text-${widget.tag}",
                                child: Text(
                                  widget.recrutement.city!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: widget.recrutement.job.length < 20
                                  ? 22
                                  : 30.0,
                            ),
                            child: Hero(
                              flightShuttleBuilder:
                                  (_, animation, flightDirection, ___, __) {
                                if (flightDirection ==
                                    HeroFlightDirection.pop) {
                                  return ScaleTransition(
                                    scale: animation.drive(
                                        Tween<double>(begin: 1.2, end: .95)),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        widget.recrutement.job,
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return ScaleTransition(
                                  scale: animation
                                      .drive(Tween<double>(begin: 1, end: 1.2)),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      widget.recrutement.job,
                                      style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              tag: "title-${widget.tag}",
                              child: Transform.scale(
                                scale: 1.2,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    widget.recrutement.job,
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
                                        fontWeight: FontWeight.w400),
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
                          SizedBox(
                            height: size.height * .04,
                          ),
                          Hero(
                            flightShuttleBuilder:
                                (_, animation, flightDirection, __, ___) {
                              if (flightDirection == HeroFlightDirection.pop) {
                                return ScaleTransition(
                                  scale: animation.drive(
                                      Tween<double>(begin: 1.0, end: .9)),
                                  child: FullTime(width: 170),
                                );
                              }
                              return ScaleTransition(
                                scale: CurvedAnimation(
                                    curve: const Interval(0.85, .98),
                                    parent: animation),
                                child: FullTime(width: 170),
                              );
                            },
                            tag: "full-time-${widget.tag}",
                            child: FullTime(width: 170),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Hero(
                            flightShuttleBuilder:
                                (_, animation, flightDirection, __, ___) {
                              if (flightDirection == HeroFlightDirection.pop) {
                                return ScaleTransition(
                                  scale: animation.drive(
                                      Tween<double>(begin: 1.0, end: .9)),
                                  child: YearExperience(width: 170),
                                );
                              }
                              return ScaleTransition(
                                scale: CurvedAnimation(
                                    curve: const Interval(0.9, 1),
                                    parent: animation),
                                child: YearExperience(width: 170),
                              );
                            },
                            tag: "exp-${widget.tag}",
                            child: YearExperience(width: 170),
                          ),
                          SizedBox(
                            height: 100,
                            width: size.width,
                            child: Stack(
                              children: [
                                AnimatedBuilder(
                                    animation: animateWidgetController,
                                    builder: (context, _) {
                                      final value = Curves.easeInOut.transform(
                                          animateWidgetController.value);
                                      return Transform.translate(
                                        offset: Offset(
                                            0.0, lerpDouble(0, 34, value)!),
                                        child: Hero(
                                            tag: "bachelor-${widget.tag}",
                                            child: const TextSub(
                                                title: "Bachelor's",
                                                subtitle: "Degree")),
                                      );
                                    }),
                                AnimatedBuilder(
                                    animation: animateWidgetController,
                                    builder: (context, _) {
                                      return Transform.translate(
                                        offset: Offset(
                                            120.0,
                                            lerpDouble(
                                                0,
                                                34,
                                                CurvedAnimation(
                                                        parent:
                                                            animateWidgetController,
                                                        curve: const Interval(
                                                            0.2, 1.0,
                                                            curve: Curves
                                                                .easeInOut))
                                                    .value)!),
                                        child: Hero(
                                            tag: "day-work-${widget.tag}",
                                            child: TextSub(
                                                title: "Day-work",
                                                subtitle: "Day shifts only")),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * .04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Hero(
                                tag: "profil-${widget.tag}",
                                child: Profil(
                                  recrutement: widget.recrutement,
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              Hero(
                                tag: "profil-icon-${widget.tag}",
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
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        top: (size.height / 3) - 50,
                        left: size.width / 5,
                        child: Hero(
                          tag: "profil-apply-${widget.tag}",
                          flightShuttleBuilder:
                              (___, animation, flightDirection, __, _) {
                            return FadeTransition(
                                opacity: CurvedAnimation(
                                    parent: animation,
                                    curve: const Interval(.9, 1)),
                                child: Profil(
                                    recrutement: widget.recrutement,
                                    width: 50,
                                    height: 50));
                          },
                          child: Opacity(
                            opacity: 0,
                            child: Profil(
                              recrutement: widget.recrutement,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // App bar ----------
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
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
                          ValueListenableBuilder<bool>(
                              valueListenable: animationNotifier,
                              builder: (context, value, _) {
                                return AnimatedPositioned(
                                  duration: const Duration(milliseconds: 300),
                                  left: value ? 0 : 30,
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: value ? 1 : 0,
                                    child: Icon(
                                      Icons.keyboard_double_arrow_left_rounded,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                    Hero(
                      tag: "likeIcon-${widget.tag}",
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
              ),
            ),

            Positioned(
              right: 10,
              left: 10,
              bottom: 10,
              child: Hero(
                tag: "applyBtn-${widget.tag}",
                child: ApplyBtn(
                  recrutement: widget.recrutement,
                  tag: widget.tag,
                  onNewScreen: true,
                  onApplied: () {},
                  context: context,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
