import 'package:flutter/material.dart';

class ProgressHeader extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  final double progress;

  const ProgressHeader({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pertanyaan $currentQuestion dari $totalQuestions',
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onBackground,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}% Selesai',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.primaryColor,
            ),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}