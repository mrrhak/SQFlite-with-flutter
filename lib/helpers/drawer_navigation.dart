import 'package:flutter/material.dart';
import 'package:todo_list/screens/categories_screen.dart';
import 'package:todo_list/screens/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Mrr Hak"),
              accountEmail: Text("longkimhak@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://graph.facebook.com/1268960070112421/picture?type=large"),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen()),
                );
              },
              leading: Icon(Icons.view_list),
              title: Text("Categories"),
            ),
          ],
        ),
      ),
    );
  }
}
