import 'package:flutter/material.dart';
import '../data/questions_data.dart';
import '../widgets/review_card.dart';
import '../providers/theme_provider.dart';
import 'welcome_screen.dart';

class ReviewScreen extends StatelessWidget {
  final List<int?> userAnswers;
  final ThemeProvider themeProvider;

  const ReviewScreen({
    super.key, 
    required this.userAnswers,
    required this.themeProvider,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Review Jawaban',
          style: TextStyle(
            color: theme.colorScheme.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          final userAnswer = userAnswers[index];
          final isCorrect = userAnswer == question.correctAnswer;

          return ReviewCard(
            question: question,
            index: index,
            isCorrect: isCorrect,
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(
                  themeProvider: themeProvider,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB85C3F),
            foregroundColor: Colors.white,
          ),
          child: const Text('Kembali ke Beranda'),
        ),
      ),
    );
  }
}