import 'package:flutter/material.dart';

class ChordsPage extends StatefulWidget {
  const ChordsPage({super.key});

  @override
  State<ChordsPage> createState() => _ChordsPageState();
}

class _ChordsPageState extends State<ChordsPage> {
  bool _isMinimized = false;

  final Map<String, List<String>> chordSections = {
    'Major Chords': ['C', 'D', 'E', 'F', 'G'],
    'Minor Chords': ['Am', 'Bm', 'Dm', 'Em'],
    '7th Chords': ['A7', 'D7', 'G7'],
    'Major 7th Chords': ['Cmaj7'],
    'Minor 7th Chords': ['Bm7', 'Am7', 'Em7'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ukulele Chords'),
        backgroundColor: const Color.fromARGB(255, 106, 151, 255),
      ),
      backgroundColor: const Color.fromARGB(255, 153, 183, 255),
      body: Stack(
        children: [
          // Scrollable chord list with section headers
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: chordSections.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section header
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    // Chord tiles
                    ...entry.value.map((chord) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 12.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AspectRatio(
                                  aspectRatio: 2 / 2,
                                  child: Image.asset(
                                    'assets/images/$chord.png',
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                          Icons.image_not_supported,
                                          size: 50);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                chord,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
            ),
          ),

          // Floating image at bottom right with tap to minimize
          Positioned(
            bottom: 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isMinimized = !_isMinimized;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _isMinimized ? 80 : 200,
                height: _isMinimized ? 80 : 200,
                child: Image.asset(
                  'assets/images/LeftHandFingerMap.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
