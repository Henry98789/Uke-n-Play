import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LessonDetailsPage extends StatefulWidget {
  final String title;
  final String videoAssetPath;
  final VoidCallback onLessonCompleted;

  const LessonDetailsPage({
    super.key,
    required this.title,
    required this.videoAssetPath,
    required this.onLessonCompleted,
  });

  @override
  State<LessonDetailsPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailsPage> {
  late VideoPlayerController _controller;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoAssetPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();

        // Listen to progress
        _controller.addListener(() {
          if (_controller.value.isInitialized) {
            final position = _controller.value.position.inMilliseconds;
            final duration = _controller.value.duration.inMilliseconds;
            if (duration > 0) {
              setState(() {
                _progress = position / duration;
              });
            }
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get isCompleted => _progress >= 0.98; // ≥98% = done

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _controller.value.isInitialized
          ? Column(
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Colors.blue,
                    backgroundColor: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Text('${(_progress * 100).toStringAsFixed(0)}% watched'),
                const Spacer(),
                if (isCompleted)
                  ElevatedButton(
                    onPressed: () {
                      widget.onLessonCompleted();
                      Navigator.pop(context);
                    },
                    child: const Text('Done'),
                  )
                else
                  const Text(
                      'Please watch the full video to complete the lesson.'),
                const SizedBox(height: 24),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
