import 'package:flutter/material.dart';

class EditProfileDriver extends StatefulWidget {
  const EditProfileDriver({super.key, required Map userData});

  @override
  State<EditProfileDriver> createState() => _EditProfileDriverState();
}

class _EditProfileDriverState extends State<EditProfileDriver> {
  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late FocusNode fullNameFocusNode;
  late FocusNode phoneNumberFocusNode;
  late FocusNode emailFocusNode;

  final Map<String, dynamic> userData = {
    'fullname': 'Paul Kenedy',
    'phonenumber': '0667132208',
    'email': 'paulkenedy26@gmail.com',
  };

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: userData['fullname']);
    phoneNumberController =
        TextEditingController(text: userData['phonenumber']);
    emailController = TextEditingController(text: userData['email']);
    fullNameFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
    emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    fullNameFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Personal Information',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            buildTextField("Full Name", fullNameController, fullNameFocusNode),
            buildTextField(
                "Phone Number", phoneNumberController, phoneNumberFocusNode),
            buildTextField("Email", emailController, emailFocusNode),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    // Increased vertical padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize:
                        const Size(150, 50), // Set minimum height and width
                  ),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    // Increased vertical padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize:
                        const Size(150, 50), // Set minimum height and width
                  ),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
    String labelText,
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
            color: focusNode.hasFocus ? Colors.blue : Colors.grey,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: labelText,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
