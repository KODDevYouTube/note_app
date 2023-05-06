import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/helper/uitls.dart';
import 'package:note_app/models/note.dart';

class NoteItem extends StatelessWidget {

  Note note;
  int index;

  NoteItem({super.key, required this.note, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed('noteDetails', arguments: {
            'index': index
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: Colors.blue.shade100,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      note.title!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      note.description!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 15
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    Utils.dateFormat(note.createdAt!),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13
                    ),
                  ),
                )
              ],
            )
          )
        ),
      ),
    );
  }
}
