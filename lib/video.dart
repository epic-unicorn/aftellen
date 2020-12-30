import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController _controller;
  Duration videoLength;
  Duration videoPosition;
  double volume = 0.5;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://learndelphi.org/wp-content/uploads/revslider/enside-1/fireworks.mp4')
      ..initialize().then((_) {
        _controller.setVolume(0);
        _controller.setLooping(true);
        _controller.play();

        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.value.initialized) {
      Timer(Duration(seconds: 2), () {
        _controller.setVolume(100);
      });
    }
    return Expanded(
      child: _controller.value.initialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
