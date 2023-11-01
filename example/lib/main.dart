import 'package:flutter/material.dart';

void main() {
  runApp(DragAndMoveImages());
}

class DragAndMoveImages extends StatefulWidget {
  @override
  _DragAndMoveImagesState createState() => _DragAndMoveImagesState();
}

class _DragAndMoveImagesState extends State<DragAndMoveImages> {
  List<Widget> images = [
    Image.asset('assets/images/image1.png'),
    Image.asset('assets/images/image2.png'),
    Image.asset('assets/images/image3.png'),
  ];

  List<Offset> imagePositions = [
    Offset(20, 20),
    Offset(50, 50),
    Offset(100, 100),
  ];

  double imageScale = 0.5; // Adjust this value to change the image size.

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) => MediaQuery(
              data: MediaQueryData(),
              child: Scaffold(
                body: Stack(
                  children: images.asMap().entries.map((entry) {
                    int index = entry.key;
                    return Positioned(
                      left: imagePositions[index].dx,
                      top: imagePositions[index].dy,
                      child: Draggable(
                        child: Transform.scale(
                          scale: imageScale,
                          child: entry
                              .value, // Wrap the image with Transform.scale
                        ),
                        feedback: Container(
                          color: Colors.blue,
                          width: 10,
                          height: 10,
                        ),
                        onDragUpdate: (details) {
                          setState(() {
                            imagePositions[index] = details.localPosition;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
