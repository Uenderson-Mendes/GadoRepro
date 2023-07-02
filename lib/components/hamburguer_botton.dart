import 'package:flutter/material.dart';

class BottomNavigationItems {
  static List<BottomNavigationBarItem> getItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_circle, size: 40),
        label: 'Adicionar',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
        label: 'Alerta',
      ),
    ];
  }
}
