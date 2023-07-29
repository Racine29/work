import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:work/apply_job.dart';
import 'package:work/recrutement.dart';
import 'package:work/recrutement_detail.dart';

class ApplyBtn extends StatefulWidget {
  BuildContext context;
  String? tag;
  Recrutement? recrutement;
  bool onNewScreen;
  VoidCallback? onApplied;
  ApplyBtn({
    required this.context,
    this.tag,
    this.recrutement,
    this.onNewScreen = false,
    this.onApplied,
  });

  @override
  State<ApplyBtn> createState() => _ApplyBtnState();
}

class _ApplyBtnState extends State<ApplyBtn> with TickerProviderStateMixin {
  late AnimationController animationButton;
  late AnimationController animationButtonScale;
  bool colorChange = false;
  @override
  void initState() {
    animationButton = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    animationButtonScale = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationButton.dispose();
    animationButtonScale.dispose();
    super.dispose();
  }

  AnimationController get animation =>
      colorChange ? animationButtonScale : animationButton;
  num get scaleMin => colorChange && animationButtonScale.value > 0 ? 0.0 : .85;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return Transform.scale(
            scale: lerpDouble(1.0, scaleMin, animation.value),
            child: ElevatedButton(
              onPressed: colorChange
                  ? () async {
                      await animationButtonScale.forward();
                      await Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration:
                              const Duration(milliseconds: 1100),
                          reverseTransitionDuration:
                              const Duration(milliseconds: 1100),
                          pageBuilder: (ctx, anim, _) {
                            return FadeTransition(
                              opacity: anim,
                              child: ApplyJob(
                                  tag: widget.tag ?? "",
                                  animation: anim,
                                  recrutement: widget.recrutement!),
                            );
                          },
                        ),
                      );
                      animationButtonScale.reset();
                    }
                  : () async {
                      await animationButton.forward();
                      await animationButton.reverse();
                      if (widget.onNewScreen) {
                        setState(() {
                          colorChange = true;
                        });
                      }

                      if (!widget.onNewScreen && !colorChange) {
                        await Navigator.of(widget.context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 1300),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 1300),
                            pageBuilder: (ctx, anim, _) {
                              return FadeTransition(
                                opacity: anim,
                                child: RecrutementDetail(
                                    anim: anim,
                                    tag: widget.tag ?? "",
                                    recrutement: widget.recrutement!),
                              );
                            },
                          ),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: widget.onNewScreen && colorChange
                    ? Colors.black87
                    : Color(0xFF52B99F),
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                widget.onNewScreen && colorChange
                    ? "YOU APPLIED FOR A JOB"
                    : "APPLY FOR THE JOB",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        });
  }
}
