import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<String> _todoItems = []; // Lista de tareas
  final List<bool> _isChecked = []; // Lista para marcar como completadas
  final TextEditingController _textFieldController = TextEditingController();

  // Función para agregar una nueva tarea
  void _addToDoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(task);
        _isChecked.add(false); // Por defecto, la nueva tarea no está completada
      });
      _textFieldController.clear();
    }
  }

  // Función para eliminar una tarea
  void _removeToDoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
      _isChecked.removeAt(index); // Eliminar también su estado de completada
    });
  }

  // Crear un cuadro de diálogo para ingresar la nueva tarea
  void _promptAddToDoItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar nueva tarea'),
          content: TextField(
            controller: _textFieldController,
            autofocus: true,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Agregar'),
              onPressed: () {
                _addToDoItem(_textFieldController.text);
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Construir la lista de tareas en pantalla
  Widget _buildToDoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        return _buildToDoItem(_todoItems[index], index);
      },
    );
  }

  // Crear cada ítem en la lista de tareas con la opción de marcar como completada
  Widget _buildToDoItem(String todoText, int index) {
    return ListTile(
      leading: Checkbox(
        value: _isChecked[index],
        onChanged: (bool? value) {
          setState(() {
            _isChecked[index] = value!;
          });
        },
      ),
      title: Text(
        todoText,
        style: TextStyle(
          decoration: _isChecked[index] ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _removeToDoItem(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: _buildToDoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddToDoItem,
        tooltip: 'Agregar tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}
