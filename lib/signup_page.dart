import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rides_sharing_app/api/api.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? selectedCategory = "Student";
  String? selectedVehicleType;
  String? selectedVehicleColor;
  String? selectedWorkingLocation;

  bool isLoading = false; // <-- ADDED

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController licensePlateNumberController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void resetInputFields() {
    fullNameController.clear();
    phoneNumberController.clear();
    emailController.clear();
    licensePlateNumberController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Register Now",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              inputFile(
                label: "Select Category",
                options: ["Student", "Driver"],
                selectedValue: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                    if (value == "Student") {
                      selectedVehicleType = null;
                      selectedVehicleColor = null;
                      selectedWorkingLocation = null;
                    }
                  });
                },
              ),
              if (selectedCategory == "Student" ||
                  selectedCategory == null) ...[
                inputFile(label: "Full Name", controller: fullNameController),
                inputFile(
                    label: "Phone Number", controller: phoneNumberController),
                inputFile(label: "Email", controller: emailController),
              ],
              if (selectedCategory == "Driver") ...[
                inputFile(label: "Full Name", controller: fullNameController),
                inputFile(
                    label: "Phone Number", controller: phoneNumberController),
                inputFile(label: "Email", controller: emailController),
                inputFile(
                  label: "Vehicle Type",
                  options: ["Taxi", "Bajaji", "XL"],
                  selectedValue: selectedVehicleType,
                  onChanged: (value) {
                    setState(() {
                      selectedVehicleType = value;
                    });
                  },
                ),
                inputFile(
                  label: "Vehicle Color",
                  options: ["Black", "White", "Red"],
                  selectedValue: selectedVehicleColor,
                  onChanged: (value) {
                    setState(() {
                      selectedVehicleColor = value;
                    });
                  },
                ),
                inputFile(
                    label: "License Plate Number",
                    controller: licensePlateNumberController),
                inputFile(
                  label: "Working Location",
                  options: [
                    "Mbezi",
                    "Kimara",
                    "Ubungo",
                    "Makongo",
                    "Mwenge",
                    "Kariakoo",
                    "Makumbusho",
                  ],
                  selectedValue: selectedWorkingLocation,
                  onChanged: (value) {
                    setState(() {
                      selectedWorkingLocation = value;
                    });
                  },
                ),
              ],
              inputFile(
                  label: "Password",
                  controller: passwordController,
                  obscureText: true),
              inputFile(
                  label: "Confirm Password",
                  controller: confirmPasswordController,
                  obscureText: true),
              Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: isLoading
                      ? null
                      : () {
                          registerUser(); // <-- ADDED
                        },
                  color: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?"),
                    Text(
                      " Sign in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- BACKEND FUNCTION ADDED ---------------- //
  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('${baseUrl}/register');

    final body = json.encode({
      'role': selectedCategory,
      'fullname': fullNameController.text,
      'phonenumber': phoneNumberController.text,
      'email': emailController.text,
      'vehicletype': selectedCategory == "Driver" ? selectedVehicleType : null,
      'vehiclecolor':
          selectedCategory == "Driver" ? selectedVehicleColor : null,
      'platenumber': selectedCategory == "Driver"
          ? licensePlateNumberController.text
          : null,
      'location': selectedCategory == "Driver" ? selectedWorkingLocation : null,
      'password': passwordController.text,
      'cpassword': confirmPasswordController.text,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        print('Registration successful: ${responseBody['message']}');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Success"),
              content: const Text("Account created successfully!"),
              actions: <Widget>[
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );

        resetInputFields();
      } else {
        print('Failed: ${response.body}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Failed"),
              content: Text("Failed to register: ${response.body}"),
              actions: <Widget>[
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("Error: $e"),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

// -------------------------------------------------------------- //

Widget inputFile({
  required String label,
  List<String>? options,
  String? selectedValue,
  void Function(String?)? onChanged,
  bool obscureText = false,
  TextEditingController? controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 5),
      if (options != null)
        DropdownButtonFormField<String>(
          dropdownColor: Colors.white,
          value: selectedValue,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      if (options == null)
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      const SizedBox(height: 30),
    ],
  );
}
