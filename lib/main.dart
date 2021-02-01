import 'dart:convert';
import 'package:flutter/material.dart';
// Other Files
import './elements/noteCard.dart';
import './note.dart';
import './colors.dart';
import './Screens/addNote.dart';
import './firebase.dart';
//Flutter Packages
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eazy Notes...',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

//Main Page
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Get Notes from Firebase
  void getdata() async {
    _notes = await CloudService().getevents();
    setState(() {});
  }

  // Get Quote of the Day
  void getquote() async {
    Response r = await get('https://quotes.rest/qod');
    Map data = json.decode(r.body);
    print(data.toString());
    quote = '"' +
        data['contents']['quotes'][0]['quote'] +
        '"\n-' +
        data['contents']['quotes'][0]['author'];
    setState(() {});
  }

  // Delete a note
  void delete(int ind) {
    _notes.removeWhere((element) => element.index == ind);
    setState(() {});
  }

  // Add/Update a note
  void add(Note n) {
    _notes.removeWhere((element) => element.index == n.index);
    _notes.add(n);
    setState(() {});
  }

  List<Note> _notes;
  String quote = '``';

  @override
  void initState() {
    super.initState();
    getquote();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[0],
      appBar: AppBar(
        backgroundColor: colors[3],
        title: Text(
          'Simple Notes',
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            child: quote == '``'
                ? Text('Quote of the Day Loading....')
                : Text(
                    'Quote of the Day\n' + quote,
                    textAlign: TextAlign.center,
                  ),
          ),
          Expanded(
            child: _notes != null
                ? _notes.length == 0
                    ? Center(
                        // If there are no notes...
                        child: Text("Empty..."),
                      )
                    : ListView(
                        children: [
                          for (int i = 0; i < (_notes.length / 2).ceil(); i++)
                            Row(
                              children: [
                                Expanded(
                                    child: (NoteCard(
                                        note: _notes[2 * i],
                                        onChanged: getdata,
                                        ins: add,
                                        del: delete))),
                                Expanded(
                                    child: (_notes.length > 2 * i + 1
                                        ? NoteCard(
                                            note: _notes[2 * i + 1],
                                            onChanged: getdata,
                                            del: delete,
                                            ins: add,
                                          )
                                        : SizedBox()))
                              ],
                            ),
                        ],
                      )
                : Center(
                    // If the data is not yet arrived
                    child: Text("Fetching data..."),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors[3],
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEvent(
                  note: null,
                  len: _notes.length,
                  ins: add,
                ),
              ));

          getdata();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Code for Searching and sorting, incase required...

// Row(
//   children: [
//     IconButton(
//         icon: Icon(Icons.sort),
//         onPressed: () {
//           setState(() {
//             sort = !sort;
//           });
//         }),
//     IconButton(
//         icon: Icon(Icons.search),
//         onPressed: () {
//           setState(() {
//             sorted = notes;
//             sear = !sear;
//           });
//         })
//   ],
// ),
// AnimatedCrossFade(
//   firstChild: Container(
//     height: h(50, context),
//     child: Row(
//       children: [
//         FlatButton(
//           child: Text('By Name'),
//           onPressed: () {
//             setState(() {
//               if (notes != null) {
//                 if (sorted == null || sorted == []) sorted = notes;
//                 sorted.sort((a, b) => a.title.compareTo(b.title));
//                 sort = false;
//               }
//             });
//           },
//         ),
//         FlatButton(
//           child: Text('By Last Updated'),
//           onPressed: () {
//             setState(() {
//               if (notes != null) {
//                 if (sorted == null || sorted == []) sorted = notes;
//                 sorted.sort((a, b) => b.edit.compareTo(a.edit));
//                 sort = false;
//               }
//             });
//           },
//         )
//       ],
//     ),
//   ),
//   secondChild: Container(),
//   duration: Duration(milliseconds: 500),
//   crossFadeState:
//       sort ? CrossFadeState.showFirst : CrossFadeState.showSecond,
// ),
// AnimatedCrossFade(
//   firstChild: Container(
//     height: h(50, context),
//     child: TextField(
//       decoration: InputDecoration(hintText: 'Search'),
//       onChanged: (val) {
//         setState(() {
//           // sorted
//           //     .retainWhere((element) => element.title.contains(val));
//         });
//       },
//     ),
//   ),
//   secondChild: Container(),
//   duration: Duration(milliseconds: 500),
//   crossFadeState:
//       sear ? CrossFadeState.showFirst : CrossFadeState.showSecond,
// ),
