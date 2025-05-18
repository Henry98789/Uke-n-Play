import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'home.dart';

/// AppOverview shows a YouTube tutorial video explaining how to use the app.
/// Includes a "Skip" button that takes the user to the Home screen.
class AppOverview extends StatefulWidget {
  const AppOverview({super.key});

  @override
  State<AppOverview> createState() => _AppOverviewState();
}

class _AppOverviewState extends State<AppOverview> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the YouTube video player controller with a specific video ID
    _controller = YoutubePlayerController(
      initialVideoId: 'ByzrIcP5Mbs', // Replace with your YouTube video ID
      flags: const YoutubePlayerFlags(
        autoPlay: false, // Do not autoplay when screen loads
        mute: false, // Do not mute the video
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 106, 151, 255),
        title: const Text('Uke \'n\' Play: App Overview'),
      ),
      backgroundColor: const Color.fromARGB(255, 153, 183, 255),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Learn how to use the APP with this video:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // YouTube video player widget
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),

            const SizedBox(height: 30),

            // Skip button to go to Home screen
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Button background
                foregroundColor: Colors.blue, // Button text color
              ),
              child: const Text('Skip'),
            ),
          ],
        ),
      ),
    );
  }
}
