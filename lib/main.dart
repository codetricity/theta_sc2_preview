import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:theta_sc2_preview/take_picture.dart';
import 'sc2_get_live_preview.dart';

// specify the number of frames to test
const int frames = 100000;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THETA SC2 Preview',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'SC2 Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    StreamController controller = StreamController();
    sc2GetLivePreview(controller, frames: frames);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: StreamBuilder(
                  stream: controller.stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var imageData = Uint8List.fromList(snapshot.data);
                      return Image.memory(
                        imageData,
                        gaplessPlayback: true,
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      keepRunning = true;
                    },
                    iconSize: 36,
                    icon: const Icon(Icons.play_arrow),
                  ),
                  IconButton(
                    onPressed: () {
                      keepRunning = false;
                    },
                    iconSize: 36,
                    icon: const Icon(Icons.stop_circle),
                  ),
                  // IconButton(
                  //   onPressed: () async {
                  //     keepRunning = false;
                  //     await Future.delayed(const Duration(milliseconds: 1000));
                  //     takePicture();
                  //   },
                  //   iconSize: 36,
                  //   icon: const Icon(Icons.camera_alt),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
