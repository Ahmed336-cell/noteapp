import 'package:flutter/material.dart';
import 'package:noteapp/model/note.dart';
import 'package:noteapp/service/note_service.dart';

class AddNotePage extends StatefulWidget {
  Note?note;
  int ?index;
  AddNotePage({Key? key,  this.note , this.index}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController assetsController = TextEditingController();

  final NoteService noteService= NoteService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      descriptionController.text = widget.note!.description;
    }
  }

  void saveNote(BuildContext context){
    String title = titleController.text;
    String description = descriptionController.text;
    if (widget.note == null) {
      var note = Note(title: title, description: description);
      noteService.addNote(note);

    }else{
      widget.note!.title = title;
      widget.note!.description = description;
      noteService.updateNote(widget.index!,widget.note!);
    }
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( widget.note == null ? 'Add Note' : 'Edit Note',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Field
            const Text(
              "Title",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter the title...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Description Field
            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Enter the description...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),



            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Save Button
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement Save Logic
                    saveNote(context);
                    print(noteService.getNotes());
                  },
                  icon: const Icon(Icons.save),
                  label:  Text(widget.note == null ? 'Save' : 'Update',),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                // Cancel Button
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context); // Close the page
                  },
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  label: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
