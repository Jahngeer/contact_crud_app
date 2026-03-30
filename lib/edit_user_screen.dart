import 'package:flutter/material.dart';
import 'package:contact_crud_app/db_helper.dart';
import 'package:contact_crud_app/user_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditUserScreen extends StatefulWidget {
  final User user;
  const EditUserScreen({super.key, required this.user});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  File? pickedImage;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.user.name);
    emailCtrl = TextEditingController(text: widget.user.email);
    phoneCtrl = TextEditingController(text: widget.user.phone);
    if (widget.user.image != null) {
      pickedImage = File(widget.user.image!);
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => pickedImage = File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dialog ke andar Scaffold nahi, direct Material ya Container use karein
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Dialog size content ke mutabiq hoga
        children: [
          const Text("Edit Contact",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: pickImage,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
              backgroundImage: pickedImage != null ? FileImage(pickedImage!) : null,
              child: pickedImage == null ? const Icon(Icons.camera_alt, color: Colors.indigo) : null,
            ),
          ),

          const SizedBox(height: 20),
          TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder())),
          const SizedBox(height: 10),
          TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder())),
          const SizedBox(height: 10),
          TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: "Phone", border: OutlineInputBorder())),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                onPressed: () async {
                  await DBHelper.instance.updateUser(
                    User(
                      id: widget.user.id,
                      name: nameCtrl.text,
                      email: emailCtrl.text,
                      phone: phoneCtrl.text,
                      image: pickedImage?.path,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Save Changes"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
