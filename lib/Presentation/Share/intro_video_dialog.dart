import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class IntroVideoDialog extends StatefulWidget {
  final String videoPath;
  final VoidCallback? onComplete;
  final bool showSkip;

  const IntroVideoDialog({
    super.key,
    required this.videoPath,
    this.onComplete,
    this.showSkip = false,
  });

  @override
  State<IntroVideoDialog> createState() => _IntroVideoDialogState();
}

class _IntroVideoDialogState extends State<IntroVideoDialog> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isClosed = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.asset(widget.videoPath);
    await _videoPlayerController!.initialize();

    // Auto-close when video finishes
    _videoPlayerController!.addListener(() {
      if (_videoPlayerController!.value.position >=
          _videoPlayerController!.value.duration) {
        if (mounted && !_isClosed) {
          _isClosed = true;
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              if (widget.onComplete != null) {
                widget.onComplete!();
              } else {
                Navigator.of(context).pop();
              }
            }
          });
        }
      }
    });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: false,
      showControls: false,
      allowFullScreen: false,
      allowMuting: false,
      allowPlaybackSpeedChanging: false,
      aspectRatio: _videoPlayerController!.value.aspectRatio,
    );
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: _chewieController != null &&
                    _videoPlayerController != null &&
                    _videoPlayerController!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController!.value.aspectRatio,
                    child: Chewie(controller: _chewieController!),
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 16,
            child: GestureDetector(
              onTap: () {
                if (!_isClosed) {
                  _isClosed = true;
                  if (widget.onComplete != null) {
                    widget.onComplete!();
                  } else {
                    Navigator.pop(context);
                  }
                }
              },
              child: widget.showSkip
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(Icons.close, color: Colors.white, size: 24),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
