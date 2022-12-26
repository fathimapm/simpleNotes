import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/notes/notes_cubit.dart';
import '../models/notes_model.dart';
import 'edit_notes_page.dart';
import 'home_page.dart';

class ReadingNotesPage extends StatefulWidget {
  final NotesModel notesModel;

  const ReadingNotesPage({required this.notesModel, Key? key})
      : super(key: key);

  @override
  State<ReadingNotesPage> createState() => _ReadingNotesPageState();
}

class _ReadingNotesPageState extends State<ReadingNotesPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow.shade700,
            title: Text("Notes", style:GoogleFonts.poppins(color: Colors.white,
            )
                ),
            actions: [
              BlocConsumer<NotesCubit, NotesState>(
                listener: (context, state) {
                  if (state is NotesDeleted) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => HomePage()));
                  } else if (state is NotesDeleteError) {
                    Fluttertoast.showToast(
                        msg: "Error deleting the task",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
                builder: (context, state) {
                  if (state is NotesDeleting) {
                    return CircularProgressIndicator(color: Colors.red);
                  }

                  return IconButton(onPressed: () {
                    context.read<NotesCubit>().deleteNotes(widget.notesModel);
                  }, icon: Icon(Icons.delete, color: Colors.white,),
                  );
                },
              ),
   IconButton(onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            EditNotesPage(notesModel:widget.notesModel ,)));
                  }, icon: Icon(Icons.edit, color: Colors.white,),


              ),
            ],
          ),
          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 10),
                child: Column(

                    children: [
SizedBox(height: 10,),

                      SizedBox(height: 15,),
                      Text(widget.notesModel.title,style:GoogleFonts.poppins(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                      SizedBox(height: 10,),
                      Text(widget.notesModel.description,style:GoogleFonts.poppins(fontSize: 12.0),)
                    ]
                ),
              )

          )
      ),
    );
  }

}