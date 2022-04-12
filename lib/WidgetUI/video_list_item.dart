import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoListItem extends StatefulWidget {
  final VideoPlayerController? videoPlayerController;
  final bool? looping;

  const VideoListItem({
    @required this.videoPlayerController,
    this.looping,
    Key? key,
  }) : super(key: key);

  @override
  _VideoListItemState createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  ChewieController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = ChewieController(
      videoPlayerController: widget.videoPlayerController!,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: widget.looping!,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: _controller!,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController!.dispose();
    _controller!.dispose();
  }
}