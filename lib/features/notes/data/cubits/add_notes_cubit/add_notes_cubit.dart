import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:note_app/core/constants/strings.dart';
import 'package:note_app/features/notes/models/note_model.dart';

part 'add_notes_state.dart';

class AddNotesCubit extends Cubit<AddNotesState> {
  AddNotesCubit() : super(AddNotesInitial());

  addNote(NoteModel note) async {
    emit(AddNotesLoadingState());
    try {
      var notesBox = Hive.box<NoteModel>(AppStrings.kNotesBox);
      await notesBox.add(note);
      emit(AddNotesSuccessState());
    } catch (e) {
      emit(
        AddNotesFailureState(
          errMessage: e.toString(),
        ),
      );
    }
  }
}
