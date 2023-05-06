import 'package:flutter/material.dart';
import 'package:note_app/items/note_item.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late NoteProvider noteProvider;

  @override
  void initState() {
    noteProvider = Provider.of<NoteProvider>(context, listen: false);
    noteProvider.getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note App'),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, value, widget){
          if(value.loading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            itemCount: value.notes.length,
            itemBuilder: (BuildContext context, int index) {
              Note note = value.notes[index];
              return NoteItem(note: note, index: index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('addNote');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
