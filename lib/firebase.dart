import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
// import 'package:path_provider/path_provider.dart' as path_provider;

import './note.dart';

class CloudService {
  // final String index;
  // CloudService({this.index});

  final CollectionReference noteCollection =
      FirebaseFirestore.instance.collection('notes');

  // Future updateDate(String name, DateTime udate, int ind) async {
  //   return await noteCollection
  //       .doc(name)
  //       .update({'update': udate.toIso8601String(), 'done': 1, 'lastind': ind});
  // }

  Future updateData(Note note, File image) async {
    // String img = '';
    // if (image != null) img = await uploadFile(note.title, image);
    await noteCollection.doc('${note.index}').set({
      'title': note.title,
      'desc': note.desc,
      'create': note.create.toIso8601String(),
      'edit': note.edit.toIso8601String(),
      'index': note.index,
      // 'image': img,
    });
    // if (getl(image) != 0) {
    //   for (int i = 0; i < images.length; i++) {
    //     await eventCollection
    //         .document(name)
    //         .collection('images')
    //         .document('$i')
    //         .setData({'url': images[i]});
    //     await eventCollection
    //         .document(name)
    //         .collection('imagepath')
    //         .document('$i')
    //         .setData({'path': '$name/${Path.basename(image[i].path)}'});
    //   }
    // }
    return;
  }

  Future editData(
    Note note,
  ) async {
    // final paths = await noteCollection
    //     .doc(note.title)
    //     .collection('imagepath')
    //     .get();
    // len = paths.documents.length - len;
    // if (len == 0) theme = '!';
    // if (getl(added) > 0 || len == 0) {
    //}
    //if (len == 0 || (len != 0 && getl(added) != 0)) {
    // imgs = await uploadFile(event.name, added);
    //if (len != 0 || getl(added) != 0) {
    // for (int i = 0; i < imgs.length; i++) {
    //   await eventCollection
    //       .document(event.name)
    //       .collection('images')
    //       .document('${len + i}')
    //       .setData({'url': imgs[i]});
    //   await eventCollection
    //       .document(event.name)
    //       .collection('imagepath')
    //       .document('${i + len}')
    //       .setData({'path': '${event.name}/${Path.basename(added[i].path)}'});
    // }
    // }
    await noteCollection.doc('${note.index}').update({
      'title': note.title,
      'image': note.image,
      'desc': note.desc,
      'edit': DateTime.now().toIso8601String(),
    });
    // for (Event i in activities) {
    //   await eventCollection
    //       .document(event.name)
    //       .collection('activity')
    //       .document('${i.index}')
    //       .updateData({
    //     'name': i.name,
    //     'desc': i.desc,
    //     'activitydate': i.updatedate.toIso8601String(),
    //   });
    // }
    return;
  }

  // Future updateactivity(String name, String desc, DateTime cdate, int acindex,
  //     DateTime dt) async {
  //   return await eventCollection
  //       .document(index)
  //       .collection('activity')
  //       .document('$acindex')
  //       .setData({
  //     'name': name,
  //     'desc': desc,
  //     'create': cdate.toIso8601String(),
  //     'index': acindex,
  //     'activitydate': dt.toIso8601String(),
  //   });
  // }

  // // List<Event> _listfromsnap(QuerySnapshot snapshot) {
  // //   return snapshot.documents.map((doc) {
  // //     return Event(
  // //       doc.data['index'] ?? 0,
  // //       doc.data['name'] ?? '',
  // //       doc.data['desc'] ?? '',
  // //       doc.data['create'].toDate() ?? DateTime.now(),
  // //       doc.data['update'].toDate() ?? DateTime.now(),
  // //       doc.data['theme'],
  // //       [],
  // //       doc.data['lastind'],
  // //       active: doc.data['active'],
  // //       done: doc.data['done'],
  // //       mace: doc.data['mace'],
  // //     );
  // //   }).toList();
  // // }

  // // List<Event> _listfromact(QuerySnapshot snapshot) {
  // //   return snapshot.documents.map((doc) {
  // //     return Event(
  // //         doc.data['index'] ?? 0,
  // //         doc.data['name'] ?? '',
  // //         doc.data['desc'] ?? '',
  // //         doc.data['create'].toDate() ?? DateTime.now(),
  // //         doc.data['activitydate'].toDate() ?? DateTime.now(),
  // //         '',
  // //         [],
  // //         0);
  // //   }).toList();
  // // }

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
        image: i.data()['image'] ?? '',
      ));
    }
    return events;
  }

//   Future<String> uploadFile(String name, File image) async {
//     String url;

//     Reference storageReference = FirebaseStorage.instance
//         .ref()
//         .child('$name/${Path.basename(image.path)}');
//     UploadTask uploadTask = storageReference.putFile(image);
//     await uploadTask.whenComplete(() async {
//       url = await storageReference.getDownloadURL();
//     });

//     return url;
//   }
}
