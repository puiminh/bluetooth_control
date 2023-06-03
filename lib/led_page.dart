import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class ledPage extends StatefulWidget {
  const ledPage({Key? key, required this.sendMessageA , required this.sendMessageK}) : super(key: key);
  final Function sendMessageA;
  final Function sendMessageK;

  @override
  _ledPageState createState() => _ledPageState();
}

class _ledPageState extends State<ledPage> {

  final Map<String, HighlightedWord> _highlights = {
    'trái': HighlightedWord(
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      )
    ),
    'phải': HighlightedWord(
        textStyle: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        )
    ),
    'dừng': HighlightedWord(
        textStyle: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        )
    ),
    'đi thẳng': HighlightedWord(
        textStyle: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        )
    ),
    'quay lại': HighlightedWord(
        textStyle: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        )
    ),
  };

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Record";
  double _confidence = 1.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: $_confidence'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _isListening ? _stopListening : _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onErr: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      } else {
        setState(() => _isListening = false);
        _speech.stop();
      }
    }
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() => _isListening = false);
  }
}
