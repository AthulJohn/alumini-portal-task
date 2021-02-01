import 'package:flutter/material.dart';
import '../colors.dart';
import '../firebase.dart';
import '../functins.dart';
import './loading.dart';
import '../note.dart';
import 'dart:io';

class AddEvent extends StatefulWidget {
  final Note note;
  final int len;
  final Function ins;
  AddEvent({this.note, this.len, this.ins});
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  bool load = false;
  Note addval = Note(
      title: '',
      desc: '',
      create: DateTime.now(),
      edit: DateTime.now(),
      index: 0);
  TextEditingController t1 = TextEditingController(),
      t2 = TextEditingController();

  @override
  void initState() {
    super.initState();

    // If the passed Note object is null, then the screen is for adding a note.
    // If it is not null, Then the screen is for editing a note.
    if (widget.note != null) {
      addval = widget.note;
      t1.text = addval.title;
      t2.text = addval.desc;
    } else
      addval.index = widget.len;
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Scaffold(
            backgroundColor: colors[0],
            resizeToAvoidBottomPadding: false,
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: SizedBox(), flex: 30),
                    Expanded(child: Text('Note Title'), flex: 19),
                    Expanded(child: SizedBox(), flex: 13),
                    Expanded(
                        flex: 32,
                        child: TextField(
                          controller: t1,
                          onChanged: (value) {
                            setState(() {
                              addval.title = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              filled: true,
                              fillColor: colors[1]),
                        )),
                    Expanded(flex: 24, child: SizedBox()),
                    Expanded(flex: 19, child: Text('Note Description')),
                    Expanded(
                      flex: 13,
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 111,
                        child: TextField(
                          controller: t2,
                          onChanged: (value) {
                            setState(() {
                              addval.desc = value;
                            });
                          },
                          maxLines: 4,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              filled: true,
                              fillColor: colors[1]),
                        )),
                    Expanded(flex: 24, child: SizedBox()),
                    Expanded(flex: 24, child: SizedBox()),
                    Expanded(
                      flex: 25,
                      child: Builder(builder: (BuildContext ctxt) {
                        return FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: colors[1],
                          child: Text('Submit',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () async {
                            bool con = await testcon();
                            if (con) {
                              setState(() {
                                load = true;
                              });
                              try {
                                await CloudService().updateData(addval);
                                widget.ins(addval);
                              } catch (e) {
                                print(e);
                              }
                              setState(() {
                                load = false;
                              });
                              Navigator.pop(context);
                            } else {
                              Scaffold.of(ctxt).showSnackBar(SnackBar(
                                  content:
                                      Text('Oops!, Poor Internet Connection')));
                            }
                          },
                        );
                      }),
                    ),
                    Expanded(
                      flex: 25,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
            ));
  }
}
