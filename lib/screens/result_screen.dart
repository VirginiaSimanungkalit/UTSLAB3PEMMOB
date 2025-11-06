import 'package:flutter/material.dart';
import '../widgets/score_circle.dart';
import '../widgets/stat_card.dart';
import '../providers/theme_provider.dart';
import 'welcome_screen.dart';
import 'review_screen.dart';

class ResultScreen extends StatelessWidget {
  final String userName;
  final int correctAnswers;
  final int totalQuestions;
  final List<int?> userAnswers;
  final ThemeProvider themeProvider;

  const ResultScreen({
    super.key,
    required this.userName,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.userAnswers,
    required this.themeProvider,
  });

  // Fungsi untuk mendapatkan judul berdasarkan skor
  String _getTitle() {
    if (correctAnswers >= 6) {
      return 'Kerja Bagus!';
    } else {
      return 'Tetap Semangat!';
    }
  }

  // Fungsi untuk mendapatkan pesan berdasarkan skor
  String _getMessage() {
    if (correctAnswers >= 6) {
      return 'Anda telah menyelesaikan kuis dengan hasil\nyang sangat baik. Teruslah belajar dan\ntingkatkan pengetahuan Anda!';
    } else {
      return 'Jangan berkecil hati! Setiap kesalahan adalah\nkesempatan untuk belajar. Coba lagi dan\ntingkatkan skormu!';
    }
  }

  // Fungsi untuk mendapatkan emoji berdasarkan skor
  String _getEmoji() {
    if (correctAnswers >= 6) {
      return '🎉';
    } else {
      return '💪';
    }
  }

  @override
  Widget build(BuildContext context) {
    final score = (correctAnswers / totalQuestions * 100).toInt();
    final wrongAnswers = totalQuestions - correctAnswers;
    final theme = Theme.of(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close, 
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
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
        ),
        title: Text(
          'Kuis Selesai!',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView( // ← TAMBAHAN: Agar tidak overflow di layar kecil
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ScoreCircle(score: score),
                const SizedBox(height: 32),
                
                // Judul dinamis berdasarkan skor
                Text(
                  _getTitle(),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Pesan dinamis berdasarkan skor
                Text(
                  _getMessage(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode 
                        ? Colors.white70 
                        : Colors.black87.withOpacity(0.8),
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        icon: Icons.check,
                        iconColor: Colors.green[300]!,
                        label: 'Jawaban Benar',
                        value: correctAnswers,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        icon: Icons.close,
                        iconColor: Colors.red[300]!,
                        label: 'Jawaban Salah',
                        value: wrongAnswers,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewScreen(
                            userAnswers: userAnswers,
                            themeProvider: themeProvider,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.white : Colors.black87,
                      foregroundColor: isDarkMode ? Colors.black87 : Colors.white,
                    ),
                    child: const Text('Lihat Review Jawaban'),
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}