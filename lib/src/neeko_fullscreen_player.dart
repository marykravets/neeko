//Copyright (c) 2019 Neeko Contributors
//
//Neeko is licensed under the Mulan PSL v1.
//
//You can use this software according to the terms and conditions of the Mulan PSL v1.
//You may obtain a copy of Mulan PSL v1 at:
//
//http://license.coscl.org.cn/MulanPSL
//
//THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR
//PURPOSE.
//
//See the Mulan PSL v1 for more details.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'base_player_widget.dart';
import 'neeko_player_helper.dart';
import 'neeko_player_options.dart';
import 'video_controller_wrapper.dart';

///Build [_FullscreenPlayer]
Widget fullScreenRoutePageBuilder(
    {required BuildContext context,
    required VideoControllerWrapper videoControllerWrapper,
    Animation<double>? animation,
    Animation<double>? secondaryAnimation,
    double aspectRatio = 16 / 9,
    double? width,
    Duration? controllerTimeout,
    Widget? bufferIndicator,
    Color? liveUIColor,
    List<Widget>? actions,
    Duration? startAt,
    Function? onSkipPrevious,
    Function? onSkipNext,
    NeekoPlayerOptions? playerOptions,
    String? tag}) {
  return _FullscreenPlayer(
    videoControllerWrapper: videoControllerWrapper,
    aspectRatio: aspectRatio,
    width: width,
    controllerTimeout: controllerTimeout,
    bufferIndicator: bufferIndicator,
    liveUIColor: liveUIColor,
    actions: actions,
    startAt: startAt,
    inFullScreen: true,
    playerOptions: playerOptions,
    onSkipPrevious: onSkipPrevious,
    onSkipNext: onSkipNext,
    tag: "com.jarvanmo.neekoPlayerHeroTag",
  );
}
//
//void pushFullScreenWidget() {
//  final TransitionRoute<void> route = PageRouteBuilder<void>(
//    settings: RouteSettings(name: "neeko", isInitialRoute: false),
//    pageBuilder: fullScreenRoutePageBuilder,
//  );
//
//  route.completed.then((void value) {
////      controller.setVolume(0.0);
//  });
//
////    controller.setVolume(1.0);
//  Navigator.of(context).push(route);
//}

class _FullscreenPlayer extends BasePlayerWidget {

  _FullscreenPlayer( {Key? key,
    videoControllerWrapper,
    playerOptions,
    width,
    controllerTimeout,
    bufferIndicator,
    liveUIColor,
    aspectRatio,
    actions,
    startAt,
    inFullScreen,
    onSkipPrevious,
    onSkipNext,
    progressBarPlayedColor = Colors.amber,
    progressBarBufferedColor = Colors.amberAccent,
    progressBarHandleColor = Colors.orangeAccent,
    progressBarBackgroundColor = Colors.grey,
    tag})
      : super(key: key,
      videoControllerWrapper: videoControllerWrapper,
      playerOptions: playerOptions,
      controllerTimeout: controllerTimeout,
      bufferIndicator: bufferIndicator,
      liveUIColor: liveUIColor,
      aspectRatio: aspectRatio,
      width: width,
      actions: actions,
      startAt: startAt,
      inFullScreen: inFullScreen,
      onSkipPrevious: onSkipPrevious,
      onSkipNext: onSkipNext,
      progressBarPlayedColor: progressBarPlayedColor,
      progressBarBufferedColor: progressBarBufferedColor,
      progressBarHandleColor: progressBarHandleColor,
      progressBarBackgroundColor: progressBarBackgroundColor,
      tag: tag
  );

  @override
  __FullscreenPlayerState createState() => __FullscreenPlayerState();
}

class __FullscreenPlayerState extends State<_FullscreenPlayer> {
  VideoPlayerController? get controller =>
      widget.videoControllerWrapper!.controller;

  final _showControllers = ValueNotifier<bool>(false);

  Timer? _timer;

  VideoControllerWrapper? get videoControllerWrapper =>
      widget.videoControllerWrapper;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(
        widget.playerOptions!.enabledSystemUIOverlaysWhenEnterLandscape);
    SystemChrome.setPreferredOrientations(
        widget.playerOptions!.preferredOrientationsWhenEnterLandscape);

    _showControllers.addListener(() {
      _timer?.cancel();
      if (_showControllers.value) {
        _timer = Timer(
          widget.controllerTimeout,
          () => _showControllers.value = false,
        );
      }
    });

    controller?.addListener(() {
      if (mounted) {
        setState(() {
//          _autoPlay();
        });
      }
    });

    widget.videoControllerWrapper!.addListener(() {
      controller!.addListener(() {
        if (mounted) {
          setState(() {
//          _autoPlay();
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    SystemChrome.setEnabledSystemUIOverlays(
        widget.playerOptions!.enabledSystemUIOverlaysWhenExitLandscape);
    SystemChrome.setPreferredOrientations(
        widget.playerOptions!.preferredOrientationsWhenExitLandscape);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final helper = NeekoPlayerHelper(context);

    return Material(
      color: Colors.black,
      child: SafeArea(
        child: Center(
          child: helper.buildHero(this, _showControllers),
        ),
      ),
    );
  }
}
