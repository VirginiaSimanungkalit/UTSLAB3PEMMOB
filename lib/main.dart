import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuis Pilihan Ganda',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
      ),
      home: const WelcomeScreen(),
    );
  }
}

// Model untuk pertanyaan
class Question {
  final String question;
  final List<String> options;
  final int correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

// Data pertanyaan
final List<Question> questions = [
  Question(
    question: 'Apa kepanjangan dari HTML?',
    options: [
      'A. Hyper Text Markup Language',
      'B. High Tech Modern Language',
      'C. Home Tool Markup Language',
      'D. Hyperlinks and Text Markup Language'
    ],
    correctAnswer: 0,
  ),
  Question(
    question: 'Manakah dari berikut ini yang merupakan bahasa pemrograman?',
    options: ['A. HTML', 'B. Python', 'C. CSS', 'D. XML'],
    correctAnswer: 1,
  ),
  Question(
    question: 'Apa ibukota dari negara Indonesia?',
    options: ['A. Jakarta', 'B. Bandung', 'C. Surabaya', 'D. Medan'],
    correctAnswer: 0,
  ),
  Question(
    question: 'Siapakah penemu bola lampu?',
    options: [
      'A. Albert Einstein',
      'B. Thomas Edison',
      'C. Nikola Tesla',
      'D. Isaac Newton'
    ],
    correctAnswer: 1,
  ),
  Question(
    question: 'Berapa hasil dari 15 + 25?',
    options: ['A. 30', 'B. 35', 'C. 40', 'D. 45'],
    correctAnswer: 2,
  ),
  Question(
    question: 'Planet terbesar di tata surya adalah?',
    options: ['A. Mars', 'B. Saturnus', 'C. Jupiter', 'D. Uranus'],
    correctAnswer: 2,
  ),
  Question(
    question: 'Apa simbol kimia untuk air?',
    options: ['A. O2', 'B. H2O', 'C. CO2', 'D. H2'],
    correctAnswer: 1,
  ),
  Question(
    question: 'Berapa jumlah hari dalam setahun?',
    options: ['A. 360', 'B. 364', 'C. 365', 'D. 366'],
    correctAnswer: 2,
  ),
  Question(
    question: 'Apa warna bendera Indonesia?',
    options: [
      'A. Biru dan Putih',
      'B. Merah dan Putih',
      'C. Hijau dan Putih',
      'D. Kuning dan Merah'
    ],
    correctAnswer: 1,
  ),
  Question(
    question: 'Siapa presiden pertama Indonesia?',
    options: ['A. Soekarno', 'B. Soeharto', 'C. Habibie', 'D. Megawati'],
    correctAnswer: 0,
  ),
];

// Welcome Screen
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.orange[300],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.quiz,
                  size: 60,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Selamat Datang di\nKuis!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Masukkan nama Anda untuk\nmemulai petualangan\npengetahuan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nama Panggilan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Contoh: Budi',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.trim().isNotEmpty) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(
                            userName: _nameController.text.trim(),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Mulai',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Quiz Screen
class QuizScreen extends StatefulWidget {
  final String userName;
  const QuizScreen({super.key, required this.userName});

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

    return Scaffold(
      backgroundColor: const Color(0xFFF5E6D3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5E6D3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
        title: const Text(
          'Kuis Seru',
          style: TextStyle(
            color: Colors.black87,
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pertanyaan ${currentQuestion + 1} dari ${questions.length}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}% Selesai',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
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
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.black87,
                      ),
                      minHeight: 8,
                    ),
                  ),
                ],
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
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ...List.generate(
                      question.options.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedAnswer = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: selectedAnswer == index
                                  ? Colors.black87
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    question.options[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: selectedAnswer == index
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Sebelumnya',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (currentQuestion > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: currentQuestion > 0 ? 1 : 2,
                    child: ElevatedButton(
                      onPressed: selectedAnswer != null ? nextQuestion : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        disabledBackgroundColor: Colors.grey[400],
                      ),
                      child: Text(
                        currentQuestion < questions.length - 1
                            ? 'Selanjutnya'
                            : 'Selesai',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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

// Result Screen
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

    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
        title: const Text(
          'Kuis Selesai!',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: score / 100,
                      strokeWidth: 12,
                      backgroundColor: Colors.orange[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.black87,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'Skor Anda',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '$score',
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Kerja Bagus!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Anda telah menyelesaikan kuis dengan hasil\nyang sangat baik. Teruslah belajar dan\ntingkatkan pengetahuan Anda!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87.withOpacity(0.8),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.orange[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green[300],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Jawaban Benar',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$correctAnswers',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.orange[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Jawaban Salah',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$wrongAnswers',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Lihat Review Jawaban',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Review Screen
class ReviewScreen extends StatelessWidget {
  final List<int?> userAnswers;

  const ReviewScreen({super.key, required this.userAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E6D3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5E6D3),
        elevation: 0,
        title: const Text(
          'Review Jawaban',
          style: TextStyle(
            color: Colors.black87,
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

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isCorrect ? Colors.green[100] : Colors.red[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isCorrect ? Icons.check : Icons.close,
                        color: isCorrect ? Colors.green[700] : Colors.red[700],
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${question.question}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isCorrect
                                  ? Colors.green[50]
                                  : Colors.red[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isCorrect ? Icons.check : Icons.close,
                                  size: 16,
                                  color: isCorrect
                                      ? Colors.green[700]
                                      : Colors.red[700],
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  isCorrect ? 'Benar' : 'Salah',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isCorrect
                                        ? Colors.green[700]
                                        : Colors.red[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Jawaban: ${question.options[question.correctAnswer]}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB85C3F),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Kembali ke Beranda',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}