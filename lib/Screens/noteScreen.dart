import 'package:flutter/material.dart';
import './addNote.dart';
import '../firebase.dart';
import '../note.dart';
import '../values.dart';

class NotePage extends StatefulWidget {
  final Note n;
  NotePage({this.n});
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String formatdate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note'),
        actions: [
          FlatButton(
              onPressed: () async {
                await CloudService().delet(widget.n.index.toString());
                notes.removeWhere((element) => element.index == widget.n.index);
                Navigator.pop(context);
              },
              child: Icon(Icons.delete, color: Colors.white)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                  color: Colors.yellow,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            widget.n.title,
                            style: TextStyle(
                              fontSize: 25,
                              decoration: TextDecoration.underline,
                            ),
                            textAlign: TextAlign.center,
                          )),
                      Text(
                        widget.n.desc,
                        style: TextStyle(
                          fontSize: 22,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dotted,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
            ),
            Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Created: ${formatdate(widget.n.create)}\nLast Edited: ${formatdate(widget.n.edit)} ',
                  style: TextStyle(fontSize: 15),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEvent(note: widget.n)),
          );
        },
      ),
    );
  }
}
