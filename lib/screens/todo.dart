import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../databases/dbhelper.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});
  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final TextEditingController _controller = TextEditingController();

  late Future<Database> database;

  void initDatabase() {
    database = DBHelper.getDatabase();
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: database.then((db) => db.query('todo')),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData && snapshot.data != null) {
                  List<Map<String, dynamic>> tmp_data =
                      snapshot.data! as List<Map<String, dynamic>>;
                  return ListView.builder(
                    itemCount: tmp_data.length,
                    itemBuilder: (context, index) {
                      return getItemTodo(index, tmp_data[index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return const Center(child: Text('No Data Available'));
              },
            ),
          ),
          getBottomForm(),
        ],
      ),
    );
  }

  Widget getBottomForm() {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'New todo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final db = await database;
              await db.insert('todo', {'title': _controller.text, 'done': 0});
              _controller.text = '';
              setState(() {});
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget getItemTodo(int index, Map<String, dynamic> item) {
    return Card(
      child: Container(
        height: 40,
        child: ListTile(
          title: Text(item['title']),
          leading: Checkbox(
            value: item['done'] == 1,
            onChanged: (value) async {
              final db = await database;
              await db.update(
                'todo',
                {'done': value! ? 1 : 0},
                where: 'id = ?',
                whereArgs: [item['id']],
              );
              setState(() {});
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {//your implementaiton here..
            },
          ),
        ),
      ),
    );
  }
}