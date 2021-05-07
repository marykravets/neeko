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
import 'package:video_player/video_player.dart';

import 'base_player_widget.dart';
import 'neeko_fullscreen_player.dart';
import 'neeko_player_helper.dart';
import 'neeko_player_options.dart';
import 'video_controller_wrapper.dart';

///core video player
class NeekoPlayerWidget extends BasePlayerWidget {

  NeekoPlayerWidget(
      {Key? key,
        required videoControllerWrapper,
        playerOptions = const NeekoPlayerOptions(),
        controllerTimeout = const Duration(seconds: 3),
        bufferIndicator,
        liveUIColor = Colors.red,
        aspectRatio = 16 / 9,
        width,
        actions,
        startAt = const Duration(seconds: 0),
        inFullScreen = false,
        onPortraitBackTap,
        onSkipPrevious,
        onSkipNext,
        progressBarPlayedColor,
        progressBarBufferedColor: const Color(0xFF757575),
        progressBarHandleColor,
        progressBarBackgroundColor: const Color(0xFFF5F5F5),
        tag: "com.jarvanmo.neekoPlayerHeroTag"})
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
      onPortraitBackTap: onPortraitBackTap,
      onSkipPrevious: onSkipPrevious,
      onSkipNext: onSkipNext,
      progressBarPlayedColor: progressBarPlayedColor,
      progressBarBufferedColor: progressBarBufferedColor,
      progressBarHandleColor: progressBarHandleColor,
      progressBarBackgroundColor: progressBarBackgroundColor,
      tag: tag
  );

  @override
  _NeekoPlayerWidgetState createState() => _NeekoPlayerWidgetState();
}

class _NeekoPlayerWidgetState extends State<NeekoPlayerWidget> {
  final _showControllers = ValueNotifier<bool>(false);

  Timer? _timer;

  VideoPlayerController? get controller =>
      widget.videoControllerWrapper?.controller;

  VideoControllerWrapper? get videoControllerWrapper =>
      widget.videoControllerWrapper;

  @override
  void initState() {
    super.initState();
    _loadController();

    _addShowControllerListener();
    _listenVideoControllerWrapper();
    _configureVideoPlayer();
  }

  void _listenVideoControllerWrapper() {
    videoControllerWrapper?.addListener(() {
      if (mounted)
        setState(() {
//          _addShowControllerListener();
//          _autoPlay();
        });
    });
  }

  void _addShowControllerListener() {
    _showControllers.addListener(() {
      _timer?.cancel();
      if (_showControllers.value) {
        _timer = Timer(
          widget.controllerTimeout,
          () => _showControllers.value = false,
        );
      }
    });
  }

  void _loadController() {
//    controller = widget.videoPlayerController;
//    controller.isFullScreen = widget.inFullScreen ?? false;
//    controller.addListener(_listener);
  }

  _configureVideoPlayer() {
    if (widget.playerOptions != null) {
      _autoPlay();
    }

//    widget.videoPlayerController.setLooping(widget.playerOptions.loop);
  }

  _autoPlay() async {
    if (controller == null || controller!.value.isPlaying) {
      return;
    }

    if (controller!.value.isInitialized) {
      await controller!.seekTo(widget.startAt);
      controller!.play();
    }
  }

  @override
  void dispose() {
//    if (widget.playerOptions.autoPlay) {
//      controller.dispose();
//    }

//    _showControllers.dispose();
    controller?.dispose();
    videoControllerWrapper?.dispose();
    _timer?.cancel();
    super.dispose();
  }

//  Widget fullScreenRoutePageBuilder(
//      BuildContext context,
//      Animation<double> animation,
//      Animation<double> secondaryAnimation,
//      ) {
//    return _buildFullScreenVideo();
//  }

  void pushFullScreenWidget() {
    final TransitionRoute<void> route = PageRouteBuilder<void>(
      settings: RouteSettings(name: "neeko_full"),
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          fullScreenRoutePageBuilder(
        context: context,
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        videoControllerWrapper: widget.videoControllerWrapper ?? widget.videoControllerWrapper as VideoControllerWrapper,
        width: widget.width,
        actions: widget.actions,
        aspectRatio: widget.aspectRatio,
        bufferIndicator: widget.bufferIndicator,
        onSkipPrevious: widget.onSkipPrevious,
        onSkipNext: widget.onSkipNext,
        controllerTimeout: widget.controllerTimeout,
        playerOptions: NeekoPlayerOptions(
            enableDragSeek: widget.playerOptions?.enableDragSeek as bool,
            showFullScreenButton: widget.playerOptions?.showFullScreenButton as bool,
            autoPlay: true,
            useController: widget.playerOptions?.useController as bool,
            isLive: widget.playerOptions?.isLive as bool,
            preferredOrientationsWhenEnterLandscape:
                widget.playerOptions?.preferredOrientationsWhenEnterLandscape ?? const [],
            preferredOrientationsWhenExitLandscape:
                widget.playerOptions?.preferredOrientationsWhenExitLandscape ?? const [],
            enabledSystemUIOverlaysWhenEnterLandscape:
                widget.playerOptions?.enabledSystemUIOverlaysWhenEnterLandscape ?? const [],
            enabledSystemUIOverlaysWhenExitLandscape:
                widget.playerOptions?.enabledSystemUIOverlaysWhenExitLandscape ?? const []),
        liveUIColor: widget.liveUIColor,
      ),
    );

    route.completed.then((void value) {
//      controller.setVolume(0.0);
    });

//    controller.setVolume(1.0);
    Navigator.of(context).push(route).then((_) {
      if (mounted)
        setState(() {
          _listenVideoControllerWrapper();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
//    if (controller.isFullScreen == null) {
//      controller.isFullScreen =
//          MediaQuery.of(context).orientation == Orientation.landscape;
//    }

    return PlayerUiWidget(
        context: context,
        state: this,
        showControllers: _showControllers
    );
  }
}
