import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:note_app/helper/app_dialog.dart';
import 'package:note_app/helper/uitls.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:provider/provider.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {

  int? index;
  late NoteProvider noteProvider;

  @override
  void initState() {
    noteProvider = Provider.of<NoteProvider>(context, listen: false);
    Future.delayed(Duration.zero).then((value) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      if(args['index'] != null){
        setState(() {
          index = args['index'] as int;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(index == null){
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Consumer<NoteProvider>(
    builder: (context, value, widget) {
      if(value.notes.length-1 < index!){
        Navigator.of(context).pop();
        return Container();
      }
      Note note = value.notes[index!];
      return Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          title: const Text('Note'),
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed('editNote', arguments: {
                    'note': note
                  });
                },
                icon: const Icon(Icons.edit)
            ),
            IconButton(
                onPressed: () async {
                  AppDialog(
                      context: context,
                      title: 'Delete note',
                      content: 'Are you sure you want to delete this note?',
                      actions: [
                        BasicDialogAction(
                          title: const Text('Yes'),
                          onPressed: () async {
                            await noteProvider.deleteNote(note!);
                            if(!mounted) return;
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                        BasicDialogAction(
                          title: const Text('No'),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        )
                      ]
                  );
                },
                icon: const Icon(Icons.delete)
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    note.title!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),☻
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    note.description!,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 15
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    Utils.dateFormat(note.createdAt!),
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13
                    ),
                  ),
                ),
              )
            ],
            ),
        )
        );
      }
    );
  }
}
