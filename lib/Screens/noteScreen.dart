import 'package:flutter/material.dart';
import './addNote.dart';
import '../firebase.dart';
import '../note.dart';
import '../colors.dart';

class NotePage extends StatefulWidget {
  final Note n;
  final Function del;
  final Function ins, onchange;
  NotePage({this.n, this.del, this.ins, this.onchange});
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
      backgroundColor: colors[0],
      appBar: AppBar(
        backgroundColor: colors[3],
        title: Text('Note'),
        actions: [
          FlatButton(
              onPressed: () async {
                await CloudService().delet(widget.n.index.toString());
                widget.del(widget.n.index);
                Navigator.pop(context);
              },
              child: Icon(Icons.delete, color: Colors.white)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                  color: colors[1],
                  padding: EdgeInsets.all(8),
                  child: ListView(
                    children: [
                      Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            widget.n.title,
                            style: TextStyle(
                              fontFamily: 'Shadows',
                              fontSize: 25,
                              decoration: TextDecoration.underline,
                            ),
                            textAlign: TextAlign.center,
                          )),
                      Divider(),
                      Text(
                        widget.n.desc,
                        style: TextStyle(
                          fontFamily: 'Shadows',
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
        backgroundColor: colors[3],
        child: Icon(Icons.edit),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEvent(
                    note: widget.n, len: widget.n.index, ins: widget.ins)),
          );
          Navigator.pop(context);
        },
      ),
    );
  }
}
