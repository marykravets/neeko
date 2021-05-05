import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neeko/src/base_player_widget.dart';
import 'package:neeko/src/video_controller_widgets.dart';

import 'neeko_player.dart';

class NeekoPlayerHelper {

  late BuildContext _context;

  NeekoPlayerHelper(BuildContext context) {
    _context = context;
  }

  Hero buildHero(State<BasePlayerWidget> state, ValueNotifier<bool> showControllers) {
    
    final BasePlayerWidget widget = state.widget;
    
    return Hero(
      tag: widget.tag ?? "",
      child: Container(
        width: widget.width ?? MediaQuery.of(_context).size.width,
        child: AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: <Widget>[
              NeekoPlayer(controllerWrapper: widget.videoControllerWrapper),
              if (widget.playerOptions!.useController)
                TouchShutter(
                  widget.videoControllerWrapper,
                  showControllers: showControllers,
                  enableDragSeek: widget.playerOptions!.enableDragSeek,
                ),
              if (widget.playerOptions!.useController)
                Center(
                  child: CenterControllerActionButtons(
                    widget.videoControllerWrapper,
                    showControllers: showControllers,
                    onSkipPrevious: widget.onSkipPrevious,
                    onSkipNext: widget.onSkipNext,
                    bufferIndicator: widget.bufferIndicator ??
                        Container(
                          width: 70.0,
                          height: 70.0,
                          child: CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation(Colors.white),
                          ),
                        ),
                  ),
                ),
              if (widget.playerOptions!.useController)
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: TopBar(
                      widget.videoControllerWrapper,
                      showControllers: showControllers,
                      options: widget.playerOptions,
                      actions: widget.actions,
                      isFullscreen: true,
                      onLandscapeBackTap: _pop(),
                    )),
              if (widget.playerOptions!.useController)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: widget.playerOptions!.isLive
                      ? LiveBottomBar(
                    widget.videoControllerWrapper,
                    aspectRatio: widget.aspectRatio,
                    liveUIColor: widget.liveUIColor,
                    showControllers: showControllers,
                    playedColor: widget.progressBarPlayedColor,
                    handleColor: widget.progressBarHandleColor,
                    backgroundColor:
                    widget.progressBarBackgroundColor,
                    bufferedColor: widget.progressBarBufferedColor,
                    isFullscreen: true,
                    onExitFullscreen: _pop(),
                  )
                      : BottomBar(
                    widget.videoControllerWrapper,
                    aspectRatio: widget.aspectRatio,
                    showControllers: showControllers,
                    playedColor: widget.progressBarPlayedColor,
                    handleColor: widget.progressBarHandleColor,
                    backgroundColor:
                    widget.progressBarBackgroundColor,
                    bufferedColor: widget.progressBarBufferedColor,
                    isFullscreen: true,
                    onExitFullscreen: _pop(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _pop() {
    final NavigatorState state = Navigator.of(_context);
    if (state.canPop()) {
      state.pop();
    }
  }
}