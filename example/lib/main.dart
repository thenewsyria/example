import 'package:flutter/material.dart';

void main() {
  runApp(DragAndMoveWidgets());
}

class DragAndMoveWidgets extends StatefulWidget {
  @override
  _DragAndMoveWidgetsState createState() => _DragAndMoveWidgetsState();
}

class _DragAndMoveWidgetsState extends State<DragAndMoveWidgets> {
  List<Widget> widgets = [];
  List<Offset> widgetPositions = [];
  double widgetScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Wrap your app in MaterialApp
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => MediaQuery(
                data: MediaQueryData(),
                child: Scaffold(
                  body: Stack(
                    children: [
                      ...widgetPositions.asMap().entries.map((entry) {
                        int index = entry.key;
                        return Positioned(
                          left: widgetPositions[index].dx,
                          top: widgetPositions[index].dy,
                          child: Draggable(
                            child: Transform.scale(
                              scale: widgetScale,
                              child: widgets[index],
                            ),
                            feedback: Container(
                              width: 100,
                              height: 100,
                              color: Colors.blue,
                            ),
                            onDragUpdate: (details) {
                              setState(() {
                                widgetPositions[index] = details.localPosition;
                              });
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      _showAddWidgetDialog(context);
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddWidgetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Add Widget"),
          children: [
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  widgets.add(Text("New Text"));
                  widgetPositions.add(Offset(20, 20));
                });
                Navigator.of(context).pop();
              },
              child: Text("Text"),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  widgets.add(
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    ),
                  );
                  widgetPositions.add(Offset(20, 20));
                });
                Navigator.of(context).pop();
              },
              child: Text("Image"),
            ),
          ],
        );
      },
    );
  }
}
