import 'package:flutter/material.dart';
import 'package:restoran_app/Kassir.dart';
import 'package:restoran_app/tabbar1/tabbar1.dart';
import 'package:restoran_app/tabbar1/tabbar2.dart';
import 'DatabaseHelper.dart';
import 'model/Item.dart';
class Secondscreen extends StatefulWidget {
  @override
  _SecondscreenState createState() => _SecondscreenState();
}
class _SecondscreenState extends State<Secondscreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Режим продаж"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Товары(2300)"),
            Tab(text: "Параметры"),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black26,
              ),
              child: Column(
                children: [
                  Text(
                    "Иванов Иван Иванович ",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    "Сотрудник",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),

            ),
            ListTile(
              leading: Icon(Icons.change_circle_rounded,size: 40,),
              title: Text("Синхронизатсия (04.12.2024 21:53)"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_sharp,size: 40,),
              title: Text("Кассир"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Kassir()));
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_walk_outlined,size: 40,),
              title: Text("Официант"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket,size: 40,),
              title: Text("Режим продаж"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.menu_book,size: 40,),
              title: Text("Склад"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app_outlined,size: 40,),
              title: Text("Сменит сотрудника"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
           Tabbar1(),
           Tabbar2(),
        ],
      ),
    );
  }
}
