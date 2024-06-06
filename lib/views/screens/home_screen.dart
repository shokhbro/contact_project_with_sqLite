import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:new_contact/models/contact.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  List<Contact> contacts = [];

  void addContact() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            "Add Contact",
            style: TextStyle(fontFamily: 'Lato'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  labelText: "name",
                ),
              ),
              const Gap(10),
              TextFormField(
                controller: surnameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  labelText: "surname",
                ),
              ),
              const Gap(10),
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  labelText: "phone number",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final newContact = Contact(
                    id: 1,
                    name: nameController.text,
                    surname: surnameController.text,
                    phoneNumber: phoneNumberController.text,
                  );
                  contacts.add(newContact);
                  nameController.clear();
                  surnameController.clear();
                  phoneNumberController.clear();

                  Navigator.pop(context);
                });
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void editContact(Contact contact) {
    nameController.text = contact.name;
    surnameController.text = contact.surname;
    phoneNumberController.text = contact.phoneNumber;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            "Add Contact",
            style: TextStyle(fontFamily: 'Lato'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  labelText: "name",
                ),
              ),
              const Gap(10),
              TextFormField(
                controller: surnameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  labelText: "surname",
                ),
              ),
              const Gap(10),
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  labelText: "phone number",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Bekor qilish"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  contact.name = nameController.text;
                  contact.surname = surnameController.text;
                  contact.phoneNumber = phoneNumberController.text;

                  nameController.clear();
                  surnameController.clear();
                  phoneNumberController.clear();

                  Navigator.pop(context);
                });
              },
              child: const Text("Qo'shish"),
            ),
          ],
        );
      },
    );
  }

  void deleteContact(Contact contact) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            "Delete Contact",
            style: TextStyle(fontFamily: 'Lato'),
          ),
          content: const Text("Are you sure you want to delete this contact?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  contacts.remove(contact);
                  Navigator.pop(context);
                });
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Color getRandomColor() {
    final random = Random();

    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text(
          "Contacts",
          style: TextStyle(
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(6.0),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: getRandomColor(),
                    ),
                    title: Text(
                      "${contact.name} ${contact.surname}",
                      style: const TextStyle(
                        fontFamily: 'Lato',
                      ),
                    ),
                    subtitle: Text(
                      contact.phoneNumber,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => editContact(contact),
                          icon: const Icon(Icons.edit),
                        ),
                        InkWell(
                          onTap: () => deleteContact(contact),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addContact,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
