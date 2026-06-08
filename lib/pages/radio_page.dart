import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/mock_data.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  int _currentIndex = -1;
  bool _isPlaying = false;

  void _playPause(int index) {
    HapticFeedback.heavyImpact();
    setState(() {
      if (_currentIndex == index && _isPlaying) {
        _isPlaying = false;
      } else {
        _currentIndex = index;
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('粤曲老歌电台')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: MockData.songs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final song = MockData.songs[index];
            final isActive = _currentIndex == index && _isPlaying;
            return GestureDetector(
              onLongPressStart: (_) {
                HapticFeedback.heavyImpact();
              },
              onLongPressEnd: (_) {
                _playPause(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFFC62828) : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isActive ? const Color(0xFFC62828) : const Color(0xFFE0E0E0),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isActive ? Icons.pause_circle : Icons.play_circle,
                          size: 48,
                          color: isActive ? Colors.white : const Color(0xFFC62828),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song['title']!,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: isActive ? Colors.white : Colors.black,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                song['artist']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: isActive ? Colors.white70 : const Color(0xFF888888),
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isActive) ...[
                      const SizedBox(height: 20),
                      Text(
                        song['description']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 1.8,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const LinearProgressIndicator(
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        minHeight: 6,
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}