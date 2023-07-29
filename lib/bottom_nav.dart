import 'package:flutter/material.dart';
import 'package:work/delayed_animation.dart';

class BottomNav extends StatelessWidget {
  const BottomNav(
      {super.key,
      required this.icons,
      this.bottom,
      required this.currentIndex});
  final List<IconData> icons;
  final double? bottom;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: bottom,
      left: 0,
      right: 0,
      duration: const Duration(milliseconds: 400),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          children: List.generate(icons.length, (index) {
            return Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                final width = constraints.maxWidth;
                final duration = 400 * index;

                return DelayedAnimation(
                  animationDuration: currentIndex == icons.length - 2
                      ? 0
                      : 800 + (duration / 1.5).toInt(),
                  startY: index == 0 ? 40 : 200 * ((index + 3) / icons.length),
                  child: Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          icons[index],
                          size: 24,
                          color: index == currentIndex
                              ? Colors.black87
                              : Colors.grey.shade400,
                        ),
                      ),
                      index != currentIndex
                          ? SizedBox()
                          : Positioned(
                              left: (width / 2) - ((24 + 4) / 2),
                              child: const CircleAvatar(
                                maxRadius: 4,
                                backgroundColor: Colors.black87,
                              ),
                            ),
                    ],
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
