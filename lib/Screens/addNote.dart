import 'package:flutter/material.dart';
import '../values.dart';
import '../firebase.dart';
import '../functins.dart';
import './loading.dart';
import '../note.dart';
import 'dart:io';

class AddEvent extends StatefulWidget {
  final Note note;
  AddEvent(this.note);
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
      image: '',
      index: notes.last.index + 1);
  File _image;
  TextEditingController t1 = TextEditingController(),
      t2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.note.index != -1) {
      addval = widget.note;
      t1.text = addval.title;
      t2.text = addval.desc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Scaffold(
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
                              fillColor: Color(0xFFEFEFEF)),
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
                              fillColor: Color(0xFFEFEFEF)),
                        )),
                    Expanded(flex: 24, child: SizedBox()),
                    // if (widget.note.index == -1)
                    //   Expanded(
                    //     flex: 150,
                    //     child: Column(children: <Widget>[
                    //       // Expanded(
                    //       //   flex: 5,
                    //       //   child: _image == null
                    //       //       ? Center(
                    //       //           child: Text('No Image Added!',
                    //       //               textAlign: TextAlign.center,
                    //       //               style:
                    //       //                   TextStyle(color: Colors.grey[400])))
                    //       //       : Container(
                    //       //           child:
                    //       //               Image.file(_image, fit: BoxFit.cover)),
                    //       // ),
                    //       // Expanded(
                    //       //     flex: 1,
                    //       //     child: Row(
                    //       //       children: [
                    //       //         FlatButton.icon(
                    //       //             onPressed: getImage,
                    //       //             icon: Icon(Icons.add_a_photo),
                    //       //             label: Text("Add Image")),
                    //       //         FlatButton.icon(
                    //       //             onPressed: () {
                    //       //               setState(() {
                    //       //                 _image = null;
                    //       //               });
                    //       //             },
                    //       //             icon: Icon(Icons.delete),
                    //       //             label: Text("Delete Image"))
                    //       //       ],
                    //       //     )),
                    //     ]),
                    //   ),
                    Expanded(flex: 24, child: SizedBox()),
                    Expanded(
                      flex: 45,
                      child: Builder(builder: (BuildContext ctxt) {
                        return FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Color(0xFF04294F),
                          child: Text('Submit',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            bool con = await testcon();
                            if (con) {
                              setState(() {
                                load = true;
                              });
                              try {
                                await CloudService().updateData(addval, _image);
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
