import 'package:flutter/material.dart';

void main() {
  runApp(ContactApp());
}

class ContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      home: ContactListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Contact {
  final String name;
  final String number;

  Contact(this.name, this.number);
}

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  final List<Contact> contacts = [];

  void _addContact() {
    String name = nameController.text.trim();
    String number = numberController.text.trim();

    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        contacts.add(Contact(name, number));
      });
      nameController.clear();
      numberController.clear();
    }
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to delete this contact?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cancel
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                contacts.removeAt(index);
              });
              Navigator.of(context).pop(); // Confirm delete
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile(int index) {
    final contact = contacts[index];
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(
        contact.name,
        style: TextStyle(color: Colors.red), // Name in red
      ),
      subtitle: Text(contact.number),
      trailing: Icon(Icons.phone),
      onLongPress: () => _confirmDelete(index),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: _inputDecoration('Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: numberController,
              decoration: _inputDecoration('Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addContact,
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white), // Button text in white
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Square shape
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) => _buildContactTile(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
