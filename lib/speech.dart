import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class ledPage extends StatefulWidget {
  const ledPage({Key? key ,
    required this.sendMessageA,
    required this.sendMessageW,
    required this.sendMessageS,
    required this.sendMessageD,
    required this.sendMessageX,
    required this.sendMessageZ,
  }) : super(key: key);
  final Function sendMessageA;
  final Function sendMessageW;
  final Function sendMessageS;
  final Function sendMessageD;
  final Function sendMessageX;
  final Function sendMessageZ;
  @override
  _ledPageState createState() => _ledPageState();
}

class _ledPageState extends State<ledPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Speak something...";
  String _oldText = "";
  String _currentText = "";
  IconData _icon = Icons.mic;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              Container(
                child: Text(
                            _text,
                            style: const TextStyle(
                                fontSize: 32.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400
                            ),
                        ),
              ),
              Container(
                width: 200,
                height: 300,
                  child: Icon(_icon)
              )
            ],

          )
        ),
      ),
    );
  }

  void reset() {
    _isListening = false;
    _text = "Speak something...";
    _currentText = "";
    _oldText = "";
    _icon = Icons.mic;
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => {
          if (val == "notListening") {
            reset()
          }
        },
        onError: (val) => print('onErr: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;


            if (_text.length >= _oldText.length) {
              _currentText = _text.substring(_oldText.length);
            }
            print('Đã nhận dạng từ: $_text - $_oldText - $_currentText');

            _oldText = _text;

            // Tách đoạn văn thành các từ riêng lẻ
            List<String> words = _currentText.split(' ');

            // Kiểm tra từng từ trong đoạn văn
            for (String word in words) {
              print('Xét từ: $word');
                switch (word) {
                  case 'phải':
                    widget.sendMessageD();
                    _icon = Icons.arrow_circle_right;
                    break;
                  case 'right':
                    widget.sendMessageD();
                    _icon = Icons.arrow_circle_right;
                    break;
                  case 'trái':
                    widget.sendMessageA();
                    _icon = Icons.arrow_circle_left;
                    break;
                  case 'left':
                    widget.sendMessageA();
                    _icon = Icons.arrow_circle_left;
                    break;
                  case 'bật':
                    widget.sendMessageX();
                    _icon = Icons.play_circle;
                    break;
                  case 'on':
                    widget.sendMessageX();
                    _icon = Icons.play_circle;
                    break;
                  case 'tắt':
                    widget.sendMessageZ();
                    _icon = Icons.flash_off;
                    break;
                  case 'off':
                    widget.sendMessageZ();
                    _icon = Icons.flash_off;
                    break;
                  case 'thẳng':
                    widget.sendMessageW();
                    _icon = Icons.arrow_circle_up;
                    break;
                  case 'tiến':
                    widget.sendMessageW();
                    _icon = Icons.arrow_circle_up;
                    break;
                  case 'straight':
                    _icon = Icons.arrow_circle_up;
                    widget.sendMessageW();
                    break;
                  case 'lùi':
                    widget.sendMessageS();
                    _icon = Icons.arrow_circle_down;
                    break;
                  case 'quay lại':
                    widget.sendMessageS();
                    _icon = Icons.arrow_circle_down;
                    break;
                  case 'back':
                    widget.sendMessageS();
                    _icon = Icons.arrow_circle_down;
                    break;
                // Xử lý các từ khác trong danh sách _highlights tại đây
                  default:
                    break;
                }
            }
            words = [];
          }),
        );
      } else {
        setState(() => _isListening = false);
        _speech.stop();

        reset();
      }
    }
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() => _isListening = false);
  }
}
