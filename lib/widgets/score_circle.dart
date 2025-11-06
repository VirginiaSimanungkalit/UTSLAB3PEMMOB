import 'package:flutter/material.dart';

class ScoreCircle extends StatelessWidget {
  final int score;

  const ScoreCircle({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            value: score / 100,
            strokeWidth: 12,
            backgroundColor: isDarkMode 
                ? const Color(0xFF1E1E1E) 
                : Colors.orange[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              'Skor Anda',
              style: TextStyle(
                fontSize: 18,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            Text(
              '$score',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}