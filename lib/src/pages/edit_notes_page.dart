


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:my_simple_notes/src/pages/home_page.dart';

import '../cubit/notes/notes_cubit.dart';
import '../models/notes_model.dart';

class EditNotesPage extends StatefulWidget {
 final NotesModel notesModel;

  const EditNotesPage({required this.notesModel, Key? key}) : super(key: key);

  @override
  State<EditNotesPage> createState() => _EditNotesPageState();
}

class _EditNotesPageState extends State<EditNotesPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String creationTime =DateFormat('yyyy-MM-dd KK:mm a').format(DateTime.now());
  @override
  void initState() {
    _titleController.text = widget.notesModel.title;
    _descriptionController.text = widget.notesModel.description;
    creationTime=widget.notesModel.creationTime;
    super.initState();
  }
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
                  if(state is NotesUpdated){
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => HomePage()));
                  }else if(state is NotesUpdateError){
                    Fluttertoast.showToast(
                        msg: "Error updating the notes",
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
                  if(state is NotesUpdating){
                    return Lottie.asset('assets/lottie/loader.json');
                  }


                  return TextButton(onPressed: (){
                  context.read<NotesCubit>().updateNotes(widget.notesModel);
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
                  padding: const EdgeInsets.only(left: 20,right: 10),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text(creationTime,style:GoogleFonts.poppins(color: Colors.grey,fontSize: 12.0,) ,),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller:_titleController,
                        onChanged: (inputText){
                          widget.notesModel.title = inputText;

                        },

                        decoration: InputDecoration.collapsed(hintText: "Title"),
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          controller: _descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (inputText) {
                            widget.notesModel.description = inputText;
                          },
                          decoration: InputDecoration.collapsed(hintText: "Description"),
                          style: TextStyle(
                              fontSize: 12.0,

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