import 'actualizar.dart';
import 'package:flutter/material.dart';

class Programa extends StatefulWidget {
  const Programa({Key? key}) : super(key: key);

  @override
  State<Programa> createState() => _ProgramaState();
}

class _ProgramaState extends State<Programa> {

  List<String> lista = [
    "Super",
    "Lavar el baño",
    "Hacer de comer",
    "Pagar las deudas",
    "Paseo con el perro"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do List"), centerTitle: true,),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, indice){
            return InkWell(
              onTap: (){
                actualizarEstudiante(indice);
              },
              child:
              ListTile(
                title: Text(lista[indice]),
                trailing: IconButton(onPressed: (){
                  borrarEstudiante(indice);

                }, icon: Icon(Icons.check_box_outline_blank_outlined)),
              ),
            );
          }
      ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          capturarTarea();
        },
          child: Icon(Icons.add)) ,

    );
  }

  void capturarTarea() {
    final nuevaTarea = TextEditingController();
    showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        context: context,
        builder: (builder){
          return Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 30,
              right: 30,
              bottom: MediaQuery.of(context).viewInsets.bottom+50
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(decoration: InputDecoration(labelText: "NUEVA TAREA"),
                controller: nuevaTarea, autofocus: true,),
                SizedBox(height: 10,),
                OutlinedButton(onPressed: (){
                  String nombre = nuevaTarea.text;
                  if(nombre.isEmpty) return;
                  setState(() {
                    lista.add(nombre);
                  });
                  Navigator.pop(context);
                }, child: Text("Agregar"))
              ],
            ),
          );
        });
  }

  void borrarEstudiante(int indice) {
    showDialog(context: context, builder: (builder){
      return AlertDialog(
        title: Text("FELICIDADES"),
        content: Text("Haz completado la tarea ${lista[indice]}"),
        actions: [
          OutlinedButton(onPressed: (){
            setState(() {
              lista.remove(lista[indice]);
              /* estudiantes.remoteAt(indice); */
            });
            Navigator.pop(context);
          }, child: Text("ACEPTAR")),
          OutlinedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("NO LA COMPLETÉ")),
        ],
      );
    });
  }

  void actualizarEstudiante(int indice) {
    showDialog(context: context, builder: (builder){
      return AlertDialog(
        title: Text("ACTUALIZANDO"),
        content: Text("¿EDITAR ${lista[indice]} ?"),
        actions: [
          OutlinedButton(onPressed: (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (builder){
              return Actualizar(tarea: lista[indice], indice: indice ,);
            })).then((value) {
              List<String> datos = value.toString().split("&");
              int indice = int.parse(datos[1]);
              setState(() {
                lista[indice] = datos[0];
              });
            });
          }, child: Text("SI")),
          OutlinedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("NO"))
        ],
      );
    });
  }
}
