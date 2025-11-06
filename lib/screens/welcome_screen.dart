import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import '../providers/theme_provider.dart';

class WelcomeScreen extends StatefulWidget {
  final ThemeProvider themeProvider;
  
  const WelcomeScreen({super.key, required this.themeProvider});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = widget.themeProvider.isDarkMode;
    final theme = Theme.of(context);
    
    return Scaffold(
      resizeToAvoidBottomInset: true, // ← TAMBAHKAN INI
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView( // ← TAMBAHKAN INI
          child: ConstrainedBox( // ← TAMBAHKAN INI
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 
                         MediaQuery.of(context).padding.top,
            ),
            child: IntrinsicHeight( // ← TAMBAHKAN INI
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Theme Toggle Button
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white24 : Colors.black12,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
                              onPressed: () {
                                widget.themeProvider.toggleTheme();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                isDarkMode ? 'Light' : 'Dark',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.orange[800] : Colors.orange[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.quiz,
                        size: 60,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Selamat Datang di\nKuis!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Masukkan nama Anda untuk\nmemulai petualangan\npengetahuan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Panggilan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _nameController,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Contoh: Budi',
                            hintStyle: TextStyle(
                              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                            ),
                            filled: true,
                            fillColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
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
                                  themeProvider: widget.themeProvider,
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode ? Colors.white : Colors.black87,
                          foregroundColor: isDarkMode ? Colors.black87 : Colors.white,
                        ),
                        child: const Text('Mulai'),
                      ),
                    ),
                    
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}