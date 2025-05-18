import 'package:flutter/material.dart'; // importing Flutter's material design package
import 'dart:developer'; // import for log() function recommended instead of 'print'

// importing external files
import 'custom_text.dart';
import 'custom_boxed_text.dart';
import 'app_overview.dart';
import 'tuner.dart'; // Make sure this file and widget exist
import 'chords.dart'; // if chords screen exists

void main() {
  runApp(const MyApp()); // launches the app with MyApp widget
}

// Root app widget that sets up navigation
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Uke 'n' Play",
      debugShowCheckedModeBanner: false, // disables debug banner
      initialRoute: '/', // sets the initial route
      routes: {
        '/': (context) => const HomeScreen(), // home page
        '/appOverview': (context) => const AppOverview(), // overview page
        '/tuner': (context) =>
            const Tuner(), // tuner page (you must define Tuner widget)
        '/chords': (context) => const ChordsPage(), // optional chords page
      },
    );
  }
}

// Home screen UI (moved from previous MaterialApp's home)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 106, 151, 255),
        title: const Text("Uke 'n' Play"),
      ),
      backgroundColor: const Color.fromARGB(255, 153, 183, 255),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // centers the widgets vertically
              children: [
                // custom text widget with colored container
                const CustomText(
                  myText: 'Meshtro presents...',
                  containerColor: Colors.lightBlue,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 20), // Adds spacing between widgets
                Image.asset(
                  'assets/images/welcome_image.gif',
                  height: 150, // adjust height as needed
                ),
                const SizedBox(height: 20), // spacing
                const CustomBoxedText(), // "The best beginner experience"
              ],
            ),
            const Positioned(
              // Position the button over the CustomBoxedText
              bottom: 50, // Adjust vertical position
              left: 0,
              right: 0, // Center horizontally
              child: Center(
                child: ButtonWidget(), // displays the navigation button
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Button that navigates to the App Overview screen
class ButtonWidget extends StatefulWidget {
  const ButtonWidget({super.key});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  void _onPressed() {
    Navigator.pushNamed(context, '/appOverview'); // named route navigation
    log('Button Pressed, Navigating to "App Overview"'); // logs when the button is clicked
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed, // underscore means private to this file
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(220, 50), // set button width and height
      ).copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return states.contains(MaterialState.pressed)
              ? Colors.green // color when pressed
              : Colors.blue; // default color
        }),
      ),
      child: const Text(
        'Alright!',
        style: TextStyle(
          fontSize: 20, // Adjust font size
          fontWeight: FontWeight.bold, // Optional: make text bold
        ),
      ),
    );
  }
}
