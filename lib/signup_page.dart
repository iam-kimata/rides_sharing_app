import 'package:flutter/material.dart';

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

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController licensePlateNumberController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Method to reset all input field controllers
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              const Text(
                "Register Now",
                style: TextStyle(
                  fontSize: 35,
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
                  onPressed: () {
                    // Handle it locally before implement it actually
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Success"),
                          content: const Text("Account created locally!"),
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
                    resetInputFields(); // Reset input fields after "registration"
                  },
                  color: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
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
}

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
