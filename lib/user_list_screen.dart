import 'dart:io';
import 'package:flutter/material.dart';
import 'package:contact_crud_app/add_user_screen.dart';
import 'package:contact_crud_app/edit_user_screen.dart';
import 'package:contact_crud_app/user_model.dart';
import 'package:contact_crud_app/db_helper.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> allUsers = [];
  List<User> filteredUsers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUser();
  }


  Future<void> loadUser() async {
    final data = await DBHelper.instance.getUsers();
    setState(() {
      allUsers = data;
      filteredUsers = data;
    });
  }


  void _filterUsers(String query) {
    setState(() {
      filteredUsers = allUsers
          .where((user) =>
      user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.phone.contains(query))
          .toList();
    });
  }


  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Contact"),
        content: const Text("Are you sure you want to delete this contact?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              await DBHelper.instance.deleteUser(id);
              Navigator.pop(context);
              loadUser();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }


  Future<void> _openEditScreen(User user) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: EditUserScreen(user: user),
        ),
      ),
    );
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Contacts"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddUserScreen()),
          );
          loadUser();
        },
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterUsers,
              decoration: InputDecoration(
                hintText: "Search name or phone...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    _filterUsers('');
                  },
                )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),


          Expanded(
            child: allUsers.isEmpty
                ? const Center(child: Text("No Contacts Saved Yet"))
                : filteredUsers.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 10),
                  Text("No results found for '${searchController.text}'",
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: user.image != null ? FileImage(File(user.image!)) : null,
                      child: user.image == null ? const Icon(Icons.person) : null,
                    ),

                    title: Text(
                        user.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(user.email, style: TextStyle(color: Colors.grey[700])),
                        Text(user.phone, style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _openEditScreen(user),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(user.id!),
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
    );
  }
}
