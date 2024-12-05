import 'package:flutter/material.dart';
import 'data.dart';

class ContactManager extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _contacts = [];

  List<Map<String, dynamic>> get contacts => _contacts;

  ContactManager() {
    loadContacts();
  }

  Future<void> loadContacts() async {
    _contacts = await _dbHelper.fetchContacts();
    notifyListeners();
  }

  Future<void> addOrUpdateContact({
    Map<String, dynamic>? contact,
    required String name,
    required String phone,
  }) async {
    if (phone.length != 10) {
      throw Exception('Phone number must be exactly 10 digits.');
    }

    if (contact == null) {
      await _dbHelper.insertContact({'name': name, 'phone': phone});
    } else {
      await _dbHelper
          .updateContact(contact['id'], {'name': name, 'phone': phone});
    }
    loadContacts();
  }

  Future<void> deleteContact(int id) async {
    await _dbHelper.deleteContact(id);
    loadContacts();
  }
}
