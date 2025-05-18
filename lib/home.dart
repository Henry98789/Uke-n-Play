import 'package:flutter/material.dart';
import 'lesson_details_page.dart';
import 'song_details_page.dart';

// The main Home widget with LESSONS and SONGS tabs
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List of ukulele lessons
  final List<Map<String, dynamic>> lessons = [
    {
      'title': 'Technique 1: \nHolding your Ukulele',
      'isCompleted': true,
      'isLocked': false,
      'videoAssetPath': 'assets/videos/lesson1.mp4',
    },
    {
      'title': 'Technique 2: \nParts of your Ukulele',
      'isCompleted': false,
      'isLocked': true,
      'videoAssetPath': 'assets/videos/lesson2.mp4',
    },
    {
      'title': 'Technique 3: \nTuning your ukulele',
      'isCompleted': false,
      'isLocked': true,
      'videoAssetPath': 'assets/videos/lesson3.mp4',
    },
    {
      'title': 'Technique 4: \nStrumming your first chord (C Major)',
      'isCompleted': false,
      'isLocked': true,
      'videoAssetPath': 'assets/videos/lesson4.mp4',
    },
    {
      'title': 'Technique 5: \nStrumming more chords! (C, Am, F)',
      'isCompleted': false,
      'isLocked': true,
      'videoAssetPath': 'assets/videos/lesson5.mp4',
    },
    {
      'title':
          'Technique 6: \nPlay your first song! ("Thunder by Imagine Dragons")',
      'isCompleted': false,
      'isLocked': true,
      'videoAssetPath': 'assets/videos/lesson6.mp4',
    },
  ];

  // List of songs (no unlocking logic needed)
  final List<Map<String, dynamic>> songs = [
    {
      'title': 'CHIHIRO',
      'artist': 'Billie Eilish',
      'imagePath': 'assets/images/chihiro_album.png',
      'videoAssetPath': 'assets/videos/song_chihiro.mp4',
      'isCompleted': false,
    },
    {
      'title': 'Under The Influence',
      'artist': 'Chris Brown',
      'imagePath': 'assets/images/under_the_influence_album.jpg',
      'videoAssetPath': 'assets/videos/song_uti.mp4',
      'isCompleted': false,
    },
    {
      'title': 'Cupid',
      'artist': 'FIFTY FIFTY',
      'imagePath': 'assets/images/cupid_album.png',
      'videoAssetPath': 'assets/videos/song_cupid.mp4',
      'isCompleted': false,
    },
    {
      'title': 'Happy Birthday To You (In The Key of G)',
      'artist': 'Unknown',
      'imagePath': 'assets/images/happy_birthday_album.png',
      'videoAssetPath': 'assets/videos/song_happybirthday.mp4',
      'isCompleted': false,
    },
    {
      'title': 'Thunder',
      'artist': 'Imagine Dragons',
      'imagePath': 'assets/images/thunder_album.jpg',
      'videoAssetPath': 'assets/videos/song_thunder.mp4',
      'isCompleted': false,
    },
    {
      'title': 'Flowers',
      'artist': 'Miley Cyrus',
      'imagePath': 'assets/images/flowers_album.jpg',
      'videoAssetPath': 'assets/videos/song_flowers.mp4',
      'isCompleted': false,
    },
    {
      'title': 'Espresso',
      'artist': 'Sabrina Carpenter',
      'imagePath': 'assets/images/espresso_album.jpg',
      'videoAssetPath': 'assets/videos/song_espresso.mp4',
      'isCompleted': false,
    },
    {
      'title': 'Young, Wild & Free (feat. Bruno Mars)',
      'artist': 'Snoop Dogg & Wiz Khalifa',
      'imagePath': 'assets/images/young_wild_free_album.jpg',
      'videoAssetPath': 'assets/videos/song_young_wild_free.mp4',
      'isCompleted': false,
    },
    {
      'title': 'I Don’t Wanna Live Forever',
      'artist': 'ZAYN & Taylor Swift',
      'imagePath': 'assets/images/idwlf_album.jpg',
      'videoAssetPath': 'assets/videos/song_idwlf.mp4',
      'isCompleted': false,
    },
    {
      'title': 'Twinkle Twinkle Little Star (In The Key of C Major)',
      'artist': 'Unknown',
      'imagePath': 'assets/images/twinkle_album.jpg',
      'videoAssetPath': 'assets/videos/song_twinkle.mp4',
      'isCompleted': false,
    },
  ];

  void _markLessonCompleteAndUnlockNext(int index) {
    setState(() {
      lessons[index]['isCompleted'] = true;
      if (index + 1 < lessons.length) {
        lessons[index + 1]['isLocked'] = false;
      }
    });
  }

  void _markSongComplete(int index) {
    setState(() {
      songs[index]['isCompleted'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 106, 151, 255),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.settings),
              Row(
                children: [
                  Icon(Icons.whatshot),
                  SizedBox(width: 4),
                  Text('2'),
                  SizedBox(width: 12),
                  Icon(Icons.emoji_events),
                  SizedBox(width: 4),
                  Text('1'),
                  SizedBox(width: 12),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/icons/bear_mascot.png'),
                    radius: 16,
                  ),
                  SizedBox(width: 8),
                  Text('User123'),
                ],
              ),
            ],
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'LESSONS'),
              Tab(text: 'SONGS'),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 153, 183, 255),
        body: TabBarView(
          children: [
            // LESSONS
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const Text(
                  'INTRODUCTION',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...lessons.asMap().entries.map((entry) {
                  int index = entry.key;
                  var lesson = entry.value;
                  return LessonCard(
                    title: lesson['title'],
                    isCompleted: lesson['isCompleted'],
                    isLocked: lesson['isLocked'],
                    videoAssetPath: lesson['videoAssetPath'],
                    onLessonCompleted: () {
                      _markLessonCompleteAndUnlockNext(index);
                    },
                  );
                }),
              ],
            ),
            // SONGS
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const Text(
                  '🎵Easy songs to play right now!✨',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...songs.asMap().entries.map((entry) {
                  int index = entry.key;
                  var song = entry.value;
                  return SongCard(
                    title: song['title'],
                    artist: song['artist'],
                    imagePath: song['imagePath'],
                    isCompleted: song['isCompleted'],
                    videoAssetPath: song['videoAssetPath'],
                    onSongCompleted: () {
                      _markSongComplete(index);
                    },
                  );
                }),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/tuner');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/chords');
            } else if (index == 3) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/appOverview', (route) => false);
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.tune), label: 'Tuner'),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_music), label: 'Chords'),
            BottomNavigationBarItem(
                icon: Icon(Icons.exit_to_app), label: 'Overview'),
          ],
        ),
      ),
    );
  }
}

// LESSON CARD WIDGET
class LessonCard extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final bool isLocked;
  final String videoAssetPath;
  final VoidCallback onLessonCompleted;

  const LessonCard({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.isLocked,
    required this.videoAssetPath,
    required this.onLessonCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          isCompleted ? Icons.star : Icons.star_border,
          color: isCompleted ? Colors.amber : Colors.grey,
        ),
        title: Text(title),
        trailing: isLocked
            ? const Icon(Icons.lock, color: Colors.red)
            : const Icon(Icons.play_arrow),
        onTap: isLocked
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonDetailsPage(
                      title: title,
                      videoAssetPath: videoAssetPath,
                      onLessonCompleted: onLessonCompleted,
                    ),
                  ),
                );
              },
      ),
    );
  }
}

// SONG CARD WIDGET
class SongCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imagePath;
  final bool isCompleted;
  final String videoAssetPath;
  final VoidCallback onSongCompleted;

  const SongCard({
    super.key,
    required this.title,
    required this.artist,
    required this.imagePath,
    required this.isCompleted,
    required this.videoAssetPath,
    required this.onSongCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(title),
        subtitle: Text(artist),
        trailing: Icon(
          isCompleted ? Icons.star : Icons.star_border,
          color: isCompleted ? Colors.amber : Colors.grey,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SongDetailsPage(
                title: title,
                artist: artist,
                videoAssetPath: videoAssetPath,
                onSongCompleted: onSongCompleted,
              ),
            ),
          );
        },
      ),
    );
  }
}
