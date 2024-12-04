import 'package:flutter/material.dart';

class Kassir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // BottomNavigationBar uchun sahifalar ro'yxati
  final List<Widget> _screens = [
    BookingList(),
    Center(child: Text("Profile Screen", style: TextStyle(fontSize: 24))),
    Center(child: Text("Settings Screen", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Кассир"),
      ),
      body: _screens[_currentIndex], // Tanlangan sahifa
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Счёта",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: "Отчёт",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Смена",
          ),
        ],
      ),
    );
  }
}

// Model uchun class
class Booking {
  final String title;
  final String number;
  final double price;
  final String time;
  final IconData icon;

  Booking({
    required this.title,
    required this.number,
    required this.price,
    required this.time,
    required this.icon,
  });
}

// ListView Builder sahifasi
class BookingList extends StatelessWidget {
  final List<Booking> bookings = [
    Booking(
      title: 'Поситель',
      number: '№101',
      price: 120.0,
      time: '10:30 AM',
      icon: Icons.person,
    ),
    Booking(
      title: 'Тапчан',
      number: '№202',
      price: 200.0,
      time: '12:00 PM',
      icon: Icons.king_bed,
    ),
    Booking(
      title: 'VIP1',
      number: '№303',
      price: 500.0,
      time: '3:00 PM',
      icon: Icons.star,
    ),
    Booking(
      title: 'VIP2',
      number: '№404',
      price: 700.0,
      time: '6:00 PM',
      icon: Icons.star_border,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];

        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(
                booking.icon,
                color: Colors.white,
              ),
            ),
            title: Text(
              '${booking.title} (${booking.number})',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Summa: \$${booking.price.toStringAsFixed(2)}'),
                Text('Vaqt: ${booking.time}'),
              ],
            ),
            trailing: Icon(Icons.more_vert),
          ),
        );
      },
    );
  }
}
