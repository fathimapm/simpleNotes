import 'package:cloud_firestore/cloud_firestore.dart';

import '../../helpers/storage_helper.dart';
import '../../helpers/storage_keys.dart';
import '../../models/notes_model.dart';

class NotesRepository{
  createNotes(NotesModel notesModel)async{
    String? uid = await StorageHelper.readData(StorageKeys.uid.name);
    CollectionReference reference= FirebaseFirestore.instance.collection("users").doc("$uid").collection("notes");
    reference.add(notesModel.toJson());
  }
  Future<QuerySnapshot> getAllNotes()async{
    String? uid = await StorageHelper.readData(StorageKeys.uid.name);
    CollectionReference reference= FirebaseFirestore.instance.collection("users").doc("$uid").collection("notes");
    QuerySnapshot snapshot = await reference.get();
    return snapshot;
  }
  updateNotes(NotesModel updatedNotes)async{
    String? uid = await StorageHelper.readData(StorageKeys.uid.name);
    CollectionReference reference= FirebaseFirestore.instance.collection("users").doc("$uid").collection("notes");
    reference.doc("${updatedNotes.id}").update(updatedNotes.toJson());
  }
  deleteNotes(NotesModel updatedNotes)async{
    String? uid = await StorageHelper.readData(StorageKeys.uid.name);
    CollectionReference reference= FirebaseFirestore.instance.collection("users").doc("$uid").collection("notes");
    reference.doc("${updatedNotes.id}").delete();
  }
}