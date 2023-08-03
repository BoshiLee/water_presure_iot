import 'package:flutter/material.dart';

class TutorImage extends StatelessWidget {
  final String title;
  final String imagePath;
  final double size;
  const TutorImage(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: size,
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fitHeight,
              ),
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(25.5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xfff2f4f7),
                  blurRadius: 0.3,
                  offset: Offset(1.8, 1.8),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
