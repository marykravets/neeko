import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class BasePlayerWidget extends StatefulWidget {

  final VideoControllerWrapper? videoControllerWrapper;

  final NeekoPlayerOptions? playerOptions;

  /// Defines the width of the player.
  /// Default = Devices's Width
  final double? width;

  ///The duration for which controls in the player will be visible.
  ///default 3 seconds
  final Duration controllerTimeout;

  /// Overrides the default buffering indicator for the player.
  final Widget? bufferIndicator;

  final Color? liveUIColor;

  /// Defines the aspect ratio to be assigned to the player. This property along with [width] calculates the player size.
  /// Default = 16/9
  final double aspectRatio;

  /// Adds custom top bar widgets
  final List<Widget>? actions;

  /// Video starts playing from the duration provided.
  final Duration startAt;

  final bool inFullScreen;

  final Function? onPortraitBackTap;

  final Function? onSkipPrevious;
  final Function? onSkipNext;

  final Color? progressBarPlayedColor;
  final Color? progressBarBufferedColor;
  final Color? progressBarHandleColor;
  final Color? progressBarBackgroundColor;

  final String? tag;

  BasePlayerWidget({Key? key,
    this.videoControllerWrapper,
    this.playerOptions = const NeekoPlayerOptions(),
    this.width = 100,
    this.controllerTimeout = const Duration(seconds: 3),
    this.bufferIndicator,
    this.liveUIColor,
    this.aspectRatio = 16 / 9,
    this.actions,
    this.startAt = const Duration(seconds: 0),
    this.inFullScreen = false,
    this.onPortraitBackTap,
    this.onSkipPrevious,
    this.onSkipNext,
    this.progressBarPlayedColor,
    this.progressBarBufferedColor,
    this.progressBarHandleColor,
    this.progressBarBackgroundColor,
    this.tag})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BasePlayerWidgetState();
  }
}

class BasePlayerWidgetState extends State<BasePlayerWidget> {

  @override
  Widget build(BuildContext context) {
    return Material();
  }
}