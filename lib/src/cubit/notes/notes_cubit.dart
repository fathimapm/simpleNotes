import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../models/notes_model.dart';
import 'notes_repository.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesRepository _repository =NotesRepository();
  NotesCubit() : super(NotesInitial());
  createNotes(NotesModel notesModel)async{
    emit(NotesCreating());
    try{
      await _repository.createNotes(notesModel);
      emit(NotesCreated());
      await Future.delayed(Duration(seconds: 1));
      getAllNotes();
    }catch(ex){
      emit(NotesCreateError());
    }
  }
  updateNotes(NotesModel updatedNotes)async{
    emit(NotesUpdating());
    try{
      await _repository.updateNotes(updatedNotes);
      emit(NotesUpdated());
      await Future.delayed(Duration(seconds: 1));

      getAllNotes();
    }catch(ex){
      emit(NotesUpdateError());
    }
  }
  deleteNotes(NotesModel notesModel)async{
    emit(NotesDeleting());
    try{
      await _repository.deleteNotes(notesModel);
      emit(NotesDeleted(notesModel));
      await Future.delayed(Duration(seconds: 1));
      getAllNotes();
    }catch(ex){
      emit(NotesUpdateError());
    }
  }

  getAllNotes()async{
    emit(NotesLoading());
    try{
      QuerySnapshot snapshot = await _repository.getAllNotes();

      List<NotesModel> notesList =snapshot.docs.map<NotesModel>((e) {
        Map<String, dynamic>  dx = e.data() as Map<String, dynamic>;
        String id =e.id;
        NotesModel notesModel = NotesModel.fromJson(dx);
        notesModel.id =id;
        return notesModel;
      }).toList();
      emit(NotesLoaded(notesList));

    }catch(ex){
      emit(NotesLoadError());
    }
  }
}


