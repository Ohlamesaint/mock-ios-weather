import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherDelegate extends SliverPersistentHeaderDelegate {
  WeatherDelegate({
    required this.showHeader,
    required this.textFieldUp,
    required this.scrollController,
    required this.context,
  });

  final bool showHeader;
  final bool textFieldUp;
  final ScrollController scrollController;
  final BuildContext context;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return (textFieldUp)
        ? const SizedBox.shrink()
        : Container(
            color: showHeader ? Colors.black.withAlpha(80) : Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (showHeader)
                  Positioned(
                    top: 0,
                    height: maxExtent,
                    child: ClipRect(
                      clipBehavior: Clip.antiAlias,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: maxExtent,
                          child: Container(
                            color: Colors.black.withAlpha(80),
                          ),
                        ),
                      ),
                    ),
                  ),
                SafeArea(
                  top: true,
                  bottom: false,
                  left: false,
                  right: false,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedOpacity(
                          opacity: scrollController.hasClients &&
                                  scrollController.offset > 45
                              ? 1.0
                              : 0.0,
                          duration: const Duration(milliseconds: 100),
                          child: const Text(
                            'weather',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  @override
  double get maxExtent =>
      MediaQuery.of(context).padding.top +
      MediaQuery.of(context).size.height * 0.05;

  @override
  double get minExtent =>
      MediaQuery.of(context).padding.top +
      MediaQuery.of(context).size.height * 0.05;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
