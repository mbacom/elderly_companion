import 'package:flutter/material.dart';
import '../models/mock_data.dart';

class NewspaperPage extends StatefulWidget {
  const NewspaperPage({super.key});

  @override
  State<NewspaperPage> createState() => _NewspaperPageState();
}

class _NewspaperPageState extends State<NewspaperPage> {
  double _fontScale = 1.3;

  void _zoomIn() {
    setState(() {
      if (_fontScale < 2.5) _fontScale += 0.2;
    });
  }

  void _zoomOut() {
    setState(() {
      if (_fontScale > 1.0) _fontScale -= 0.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('每日荔湾报纸'),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_out, size: 28),
            onPressed: _zoomOut,
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in, size: 28),
            onPressed: _zoomIn,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onScaleUpdate: (details) {
            setState(() {
              _fontScale = (_fontScale * details.scale).clamp(1.0, 2.5);
            });
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: Text(
                      '荔 湾 日 报',
                      style: TextStyle(
                        fontSize: 32 * _fontScale,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    MockData.dateText,
                    style: TextStyle(
                      fontSize: 18 * _fontScale,
                      color: const Color(0xFF888888),
                      letterSpacing: 4,
                    ),
                  ),
                ),
                const Divider(height: 36, thickness: 3, color: Colors.black),
                ...MockData.newspaperArticles.map((article) => _buildArticle(article)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArticle(Map<String, String> article) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article['title']!,
            style: TextStyle(
              fontSize: 36 * _fontScale,
              fontWeight: FontWeight.w900,
              height: 1.3,
              letterSpacing: 3,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              article['content']!,
              style: TextStyle(
                fontSize: 28 * _fontScale,
                fontWeight: FontWeight.w500,
                height: 1.8,
                letterSpacing: 2,
                color: const Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }
}