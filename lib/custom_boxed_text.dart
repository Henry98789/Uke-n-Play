import 'package:flutter/material.dart';

// Flutter-provided Stateless format
class CustomBoxedText extends StatelessWidget {
  const CustomBoxedText({super.key}); // constructor is same name as class

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // centers the text vertically
      children: [
        const Text(
          "The best beginner experience!",
          style: TextStyle(
            color: Color.fromARGB(255, 65, 82, 104),
            fontSize: 18,
            fontWeight: FontWeight.bold, // makes text bold
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 20), // Adding padding inside the box
          decoration: BoxDecoration(
            color: Colors.white, // white background of box
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), //adding shadow effect
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Column(
            children: [
              Text(
                "WELCOME!",
                style: TextStyle(
                  color: Color.fromARGB(255, 65, 82, 104),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Impress your friends with your \nukulele skills – fast! \n\nUke 'n' Play makes learning easy \nwith beginner-friendly lessons \nand popular songs you’ll love. \n\nStart strumming, tuning, and playing today – even if you’ve never touched a ukulele before. \n\nYou Can Play!\n\n\n",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18, // smaller text font size
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
