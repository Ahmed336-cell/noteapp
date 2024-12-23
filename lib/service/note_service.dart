import 'dart:ffi';

import 'package:hive/hive.dart';
import 'package:noteapp/model/note.dart';

class NoteService{
  static String boxName= "notes";

  Future<Box<Note>>get noteBox async{
    return await Hive.openBox<Note>(boxName);
  }

  Future<void> addNote(Note note) async{
    var box = await noteBox;
    await box.add(note);
  }

  Future<List<Note>>getNotes() async{
    var box = await noteBox;
    return box.values.toList();
  }

  Future<void> updateNote(int index, Note note) async{
    var box = await noteBox;
    await box.putAt(index, note);
  }

  Future<void> deleteNote(int index) async{
    var box = await noteBox;
    await box.deleteAt(index);
  }
}