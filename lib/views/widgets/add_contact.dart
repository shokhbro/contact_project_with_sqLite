import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:new_contact/models/contact.dart';

class AddContactDialog {
  static void show(BuildContext context, Function(Contact) onContactAdded) {
    final nameController = TextEditingController();
    final surnameController = TextEditingController();
    final phoneNumberController = TextEditingController();

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
                final newContact = Contact(
                  id: 0,
                  name: nameController.text,
                  surname: surnameController.text,
                  phoneNumber: phoneNumberController.text,
                );
                onContactAdded(newContact);
                nameController.clear();
                surnameController.clear();
                phoneNumberController.clear();
                Navigator.pop(context);
              },
              child: const Text("Qo'shish"),
            ),
          ],
        );
      },
    );
  }
}
