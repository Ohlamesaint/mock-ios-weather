import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'
    show
        useEffect,
        useFocusNode,
        useScrollController,
        useTextEditingController,
        useValueNotifier;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forcast/weather/view/component/weather_result_display.dart';
import 'package:weather_forcast/weather/view/widget/error_display.dart';
import 'package:weather_forcast/weather/view/widget/weather_delegate.dart';
import 'package:weather_forcast/weather/view/widget/weather_persistent_header_delegate.dart';

class WeatherPage extends HookConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController(initialScrollOffset: 0);
    final focusNode = useFocusNode();
    final textEditingController = useTextEditingController();
    final isFirst = useValueNotifier(true);
    final showHeader = useValueNotifier(false);
    final textFieldUp = useValueNotifier(false);

    void checkShowHeader() {
      if (scrollController.hasClients && scrollController.offset > 45) {
        showHeader.value = true;
      } else {
        showHeader.value = false;
      }
    }

    void checkElevateTextFieldUp() {
      if (focusNode.hasFocus) {
        textFieldUp.value = true;
        scrollController.animateTo(0,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        textFieldUp.value = false;
        if (textEditingController.text.isNotEmpty) {
          isFirst.value = false;
        }
      }
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.position.addListener(checkShowHeader);
        focusNode.addListener(checkElevateTextFieldUp);
      });
      return () {
        scrollController.position.removeListener(checkShowHeader);
        focusNode.removeListener(checkElevateTextFieldUp);
      };
    }, []);

    return ListenableBuilder(
        listenable: Listenable.merge([showHeader, textFieldUp]),
        builder: (context, _) {
          return Scaffold(
            backgroundColor:
                showHeader.value ? Colors.black.withAlpha(200) : Colors.black,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      textFieldUp.value
                          ? PinnedHeaderSliver(
                              child: ColoredBox(
                                color: Colors.black.withAlpha(80),
                                child: ClipRect(
                                  clipBehavior: Clip.antiAlias,
                                  child: SafeArea(
                                    bottom: false,
                                    left: false,
                                    right: false,
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 6.0, sigmaY: 6.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Container(
                                          color: Colors.black.withAlpha(80),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SliverPersistentHeader(
                              pinned: true,
                              delegate: WeatherDelegate(
                                showHeader: showHeader.value,
                                textFieldUp: textFieldUp.value,
                                scrollController: scrollController,
                                context: context,
                              ),
                            ),
                      Builder(builder: (context) {
                        if (textFieldUp.value) {
                          return const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 0,
                            ),
                          );
                        }
                        if (showHeader.value) {
                          return const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 45,
                            ),
                          );
                        }
                        return MediaQuery.removePadding(
                          removeBottom: true,
                          removeTop: true,
                          context: context,
                          child: const SliverAppBar(
                            primary: false,
                            backgroundColor: Colors.black,
                            title: SizedBox(
                              width: double.infinity,
                              height: 25,
                              child: Text(
                                'Weather Forecaster',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: WeatherPersistentHeaderDelegate(
                          needOpacity: showHeader,
                          context: context,
                          textFieldUp: textFieldUp,
                          textController: textEditingController,
                          focusNode: focusNode,
                        ),
                      ),
                      ValueListenableBuilder(
                          valueListenable: isFirst,
                          builder: (context, _, __) {
                            return SliverToBoxAdapter(
                              child: isFirst.value ||
                                      textEditingController.text.isEmpty
                                  ? const ErrorDisplay(
                                      icon: Icons.location_searching_rounded,
                                      mainMessage: "Hello!",
                                      message:
                                          "Type in a location to get weather forecast.")
                                  : WeatherResultDisplay(
                                      location: textEditingController.text,
                                    ),
                            );
                          })
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
