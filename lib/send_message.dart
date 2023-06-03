library send_messagee;

import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';
import 'package:animated_stack/animated_stack.dart';
import 'package:buzzer_arduino/buzzer_page.dart';
import 'package:buzzer_arduino/led_page.dart';
import 'package:buzzer_arduino/led_page2.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice? server;
  const ChatPage({
    Key? key,
    this.server,
    this.lcdMessage,
  }) : super(key: key);
  final String? lcdMessage;

  @override
  _ChatPageState createState() => _ChatPageState();
}

var hadi;

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  BluetoothConnection? connection;

  final ScrollController listScrollController = ScrollController();

  bool isConnecting = true;

  bool get isConnected => connection != null && connection!.isConnected;

  bool isDisconnecting = false;
  @override
  @override
  List<Color> _colorlist = [];
  List<Color> genrateColorslist() {
    List<Color> _colorslist = [];
    for (int i = 0; i < (8 * 8); i++) {
      _colorslist.add(Colors.black);
    }
    return _colorslist;
  }

  void initState() {
    super.initState();

    _colorlist = genrateColorslist();
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);

    BluetoothConnection.toAddress(widget.server!.address).then((_connection) {
      print('Cihaza bağlanıldı');
      connection = _connection;

      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
    });
  }

  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
      mineController.close();
    }
    super.dispose();
  }

  bool btnColor = false;

  StreamController<String> mineController =
      StreamController<String>.broadcast();
  Stream<String> myStream() async* {
    connection?.input?.listen((Uint8List data) {
      print(ascii.decode(data));

      mineController.add(ascii.decode(data));
    });
  }

  Widget build(BuildContext context) {
    String denemee = "Veri Yok";
    TextEditingController lcdController = TextEditingController();
    mineController.addStream(myStream());

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          controller: _controller,
          tabs: [
            Tab(
              text: "Điều khiển nút",
            ),
            Tab(
              text: "Điều khiển giọng nói",
            ),
            Tab(
              text: "Gửi tin nhắn",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 95),
              child: buzzerPage(
                sendMessage1: () => _sendMessage('1'),
                sendMessage2: () => _sendMessage('2'),
                sendMessage3: () => _sendMessage('3'),
                sendMessage4: () => _sendMessage('4'),
                sendMessage5: () => _sendMessage('5'),
                sendMessage6: () => _sendMessage('6'),
                sendMessage7: () => _sendMessage('7'),
                sendMessage8: () => _sendMessage('8'),
                sendMessage9: () => _sendMessage('9'),
              )),
          Align(
            alignment: Alignment.center,
            child: ledPage(
              sendMessageA: () => _sendMessage('a'),
              sendMessageK: () => _sendMessage('k'),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 10),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: lcdController,
                        decoration: InputDecoration(
                          hintText: "Nhập tin nhắn",
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            _sendMessage('x' + lcdController.text);
                          },
                          icon: Icon(Icons.send)),
                      IconButton(
                          onPressed: () {
                            _sendMessage('t');
                          },
                          icon: Icon(Icons.clear))
                    ]),
              ),
            ),
          ),
          StreamBuilder<String>(
            stream: mineController.stream.asBroadcastStream(),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 150),
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                child: Text(
                  snapshot.data ?? denemee,
                  style: TextStyle(fontSize: 50, color: Colors.black),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  btnColorChange() {
    setState(() {
      btnColor = !btnColor;
    });
  }

  _sendMessage(String text) async {
    text = text.trim();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text)));

        await connection!.output.allSent;
      } catch (e) {
        // Ignore error, but notify state

      }
    }
  }

  _receiveMessage() {
    connection!.input!.listen((Uint8List data) {
      print('Data incoming: ${ascii.decode(data)}');
      void deneme = ascii.decode(data);

      return deneme;
    });
  }
}
