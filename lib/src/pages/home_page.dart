import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_simple_notes/src/pages/read_notes_page.dart';

import '../cubit/notes/notes_cubit.dart';
import '../models/notes_model.dart';
import 'create_notes_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => NotesCubit()..getAllNotes(),

        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow.shade700,
            title: Text("SimpleNotes",style:GoogleFonts.poppins(color: Colors.white) ,),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                  MaterialPageRoute(builder: (context) => CreateNotesPage()))
                  .then((value) {
                context.read<NotesCubit>().getAllNotes();
              });
            },
            child: Icon(Icons.note_add_sharp, color: Colors.white,),
            backgroundColor: Colors.yellow.shade700,
          ),
          body:



                Container(
                  child:

                  BlocBuilder<NotesCubit, NotesState>(
                    builder: (context, state) {
                      if (state is NotesLoading) {
                        return Center(child: Lottie.asset('assets/lottie/loader.json'));
                      } else if (state is NotesLoaded) {
                        return _buildNotesUI(state.notesList);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),


          ),


        );


  }
  _buildNotesUI(List<NotesModel> notesList) {
    return ListView.builder(
        itemCount: notesList.length,
        itemBuilder: (context, index) {
          NotesModel item = notesList[index];
          return Card(
              elevation: 10,
              child: ListTile(


                title: Text(item.title,style:GoogleFonts.poppins() ,),
                trailing: Text(item.creationTime,style:GoogleFonts.poppins(color: Colors.grey,fontSize: 10)),

                subtitle: Text(item.description,style:GoogleFonts.poppins(),
                  overflow: TextOverflow.ellipsis,
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.yellow.shade700, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
onTap:(){
                 Navigator.of(context)
                 .push(
                 MaterialPageRoute(builder: (context) =>ReadingNotesPage
                 (notesModel: item)));
}
                 ,
              )
          );
        }
    );
  }
}
