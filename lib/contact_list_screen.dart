import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state_manager.dart';
import 'add_edit_contact_screen.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactManager = Provider.of<ContactManager>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Contact Manager')),
      body: ListView.builder(
        itemCount: contactManager.contacts.length,
        itemBuilder: (context, index) {
          final contact = contactManager.contacts[index];
          return ListTile(
            title: Text(contact['name']),
            subtitle: Text(contact['phone']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddEditContactScreen(contact: contact),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => contactManager.deleteContact(contact['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddEditContactScreen()),
        ),
      ),
    );
  }
}
