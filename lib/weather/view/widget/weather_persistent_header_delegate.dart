import 'dart:ui';

import 'package:flutter/material.dart'
    show Colors, InputDecoration, OutlineInputBorder, TextField;
import 'package:flutter/widgets.dart';

class WeatherPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  WeatherPersistentHeaderDelegate({
    required this.needOpacity,
    required this.context,
    required this.textFieldUp,
    required this.textController,
    required this.focusNode,
  });

  final ValueNotifier needOpacity;
  final BuildContext context;
  final ValueNotifier textFieldUp;
  final TextEditingController textController;
  final FocusNode focusNode;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ValueListenableBuilder(
        valueListenable: needOpacity,
        builder: (context, _, __) {
          return Align(
            alignment: Alignment.center,
            child: ColoredBox(
              color:
                  needOpacity.value ? Colors.black.withAlpha(80) : Colors.black,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: maxExtent,
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    if (needOpacity.value)
                      Positioned(
                        top: 0,
                        height: maxExtent,
                        child: ClipRect(
                          clipBehavior: Clip.antiAlias,
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: minExtent,
                              child: Container(
                                color: Colors.black.withAlpha(80),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: SizedBox(
                        height: 36,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 8,
                              child: SizedBox(
                                height: 36,
                                child: TextField(
                                  controller: textController,
                                  focusNode: focusNode,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.top,
                                  cursorHeight: 20,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    filled: true,
                                    fillColor: needOpacity.value
                                        ? Colors.grey[800]?.withAlpha(200)
                                        : Colors.grey[800],
                                    prefixIconColor: Colors.white,
                                    hintText: 'Search for a city in Taiwan',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 18,
                                      textBaseline: TextBaseline.alphabetic,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  // controller: textController,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  onTapOutside: (_) async {
                                    focusNode.unfocus();
                                  },
                                ),
                              ),
                            ),
                            ValueListenableBuilder(
                                valueListenable: textFieldUp,
                                builder: (context, _, __) {
                                  return Expanded(
                                      flex: textFieldUp.value ? 2 : 0,
                                      child: AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: textFieldUp.value
                                            ? const Text(
                                                'Send',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      ));
                                }),
                            const SizedBox(
                              width: 6,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  double get maxExtent => MediaQuery.of(context).size.height * 0.075;

  @override
  double get minExtent => MediaQuery.of(context).size.height * 0.075;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
