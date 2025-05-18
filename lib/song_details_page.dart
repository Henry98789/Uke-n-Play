import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SongDetailsPage extends StatefulWidget {
  final String title;
  final String artist;
  final String videoAssetPath;
  final VoidCallback onSongCompleted;

  const SongDetailsPage({
    super.key,
    required this.title,
    required this.artist,
    required this.videoAssetPath,
    required this.onSongCompleted,
  });

  @override
  State<SongDetailsPage> createState() => _SongDetailPageState();
}

class _SongDetailPageState extends State<SongDetailsPage> {
  late VideoPlayerController _controller;
  bool _showDoneButton = false;

  final List<Map<String, dynamic>> feedbackMessages = [
    {'time': Duration(seconds: 5), 'text': 'Let\'s go!'},
    {'time': Duration(seconds: 12), 'text': 'Keep strumming!'},
    {'time': Duration(seconds: 20), 'text': 'Nice rhythm!'},
    {'time': Duration(seconds: 28), 'text': 'You got this!'},
    {'time': Duration(seconds: 36), 'text': 'Good job!'},
  ];

  String _currentFeedback = '';
  int _lastShownIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoAssetPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();

        _controller.addListener(() {
          final position = _controller.value.position;

          // Show Done button when video ends
          if (position >= _controller.value.duration && !_showDoneButton) {
            setState(() {
              _showDoneButton = true;
              _currentFeedback = '';
            });
          }

          // Show encouraging messages
          for (int i = 0; i < feedbackMessages.length; i++) {
            if (position >= feedbackMessages[i]['time'] &&
                i > _lastShownIndex) {
              setState(() {
                _currentFeedback = feedbackMessages[i]['text'];
                _lastShownIndex = i;
              });
              break;
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

  double _getProgress() {
    if (!_controller.value.isInitialized ||
        _controller.value.duration.inSeconds == 0) {
      return 0;
    }
    return _controller.value.position.inMilliseconds /
        _controller.value.duration.inMilliseconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          if (_controller.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          const SizedBox(height: 16),
          Text(widget.title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(widget.artist,
              style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 16),
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Colors.blue,
              backgroundColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text('${(_getProgress() * 100).toStringAsFixed(0)}% watched'),
          if (_currentFeedback.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                _currentFeedback,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          const Spacer(),
          if (_showDoneButton)
            ElevatedButton(
              onPressed: () {
                widget.onSongCompleted();
                Navigator.pop(context, true);
              },
              child: const Text('Done'),
            )
          else
            const Text(
              'Play along from beginning to end to complete the song!',
              style: TextStyle(fontSize: 14),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
