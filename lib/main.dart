import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/clock_weather_page.dart';
import 'pages/radio_page.dart';
import 'pages/safety_page.dart';
import 'pages/newspaper_page.dart';
import 'pages/camera_reader_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ElderlyCompanionApp());
}

class ElderlyCompanionApp extends StatelessWidget {
  const ElderlyCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '荔湾老友记',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE0E0E0), width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A1A1A),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                '荔湾老友记',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 6,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '长者智能陪伴助手',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF888888),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.92,
                  children: [
                    _buildMenuCard(
                      context,
                      icon: Icons.access_time_rounded,
                      label: '大字时钟\n与天气',
                      color: Colors.black,
                      onLongPress: () => _navigateTo(context, const ClockWeatherPage()),
                    ),
                    _buildMenuCard(
                      context,
                      icon: Icons.music_note_rounded,
                      label: '粤曲老歌\n电台',
                      color: const Color(0xFFC62828),
                      onLongPress: () => _navigateTo(context, const RadioPage()),
                    ),
                    _buildMenuCard(
                      context,
                      icon: Icons.safety_check_rounded,
                      label: '出行安全\n守护',
                      color: const Color(0xFF1565C0),
                      onLongPress: () => _navigateTo(context, const SafetyPage()),
                    ),
                    _buildMenuCard(
                      context,
                      icon: Icons.newspaper_rounded,
                      label: '每日荔湾\n报纸',
                      color: const Color(0xFF2E7D32),
                      onLongPress: () => _navigateTo(context, const NewspaperPage()),
                    ),
                    _buildMenuCard(
                      context,
                      icon: Icons.camera_alt_rounded,
                      label: '拍照大字\n读字',
                      color: const Color(0xFF6A1B9A),
                      onLongPress: () => _navigateTo(context, const CameraReaderPage()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onLongPress,
  }) {
    return _LongPressCard(
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white),
            const SizedBox(height: 16),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.4,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

class _LongPressCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onLongPress;

  const _LongPressCard({required this.child, required this.onLongPress});

  @override
  State<_LongPressCard> createState() => _LongPressCardState();
}

class _LongPressCardState extends State<_LongPressCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) {
        setState(() => _isPressed = true);
        HapticFeedback.heavyImpact();
      },
      onLongPressEnd: (_) {
        setState(() => _isPressed = false);
        widget.onLongPress();
      },
      onLongPressCancel: () {
        setState(() => _isPressed = false);
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.93 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }
}