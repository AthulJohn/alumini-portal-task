import 'package:flutter/material.dart';
import './elements/noteCard.dart';
import './functins.dart';
import './note.dart';
import './values.dart';
import './Screens/addNote.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initdata() async {
    _notes = await CloudService().getevents();
    // notes.sort((a, b) => a.index.compareTo(b.index));
    // sorted = notes;
    setState(() {});
  }

  void delete(int ind) {
    _notes.removeWhere((element) => element.index == ind);
    setState(() {});
  }

  void add(Note n) {
    _notes.removeWhere((element) => element.index == n.index);
    _notes.add(n);
    setState(() {});
  }

  List<Note> _notes;
  @override
  void initState() {
    super.initState();
    initdata();
  }

  // List<Note> sorted = notes;
  // bool sort = false, sear = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[0],
      appBar: AppBar(
        backgroundColor: colors[3],
        title: Text(
          'Simple Notes',
          // style: TextStyle(color: colors[2]),
        ),
      ),
      body: _notes != null
          ? _notes.length == 0
              ? Center(
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
                                  onChanged: initdata,
                                  ins: add,
                                  del: delete))),
                          Expanded(
                              child: (_notes.length > 2 * i + 1
                                  ? NoteCard(
                                      note: _notes[2 * i + 1],
                                      onChanged: initdata,
                                      del: delete,
                                      ins: add,
                                    )
                                  : SizedBox()))
                        ],
                      ),
                  ],
                )
          : Center(
              child: Text("Fetching data..."),
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

          initdata();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

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
