import 'package:flutter/material.dart';
import '../DatabaseHelper.dart';
import '../model/Item.dart';
class Tabbar1 extends StatefulWidget {
  const Tabbar1({super.key});
  @override
  State<Tabbar1> createState() => _Tabbar1State();
}
class _Tabbar1State extends State<Tabbar1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchItems();
  }
  late TabController _tabController;
  List<Item> _items = [];
  final _textController = TextEditingController();
  final _dbHelper = DatabaseHelper.instance;
  Future<void> _fetchItems() async {
    final items = await _dbHelper.fetchItems();
    setState(() {
      _items = items;
    });
  }
  Future<void> _addItem(String name) async {
    if (name.isEmpty) return;
    await _dbHelper.insertItem(Item(name: name));
    _textController.clear();
    _fetchItems();
  }
  Future<void> _updateItem(Item item) async {
    final newName = await _showEditDialog(item.name);
    if (newName != null && newName.isNotEmpty) {
      await _dbHelper.updateItem(Item(id: item.id, name: newName));
      _fetchItems();
    }
  }
  Future<void> _deleteItem(int id) async {
    await _dbHelper.deleteItem(id);
    _fetchItems();
  }
  Future<String?> _showEditDialog(String currentName) async {
    final editController = TextEditingController(text: currentName);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Item"),
        content: TextField(
          controller: editController,
          decoration: InputDecoration(hintText: "Enter new name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(editController.text),
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount:10, // Mahsulotlar soni
              itemBuilder: (context, index) {

                return InkWell(
                  onLongPress: (){
                    _showBottomSheet(index as Item);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Кока-кола классик пластик 2л"),
                            Text("800"),
                          ],
                        ),
                       Container(
                           decoration: BoxDecoration(
                               color: Colors.green,
                               borderRadius: BorderRadius.circular(100) // более 50% ширины делает круг
                           ),
                       child: Icon(Icons.add_sharp)),
                       Text("45"),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100) // более 50% ширины делает круг
                            ),
                            child: Icon(Icons.remove)),
                      ],
                    ) ,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child:ListView.builder(
            itemCount: 5, // Mahsulotlar soni
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 170,
                          height: 200,
                          color: Colors.yellow,
                          child: Center(child: Text("$index Блюда",style: TextStyle(fontSize: 25),)),
                        ),
                        SizedBox(width: 15,),

                        Container(
                          width: 170,
                          height: 200,
                          color: Colors.yellow,
                          child: Center(child: Text("$index Блюда",style: TextStyle(fontSize: 25),)),
                        ),
                      ],
                    ),
                  ],
                ) ,
              );
            },
          ), ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Поиск...",
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.qr_code_scanner, size: 30),
                  onPressed: () {
                    // Skaner funksiyasi qo'shish mumkin
                    print("Scan button pressed");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _showBottomSheet(Item item) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose Action",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.blue),
                title: Text("Edit"),
                onTap: () {
                  Navigator.pop(context); // BottomSheet-ni yopish
                  _updateItem(item);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text("Delete"),
                onTap: () {
                  Navigator.pop(context); // BottomSheet-ni yopish
                  _deleteItem(item.id!);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
