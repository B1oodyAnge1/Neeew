import 'package:flutter/animation.dart';
import 'package:flutter_application_2/main.dart';

class ConverterState extends MyApp {
  final String textT;
  final String fileName;
  const ConverterState({
    this.textT = '0000',
    this.fileName = ' ',
  });
  ConverterState copyWith({
    String? textT,
    String? fileName,
  }) {
    return ConverterState(
      textT: textT ?? this.textT,
      fileName: fileName ?? this.fileName,
    );
  }

  @override
  List<Object?> get props => [
        textT,
        fileName,
      ];
}
