import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/mock_data.dart';

class CameraReaderPage extends StatefulWidget {
  const CameraReaderPage({super.key});

  @override
  State<CameraReaderPage> createState() => _CameraReaderPageState();
}

class _CameraReaderPageState extends State<CameraReaderPage> {
  String _displayText = '';
  bool _hasPhoto = false;
  bool _isReading = false;
  bool _isCantonese = true;

  void _takePhotoAndExtract() {
    HapticFeedback.heavyImpact();
    setState(() {
      _hasPhoto = true;
      _displayText = MockData.extractedText;
    });
  }

  void _speakText() {
    HapticFeedback.heavyImpact();
    setState(() => _isReading = true);

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() => _isReading = false);
      }
    });
  }

  void _toggleLanguage() {
    setState(() => _isCantonese = !_isCantonese);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('拍照大字读字'),
        actions: [
          TextButton.icon(
            onPressed: _toggleLanguage,
            icon: const Icon(Icons.language, size: 22),
            label: Text(
              _isCantonese ? '粤语' : '普通话',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: _hasPhoto ? _buildResultView() : _buildCameraView(),
      ),
    );
  }

  Widget _buildCameraView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt_rounded, size: 80, color: Color(0xFF333333)),
            const SizedBox(height: 24),
            const Text(
              '对准文字拍照\n自动识别朗读',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF666666),
                height: 1.6,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 48),
            GestureDetector(
              onLongPressStart: (_) => HapticFeedback.heavyImpact(),
              onLongPressEnd: (_) => _takePhotoAndExtract(),
              onLongPressCancel: () {},
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6A1B9A),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6A1B9A).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(Icons.camera, size: 56, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Text(
              _displayText,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                height: 1.8,
                letterSpacing: 3,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onLongPressStart: (_) => HapticFeedback.heavyImpact(),
                    onLongPressEnd: (_) => _speakText(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: _isReading ? const Color(0xFF6A1B9A) : const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isReading ? Icons.volume_up : Icons.play_arrow,
                            color: Colors.white,
                            size: 36,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _isReading
                                ? '朗读中...'
                                : '${_isCantonese ? '粤语' : '普通话'}朗读',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onLongPressStart: (_) => HapticFeedback.heavyImpact(),
                  onLongPressEnd: (_) {
                    setState(() {
                      _hasPhoto = false;
                      _displayText = '';
                      _isReading = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.refresh, size: 36, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}