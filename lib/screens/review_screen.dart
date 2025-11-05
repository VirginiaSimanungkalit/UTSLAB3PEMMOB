import 'package:flutter/material.dart';
import '../data/questions_data.dart';
import '../widgets/review_card.dart';
import '../widgets/custom_button.dart';
import 'welcome_screen.dart';

class ReviewScreen extends StatelessWidget {
  final List<int?> userAnswers;

  const ReviewScreen({super.key, required this.userAnswers});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Responsive: Deteksi ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final horizontalPadding = isTablet ? screenWidth * 0.15 : 20.0;

    return Scaffold(
      backgroundColor: isDark 
          ? const Color(0xFF121212) 
          : const Color(0xFFF5E6D3),
      appBar: AppBar(
        backgroundColor: isDark 
            ? const Color(0xFF121212) 
            : const Color(0xFFF5E6D3),
        title: Text(
          'Review Jawaban',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(horizontalPadding),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                final userAnswer = userAnswers[index];
                final isCorrect = userAnswer == question.correctAnswer;

                return ReviewCard(
                  question: question,
                  questionNumber: index + 1,
                  userAnswer: userAnswer,
                  isCorrect: isCorrect,
                );
              },
            ),
          ),
          
          // Back Button
          Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: CustomButton(
              text: 'Kembali ke Beranda',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                );
              },
              backgroundColor: const Color(0xFFB85C3F),
            ),
          ),
        ],
      ),
    );
  }
}