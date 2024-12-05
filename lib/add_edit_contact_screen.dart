import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state_manager.dart';

class AddEditContactScreen extends StatelessWidget {
  final Map<String, dynamic>? contact;

  AddEditContactScreen({Key? key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(
      text: contact?['name'] ?? '',
    );
    final phoneController = TextEditingController(
      text: contact?['phone'] ?? '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(contact == null ? 'Add Contact' : 'Edit Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                hintText: 'Enter 10-digit phone number',
              ),
              keyboardType: TextInputType.number,
              maxLength: 10,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final phone = phoneController.text.trim();

                if (phone.length != 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Phone number must be exactly 10 digits.'),
                    ),
                  );
                  return;
                }

                try {
                  await Provider.of<ContactManager>(context, listen: false)
                      .addOrUpdateContact(
                    contact: contact,
                    name: name,
                    phone: phone,
                  );
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
