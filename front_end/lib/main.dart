import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(const HackathonApp());
}

class HackathonApp extends StatelessWidget {
  const HackathonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RecordingPage(),
    );
  }
}

class RecordingPage extends StatefulWidget {
  const RecordingPage({super.key});

  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  FlutterSoundRecorder? _recorder;
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isRecording = false;
  String _transcription = "Press the button to start recording.";

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await _recorder!.openRecorder(); // Corrected method
  }

  Future<void> _startRecording() async {
    setState(() {
      _isRecording = true;
    });

    // Start recording using flutter_sound
    await _recorder!.startRecorder(toFile: 'audio.aac');
  }

  Future<void> _stopRecording() async {
    setState(() {
      _isRecording = false;
    });

    // Stop recording
    await _recorder!.stopRecorder();

    _speechToText.stop();

    // Start transcription
    _transcribeAudio();
  }

  Future<void> _transcribeAudio() async {
    bool available = await _speechToText.initialize();
    if (available) {
      setState(() => _transcription = 'Transcribing...');
      _speechToText.listen(onResult: (result) {
        setState(() {
          _transcription = result.recognizedWords;
        });
      });
    } else {
      setState(() {
        _transcription = "Could not initialize speech-to-text.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Recording'),
        backgroundColor: Colors.blueGrey[200],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_transcription),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _recorder!.closeRecorder(); // Corrected method
    super.dispose();
  }
}