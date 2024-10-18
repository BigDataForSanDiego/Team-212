import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _wordsSpoken = "";

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
    });
    _saveTranscription(_wordsSpoken);
  }

  Future<void> _saveTranscription(String transcription) async {
    final directory = 'Users/adamrolander/Desktop';
    final filePath = '$directory/transcription.txt';
    final file = File(filePath);
    await file.writeAsString(transcription);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[200],
        title: const Text(
          'Automated Appointment Transcription',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes space between children
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                _speechToText.isListening
                    ? "Recording..."
                    : !_speechEnabled // Changed condition to only show if speech is not available
                        ? "Speech not available"
                        : "",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            // Display recognized words near the top
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Text(
                  _wordsSpoken,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            // Button at the bottom
            ElevatedButton(
              onPressed: _speechToText.isListening ? _stopListening : _startListening,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[200], // Button background color
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), // Button padding
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Text style
              ),
              child: Text(
                _speechToText.isListening ? 'Stop Recording' : 'Push to Begin Recording',
              ),
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}