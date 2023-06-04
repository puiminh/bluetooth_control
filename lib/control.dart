import 'package:flutter/material.dart';
import 'package:hold_down_button/hold_down_button.dart';


class buzzerPage extends StatefulWidget {
  const buzzerPage({Key? key ,
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
  _buzzerPageState createState() => _buzzerPageState();
}

class _buzzerPageState extends State<buzzerPage> {

  static const timeDelay = Duration(milliseconds: 200);

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
                  HoldDownButton(
                    onHoldDown: () {
                      widget.sendMessageW();
                    },
                    holdWait: timeDelay,
                    child:                       IconButton(
                      icon: Icon(Icons.keyboard_arrow_up),
                      onPressed: () {

                        widget.sendMessageW();
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HoldDownButton(
                        onHoldDown: () {
                          widget.sendMessageA();
                        },
                        holdWait: timeDelay,
                        child:                       IconButton(
                          icon: Icon(Icons.keyboard_arrow_left),
                          onPressed: () {
                            widget.sendMessageA();
                          },
                        ),
                      ),
                      HoldDownButton(
                        onHoldDown: () {
                          widget.sendMessageX();
                        },
                        holdWait: timeDelay,
                        child:                       IconButton(
                          icon: Icon(Icons.stop),
                          onPressed: () {
                            
                            widget.sendMessageX();
                          },
                        ),
                      ),
                      HoldDownButton(
                        onHoldDown: () {
                          widget.sendMessageD();
                        },
                        holdWait: timeDelay,
                        child:                       IconButton(
                          icon: Icon(Icons.keyboard_arrow_right),
                          onPressed: () {
                            
                            widget.sendMessageD();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  HoldDownButton(
                    onHoldDown: () {
                      widget.sendMessageS();
                    },
                    holdWait: const Duration(milliseconds: 200),
                    child:                       IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onPressed: () {
                        
                        widget.sendMessageS();
                      },
                    ),
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
