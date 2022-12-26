part of 'notes_cubit.dart';

abstract class NotesState extends Equatable {
  const NotesState();
}

class NotesInitial extends NotesState {
  @override
  List<Object> get props => [];
}
class NotesLoading extends NotesState {
  @override
  List<Object> get props => [];
}
class NotesLoaded extends NotesState {
  final List<NotesModel> notesList;

  const NotesLoaded(this.notesList);

  @override
  List<Object> get props => [notesList];
}
class NotesLoadError extends NotesState {
  @override
  List<Object> get props => [];
}
class NotesUpdating extends NotesState {
  @override
  List<Object> get props => [];
}
class NotesUpdated extends NotesState {
  @override
  List<Object> get props => [];
}
class NotesUpdateError extends NotesState {
  @override
  List<Object> get props => [];
}
class NotesCreating extends NotesState {
  @override
  List<Object> get props => [];
}
class NotesCreated extends NotesState {
  @override
  List<Object> get props => [];
}
class NotesCreateError extends NotesState {
  @override
  List<Object> get props => [];
}
class NotesDeleting extends NotesState {
  @override
  List<Object> get props => [];
}
class NotesDeleted extends NotesState {
  final NotesModel notesModel;
  const NotesDeleted(this.notesModel);
  @override
  List<Object> get props => [notesModel];
}
class NotesDeleteError extends NotesState {
  @override
  List<Object> get props => [];
}