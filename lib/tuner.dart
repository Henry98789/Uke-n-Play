import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'custom_text.dart';

class Tuner extends StatefulWidget {
  const Tuner({super.key});

  @override
  State<Tuner> createState() => _TunerState();
}

class _TunerState extends State<Tuner> {
  final AudioPlayer _player = AudioPlayer();
  String? _activeButton; // Track which button is active

  final List<Map<String, dynamic>> _buttons = [
    {'label': 'g', 'color': Colors.blue, 'sound': 'tuning_g'},
    {'label': 'C', 'color': Colors.red, 'sound': 'tuning_C'},
    {'label': 'E', 'color': Colors.green, 'sound': 'tuning_E'},
    {'label': 'A', 'color': Colors.yellow, 'sound': 'tuning_A'},
  ];

  Future<void> playSound(String soundLabel) async {
    try {
      await _player.stop();
      await _player.play(AssetSource('sounds/$soundLabel.wav'));

      setState(() {
        _activeButton = soundLabel;
      });

      // Reset highlight after 500ms
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        setState(() {
          _activeButton = null;
        });
      }
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Widget _buildTuneButton(String stringLabel, Color color, String soundLabel) {
    final isActive = _activeButton == soundLabel;

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.8),
                      blurRadius: 12,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ),
          child: ElevatedButton(
            onPressed: () => playSound(soundLabel),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            child: Text(
              stringLabel,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$stringLabel String',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 106, 151, 255),
        title: const Text("Ukulele Tuner"),
      ),
      backgroundColor: const Color.fromARGB(255, 153, 183, 255),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                myText: 'Time to tune your Ukulele!',
                containerColor: Colors.lightBlue,
                textColor: Colors.white,
              ),
              const SizedBox(height: 20),

              // Your image
              Image.asset(
                'assets/images/ukulele_tuner_guide.png',
                width: 550,
                height: 350,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),

              // GCEA buttons
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: _buttons
                    .map((btn) => _buildTuneButton(
                          btn['label'],
                          btn['color'],
                          btn['sound'],
                        ))
                    .toList(),
              ),

              const SizedBox(height: 40),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Tap a coloured button to play the note for its string. Then pluck your ukulele string and adjust the tuning peg until it matches the sound. \n✅Tip: Tune slowly and listen carefully!',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
