import 'package:flutter/material.dart';
import '../Screens/noteScreen.dart';
import '../functins.dart';
import '../note.dart';

class NoteCard extends StatelessWidget {
  String formatdate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  final Note note;
  NoteCard({this.note});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotePage(n: note)),
            );
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (note.image != '')
                //   FlatButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => Picture(note.image)),
                //       );
                //     },
                //   child: Container(
                //     margin: EdgeInsets.only(bottom: 10),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10)),
                //     width: double.infinity,
                //     height: h(150, context),
                //     child: Image.network(
                //       note.image,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                Container(
                  height: h(50, context),
                  child: Text(
                    note.title,
                    style: TextStyle(fontSize: h(30, context)),
                  ),
                ),
                Container(
                  child: Text(
                    note.desc,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  height: h(40, context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Created on ${formatdate(note.create)}',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        'Last edit on ${formatdate(note.edit)}',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
