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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/home': (context) => MyHomePage(),
        'add': (context) => AddEvent(),
        // '/home':(context)=>MyHomePage(),
      },
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
    notes = await CloudService().getevents();
    // notes.sort((a, b) => a.index.compareTo(b.index));
    // sorted = notes;
    setState(() {});
  }

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
      appBar: AppBar(
        title: Text('Simple Notes'),
      ),
      body: Column(
        children: [
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
          Expanded(
            child: notes != null
                ? notes.length == 0
                    ? Center(
                        child: Text("Empty..."),
                      )
                    : ListView(
                        children: [
                          for (Note n in notes)
                            NoteCard(note: n, onChanged: initdata)
                        ],
                      )
                : Center(
                    child: Text("Fetching data..."),
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, 'add');
          initdata();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
