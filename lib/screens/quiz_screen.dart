import 'package:flutter/material.dart';
import '../data/questions_data.dart';
import '../widgets/progress_header.dart';
import '../widgets/option_button.dart';
import '../providers/theme_provider.dart';
import 'welcome_screen.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String userName;
  final ThemeProvider themeProvider;
  
  const QuizScreen({
    super.key, 
    required this.userName,
    required this.themeProvider,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int? selectedAnswer;
  List<int?> userAnswers = List.filled(questions.length, null);

  void nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        userAnswers[currentQuestion] = selectedAnswer;
        currentQuestion++;
        selectedAnswer = userAnswers[currentQuestion];
      });
    } else {
      userAnswers[currentQuestion] = selectedAnswer;
      int correctCount = 0;
      for (int i = 0; i < questions.length; i++) {
        if (userAnswers[i] == questions[i].correctAnswer) {
          correctCount++;
        }
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            userName: widget.userName,
            correctAnswers: correctCount,
            totalQuestions: questions.length,
            userAnswers: userAnswers,
            themeProvider: widget.themeProvider,
          ),
        ),
      );
    }
  }

  void previousQuestion() {
    if (currentQuestion > 0) {
      setState(() {
        userAnswers[currentQuestion] = selectedAnswer;
        currentQuestion--;
        selectedAnswer = userAnswers[currentQuestion];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];
    final progress = (currentQuestion + 1) / questions.length;
    final theme = Theme.of(context);
    final isDarkMode = widget.themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: theme.colorScheme.onBackground),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(
                  themeProvider: widget.themeProvider,
                ),
              ),
            );
          },
        ),
        title: Text(
          'Kuis Seru',
          style: TextStyle(
            color: theme.colorScheme.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ProgressHeader(
                currentQuestion: currentQuestion + 1,
                totalQuestions: questions.length,
                progress: progress,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.question,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ...List.generate(
                      question.options.length,
                      (index) => OptionButton(
                        text: question.options[index],
                        isSelected: selectedAnswer == index,
                        onTap: () {
                          setState(() {
                            selectedAnswer = index;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  if (currentQuestion > 0)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: previousQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode 
                              ? const Color(0xFF1E1E1E) 
                              : Colors.white,
                          foregroundColor: theme.colorScheme.onSurface,
                        ),
                        child: const Text('Sebelumnya'),
                      ),
                    ),
                  if (currentQuestion > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: currentQuestion > 0 ? 1 : 2,
                    child: ElevatedButton(
                      onPressed: selectedAnswer != null ? nextQuestion : null,
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: Colors.grey[400],
                      ),
                      child: Text(
                        currentQuestion < questions.length - 1
                            ? 'Selanjutnya'
                            : 'Selesai',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}