import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
// import 'package:path_provider/path_provider.dart' as path_provider;

import './note.dart';

class CloudService {
  final CollectionReference noteCollection =
      FirebaseFirestore.instance.collection('notes');

  Future updateData(Note note) async {
    await noteCollection.doc('${note.index}').set({
      'title': note.title,
      'desc': note.desc,
      'create': note.create.toIso8601String(),
      'edit': note.edit.toIso8601String(),
      'index': note.index,
    });

    return;
  }

  Future editData(
    Note note,
  ) async {
    await noteCollection.doc('${note.index}').update({
      'title': note.title,
      'desc': note.desc,
      'edit': DateTime.now().toIso8601String(),
    });

    return;
  }

  Future delet(String nm) async {
    await noteCollection.doc(nm).delete();
  }

  Future<List<Note>> getevents() async {
    List<Note> events = [];
    final shots = await noteCollection.get();
    for (var i in shots.docs) {
      events.add(Note(
        index: i.data()['index'] ?? 0,
        title: i.data()['title'] ?? '',
        desc: i.data()['desc'] ?? '',
        create: DateTime.parse(i.data()['create']) ?? DateTime.now(),
        edit: DateTime.parse(i.data()['edit']) ?? DateTime.now(),
      ));
    }
    return events;
  }
}
