import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/features/notes/data/cubits/add_notes_cubit/add_notes_cubit.dart';
import 'package:note_app/features/notes/data/cubits/notes_cubit/notes_cubit_cubit.dart';
import 'package:note_app/features/notes/presentation/widgets/add_note_form.dart';

class AddNoteButtonSheet extends StatelessWidget {
  const AddNoteButtonSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNotesCubit(),
      child: BlocConsumer<AddNotesCubit, AddNotesState>(
        listener: (context, state) {
          if (state is AddNotesSuccessState) {
            BlocProvider.of<NotesCubitCubit>(context).fetchNotes();
            Navigator.of(context).pop();
          }
          if (state is AddNotesFailureState) {}
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is AddNotesLoadingState ? true : false,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 25.h,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10.h,
              ),
              child: const SingleChildScrollView(
                child: AddNoteForm(),
              ),
            ),
          );
        },
      ),
    );
  }
}
