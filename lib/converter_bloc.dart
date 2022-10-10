import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_2/converter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'converter_event.dart';

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  ConverterBloc() : super(const ConverterState()) {
    on<ConverterEvent>((event, emit) async {
      if (event is OpenMyDocument) {
        await GetAnExtension(event, state, emit);
      } else {}
    });
  }

  Future GetAnExtension(OpenMyDocument event, ConverterState state,
      Emitter<ConverterState> emit) async {
    emit(state.copyWith(fileName: event.NameMyDocument));
  }
}
