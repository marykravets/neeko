import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neeko/src/base_player_widget.dart';
import 'package:neeko/src/video_controller_widgets.dart';

import 'neeko_player.dart';

class PlayerUiWidget extends StatefulWidget {

  final BuildContext? context;
  final ValueNotifier<bool>? showControllers;
  final State<BasePlayerWidget>? state;

  const PlayerUiWidget({Key? key, this.context, this.showControllers, this.state}) : super(key: key);

  @override
  _PlayerUiWidgetState createState() => _PlayerUiWidgetState();
}

class _PlayerUiWidgetState extends State<PlayerUiWidget> {

  @override
  Widget build(BuildContext context) {

    if (widget.context == null || widget.showControllers == null || widget.state == null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text("Player UI parameter(s) is null"),
      );
    }
    
    final BasePlayerWidget baseWidget = widget.state!.widget;
    
    return Hero(
      tag: baseWidget.tag ?? "",
      child: Container(
        width: baseWidget.width ?? MediaQuery.of(widget.context!).size.width,
        child: AspectRatio(
          aspectRatio: baseWidget.aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: <Widget>[
              NeekoPlayer(controllerWrapper: baseWidget.videoControllerWrapper),
              if (baseWidget.playerOptions!.useController)
                TouchShutter(
                  baseWidget.videoControllerWrapper,
                  showControllers: widget.showControllers,
                  enableDragSeek: baseWidget.playerOptions!.enableDragSeek,
                ),
              if (baseWidget.playerOptions!.useController)
                Center(
                  child: CenterControllerActionButtons(
                    baseWidget.videoControllerWrapper,
                    showControllers: widget.showControllers,
                    onSkipPrevious: baseWidget.onSkipPrevious,
                    onSkipNext: baseWidget.onSkipNext,
                    bufferIndicator: baseWidget.bufferIndicator ??
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
              if (baseWidget.playerOptions!.useController)
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: TopBar(
                      baseWidget.videoControllerWrapper,
                      showControllers: widget.showControllers,
                      options: baseWidget.playerOptions,
                      actions: baseWidget.actions,
                      isFullscreen: true,
                      onLandscapeBackTap: _pop(),
                    )),
              if (baseWidget.playerOptions!.useController)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: baseWidget.playerOptions!.isLive
                      ? LiveBottomBar(
                    baseWidget.videoControllerWrapper,
                    aspectRatio: baseWidget.aspectRatio,
                    liveUIColor: baseWidget.liveUIColor,
                    showControllers: widget.showControllers,
                    playedColor: baseWidget.progressBarPlayedColor,
                    handleColor: baseWidget.progressBarHandleColor,
                    backgroundColor:
                    baseWidget.progressBarBackgroundColor,
                    bufferedColor: baseWidget.progressBarBufferedColor,
                    isFullscreen: true,
                    onExitFullscreen: _pop(),
                  )
                      : BottomBar(
                    baseWidget.videoControllerWrapper,
                    aspectRatio: baseWidget.aspectRatio,
                    showControllers: widget.showControllers,
                    playedColor: baseWidget.progressBarPlayedColor,
                    handleColor: baseWidget.progressBarHandleColor,
                    backgroundColor:
                    baseWidget.progressBarBackgroundColor,
                    bufferedColor: baseWidget.progressBarBufferedColor,
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
    final NavigatorState state = Navigator.of(context);
    if (state.canPop()) {
      state.pop();
    }
  }
}