import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteapp/model/note.dart';
import 'package:noteapp/service/note_service.dart';

import 'addnote.dart';
import 'notecard.dart';

class Homepage extends StatefulWidget {
   Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final NoteService noteService = NoteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotePage()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text('My Notes' , style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
          ValueListenableBuilder(
            valueListenable: Hive.box<Note>('notes').listenable(),
            builder: (context, box, _) {
              if (box.values.isEmpty) {
                return Center(child: Text("No Available Data"

                  , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),));
              }
              return Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  shrinkWrap: true,
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    var note = box.getAt(index);
                    return Dismissible(
                      key: Key(note!.title),
                      onDismissed: (direction) {
                        setState(() {
                          noteService.deleteNote(index);

                        });

                        ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('${note!.title} deleted')));
                      },
                      background: Container(
                        color: Colors.red,
                        child: Icon(Icons.delete),
                      ),

                      child: NoteCard(
                        title: note!.title,
                        description: note.description,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNotePage(
                                note: note,
                                index: index,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),




        ]
      ),
    );
  }
}
