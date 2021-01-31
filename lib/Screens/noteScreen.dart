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
        title: Text('${widget.n.title}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  widget.n.desc +
                      '\n\nCreated: ${formatdate(widget.n.create)}\nLast Edited: ${formatdate(widget.n.edit)} ',
                  style: TextStyle(fontSize: 22),
                )),
          ),
          Row(
            children: [
              FlatButton(
                  onPressed: () async {
                    await CloudService().delet(widget.n.index.toString());
                    notes.removeWhere(
                        (element) => element.index == widget.n.index);
                    Navigator.pop(context);
                  },
                  child: Text('Delete')),
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddEvent(widget.n)),
                    );
                  },
                  child: Text('Update'))
            ],
          )
        ],
      ),
    );
  }
}
