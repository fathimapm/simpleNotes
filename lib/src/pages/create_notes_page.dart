
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:my_simple_notes/src/pages/home_page.dart';

import '../cubit/notes/notes_cubit.dart';
import '../models/notes_model.dart';
class CreateNotesPage extends StatefulWidget {
  const CreateNotesPage({Key? key}) : super(key: key);

  @override
  State<CreateNotesPage> createState() => _CreateNotesPageState();
}

class _CreateNotesPageState extends State<CreateNotesPage> {
  TextEditingController _titleController=TextEditingController();
  TextEditingController _descriptionController=TextEditingController();
 String creationTime =DateFormat('yyyy-MM-dd KK:mm a').format(DateTime.now());


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow.shade700,
            title: Text("Notes",style: GoogleFonts.poppins(color: Colors.white,),),
            actions: [
              BlocConsumer<NotesCubit, NotesState>(
                listener: (context, state) {
                  if(state is NotesCreated) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => HomePage()));
                  }else if(state is NotesCreateError){
                    Fluttertoast.showToast(
                        msg: "Error Creating a Notes",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }


                },
                builder: (context, state) {
                  if(state is NotesLoading){
                    return
                  Lottie.asset('assets/lottie/loader.json');
                  }

                  return TextButton(onPressed: (){ NotesModel notesModel = NotesModel(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    creationTime: creationTime,
                  );
                  context.read<NotesCubit>().createNotes(notesModel);
                  },
                    child: Text("Done",style: GoogleFonts.poppins(color: Colors.white,),),);
                },
              ),
            ],
          ),

          body: SingleChildScrollView(
            child: Column(

              children: [


                Form(child: Padding(
                  padding: const EdgeInsets.only(left: 20,),
                  child: Column(
                    children: [
SizedBox(height: 20,),
                      Text(creationTime,style:GoogleFonts.poppins(color: Colors.grey,fontSize: 12.0,) ,),
                      TextFormField(
                        controller:_titleController,
                        decoration: InputDecoration.collapsed(hintText: "Title",hintStyle:GoogleFonts.poppins(color: Colors.grey)),
                        style: GoogleFonts.poppins(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 5,),

                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          controller: _descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration.collapsed(hintText: "Description",hintStyle:GoogleFonts.poppins(color: Colors.grey) ),
                          style: GoogleFonts.poppins(
                              fontSize: 15.0,

                              color: Colors.black

                          ),
                        ),
                      )

                    ],
                  ),
                )
                ),

              ],
            ),
          )

      ),
    );
  }
}