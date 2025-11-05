import 'package:flutter/material.dart';
import '../widgets/score_circle.dart';
import '../widgets/custom_button.dart';
import 'review_screen.dart';
import 'welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  final String userName;
  final int correctAnswers;
  final int totalQuestions;
  final List<int?> userAnswers;

  const ResultScreen({
    super.key,
    required this.userName,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final score = (correctAnswers / totalQuestions * 100).toInt();
    final wrongAnswers = totalQuestions - correctAnswers;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Responsive: Deteksi ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final horizontalPadding = isTablet ? screenWidth * 0.2 : 24.0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
        title: Text(
          'Kuis Selesai!',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              // Score Circle
              ScoreCircle(score: score),
              
              const SizedBox(height: 32),
              
              // Title
              Text(
                'Kerja Bagus!',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: isTablet ? 40 : 32,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Description
              Text(
                'Anda telah menyelesaikan kuis dengan hasil\nyang sangat baik. Teruslah belajar dan\ntingkatkan pengetahuan Anda!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              
              const SizedBox(height: 32),
              
              // Statistics Cards
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.check,
                      iconColor: Colors.green,
                      label: 'Jawaban Benar',
                      value: correctAnswers.toString(),
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.close,
                      iconColor: Colors.red,
                      label: 'Jawaban Salah',
                      value: wrongAnswers.toString(),
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Review Button
              CustomButton(
                text: 'Lihat Review Jawaban',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewScreen(
                        userAnswers: userAnswers,
                      ),
                    ),
                  );
                },
                backgroundColor: isDark
                    ? Theme.of(context).primaryColor
                    : Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final bool isDark;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E1E1E)
            : Theme.of(context).primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.displayLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}