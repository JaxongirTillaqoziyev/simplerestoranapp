import 'package:flutter/material.dart';

import 'SecondScreen.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Выбор"),
      actions: [
        Icon(Icons.search,size: 40,),
      SizedBox(width: 10,)
      ],),
      body: Column(
        children: [
          SizedBox(width: 15,),
           Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
             InkWell(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Secondscreen()));
               },
               child: Container(width: 150,
                 height: 200,
                 decoration: BoxDecoration(color: Colors.yellowAccent),
                 child: Center(child: Text("Оснавной зал")),
               ),
             ),
             SizedBox(width: 15,),
             Container(width: 150,
               height: 200,
               decoration: BoxDecoration(color: Colors.yellow),
               child: Center(child: Text("Летка")),
             ),
           ],),
          SizedBox(height: 15,),
          Row(
            children: [
            Container(width: 150,
              height: 200,
              decoration: BoxDecoration(color: Colors.white, border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu_book),

                  Text("Vip1"),
                ],
              ),
            ),
            SizedBox(width: 15,),
              Container(width: 150,
                height: 200,
                decoration: BoxDecoration(color: Colors.white, border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.print),

                    Text("Vip1"),
                  ],
                ),
              ),

          ],)
         ],
      ),
    );
  }
}
