import 'package:alumni/main.dart';
import 'package:alumni/colors.dart';
import 'package:flutter/material.dart';
import '../Screens/noteScreen.dart';
import '../functins.dart';
import '../note.dart';

class NoteCard extends StatelessWidget {
  String formatdate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  final Note note;
  final Function onChanged, del, ins;
  final int len;
  NoteCard({this.note, this.onChanged, this.len, this.del, this.ins});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: Container(
        height: 250,
        child: Card(
          color: colors[1],
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotePage(
                          n: note,
                          del: del,
                          ins: ins,
                          onchange: onChanged,
                        )),
              );
              onChanged();
            },
            child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      note.title,
                      style: TextStyle(fontSize: 25, fontFamily: 'Shadows'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Divider(),
                  Container(
                    child: Text(
                      note.desc,
                      style: TextStyle(fontSize: 20, fontFamily: 'Shadows'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
