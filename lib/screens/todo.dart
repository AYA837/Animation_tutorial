import 'package:flutter/material.dart';
import 'package:my_app/databases/tododb.dart';
import 'package:sqflite/sqflite.dart';
import '../databases/dbhelper.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});
  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final TextEditingController _controller = TextEditingController();

  late Future<List<Map<String , dynamic>>> dbRecords;
  

  void initDatabase() {
   dbRecords = TodoDB.instance.getRecords();
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
              future: dbRecords,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData && snapshot.data != null) {
                  List<Map<String, dynamic>> tmp_data =
                      snapshot.data!;
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
          const SizedBox(height: 45,),
        ],
      ),
    );
  }

  Widget getBottomForm() {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          const SizedBox(width: 10,),
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
              await TodoDB.instance.insertRecord(_controller.text, false);
              _controller.text = '';
               dbRecords =  TodoDB.instance.getRecords();
              setState(() {});
            },
            child: Text('Add'),
          ),
         const SizedBox(width: 15,),
        ],
      ),
      
    );
  }

  Widget getItemTodo(int index, Map<String, dynamic> item) {
    return Card(
      child: Container(
        
        height: 80,
        child: Center(
          child: ListTile(
            title: Text(item['title']),
            leading: Checkbox(
              value: item['done'] == 1,
              onChanged: (value) async {
             
                await TodoDB.instance.updateRecord(item['id'] , item);
                dbRecords = TodoDB.instance.getRecords();
                setState(() {});
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
          
               await TodoDB.instance.deleteRecord(item['id'] , item);
               dbRecords = TodoDB.instance.getRecords();
               setState(() {});
              },
            ),
          ),
        ),
      ),
    );
  }
}