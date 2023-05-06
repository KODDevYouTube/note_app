import 'package:flutter/material.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:note_app/screens/add_note_screen.dart';
import 'package:note_app/screens/edit_note_screen.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/note_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "supabase url",
    anonKey: "anon key",
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoteProvider())
    ],
    child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const HomeScreen(),
        'addNote': (_) => const AddNoteScreen(),
        'noteDetails': (_) => const NoteDetailsScreen(),
        'editNote': (_) => const EditNoteScreen()
      },
    );
  }
}
