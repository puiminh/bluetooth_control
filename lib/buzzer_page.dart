import 'package:flutter/material.dart';


class buzzerPage extends StatefulWidget {
  const buzzerPage({Key? key ,
    required this.sendMessage1,
    required this.sendMessage2,
    required this.sendMessage3,
    required this.sendMessage4,
    required this.sendMessage5,
    required this.sendMessage6,
    required this.sendMessage7,
    required this.sendMessage8,
    required this.sendMessage9
  }) : super(key: key);
  final Function sendMessage1;
  final Function sendMessage2;
  final Function sendMessage3;
  final Function sendMessage4;
  final Function sendMessage5;
  final Function sendMessage6;
  final Function sendMessage7;
  final Function sendMessage8;
  final Function sendMessage9;


  @override
  _buzzerPageState createState() => _buzzerPageState();
}

class _buzzerPageState extends State<buzzerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_up),
                    onPressed: () {
                      // Xử lý khi nhấn nút Lên
                      widget.sendMessage2();
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        onPressed: () {
                          // Xử lý khi nhấn nút Trái
                          widget.sendMessage3();

                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.stop),
                        onPressed: () {
                          // Xử lý khi nhấn nút Dừng
                          widget.sendMessage4();

                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_right),
                        onPressed: () {
                          // Xử lý khi nhấn nút Phải
                          widget.sendMessage5();

                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onPressed: () {
                      // Xử lý khi nhấn nút Xuống
                      widget.sendMessage6();

                    },
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
