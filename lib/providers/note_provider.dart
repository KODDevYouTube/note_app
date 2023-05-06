import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/services/database_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteProvider extends ChangeNotifier {

  List<Note> notes = [];
  bool loading = true;

  getNotes() async {
    notes.clear();
    loading = true;
    await DatabaseService().database(
      query: (SupabaseClient supabase) async {
        List<dynamic> data = await supabase
            .from('notes')
            .select()
            .order('created_at');
        for(var element in data){
          notes.add(Note.fromJson(Map<String, dynamic>.from(element as Map)));
        }
        loading = false;
        notifyListeners();
      }
    );
  }

  addNote(Map note) async {
    await DatabaseService().database(
        query: (SupabaseClient supabase) async {
          await supabase
              .from('notes')
              .insert(note);
          getNotes();
        }
    );
  }

  deleteNote(Note note) async {
    await DatabaseService().database(
      query: (SupabaseClient supabase) async {
        await supabase
            .from('notes')
            .delete()
            .eq('id', note.id!);
        getNotes();
      }
    );
  }

  editNote(Map map, Note note) async {
    await DatabaseService().database(
        query: (SupabaseClient supabase) async {
          await supabase
              .from('notes')
              .update(map)
              .eq('id', note.id!);
          getNotes();
        }
    );
  }

}