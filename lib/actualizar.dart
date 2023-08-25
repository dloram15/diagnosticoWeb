import 'package:flutter/material.dart';

class Actualizar extends StatefulWidget {
  final String tarea;
  final int indice;
  const Actualizar({Key? key, required this.tarea, required this.indice}) : super(key: key);

  @override
  State<Actualizar> createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {
  final tareaActualizar = TextEditingController();

  @override
  void initState() {
    super.initState();
    tareaActualizar.text = widget.tarea;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ACTUALIZAR"),),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(decoration: InputDecoration(labelText: "TAREA: "), controller: tareaActualizar,
          autofocus: true,),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
            String regreso = tareaActualizar.text + "&" + widget.indice.toString();
            Navigator.pop(context, regreso);
          }, child: Text("ACTUALIZAR"))
        ],
      ),
    );
  }
}
