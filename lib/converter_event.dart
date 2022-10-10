import 'package:flutter_application_2/main.dart';

abstract class ConverterEvent extends MyApp {
  const ConverterEvent();
  @override
  List<Object?> get props => [];
}

class OpenMyDocument extends ConverterEvent {
  final String NameMyDocument;

  OpenMyDocument({required this.NameMyDocument});
}
