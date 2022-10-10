import 'dart:async';
import 'dart:ffi';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'converter_bloc.dart';
import 'converter_event.dart';
import 'converter_state.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final List<String> items = [
    'Word',
    'Powerpoint',
    'Excel',
    'JPG',
  ];
  final List<String> items2 = [
    'Word',
    'Powerpoint',
    'Excel',
    'JPG',
  ];

  bool _loading = false;

  String? value;
  late bool Extension = false;

  @override
  Widget build(BuildContext contex) {
    return BlocProvider(
        create: ((context) => ConverterBloc()),
        child: BlocBuilder<ConverterBloc, ConverterState>(
            builder: (context, state) {
          return Scaffold(
              body: Container(
            padding: EdgeInsets.only(top: 40, left: 20),
            color: Colors.white,
            child: Column(children: [
              Row(
                children: [
                  TextButton(
                    onPressed: (() async {
                      // openMyFile();
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        PlatformFile file = result.files.first;
                        int found = 0;
                        String extensionString = file.name;
                        found = extensionString.indexOf('.');
                        extensionString = extensionString.substring(found + 1);
                        //Extension = extensionString;
                        var condition = extensionString.compareTo('pdf');
                        if (condition == 0) {
                          Extension = true;
                        } else {
                          Extension = false;
                        }
                        context.read<ConverterBloc>().add(OpenMyDocument(
                              NameMyDocument: file.name,
                            ));
                      }
                    }),
                    child: Text('Выбирите файл'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(57, 198, 198, 198))),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      'Файл: ${state.fileName}',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Row(children: [
                Container(
                    margin: EdgeInsets.only(top: 15),
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color.fromARGB(57, 198, 198, 198),
                            width: 2)),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                      value: value,
                      isExpanded: true,
                      items: (Extension == true)
                          ? items.map(buildMenuItem).toList()
                          : items2.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(
                        () {
                          this.value = value;
                          _loading = true;
                          Timer(Duration(seconds: 3), () {
                            setState(() {
                              _loading = false;
                            });
                          });
                        },
                      ),
                    ))),
              ]),
              Container(
                  child: Center(
                      child: _loading
                          ? _CircularProgressIndicator()
                          : Container())),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  child: TextButton(
                    onPressed: (() async {
                      // ignore: empty_statements
                      String? outputFile = await FilePicker.platform.saveFile(
                        dialogTitle: 'Please select an output file:',
                        fileName: 'output-file.pdf',
                      );
                    }),
                    child: Text('Скачать'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(57, 198, 198, 198))),
                  ),
                ),
              ),
            ]),
          ));
        }));
  }

  Widget _CircularProgressIndicator() {
    return CircularProgressIndicator();
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              fontSize: 10,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold),
        ),
      );
}
