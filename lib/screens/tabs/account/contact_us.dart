import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  String? _selectedSubject;

  final List<String> subjects = ['Support', 'Sales', 'Feedback', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(height: 160, color: const Color(0xFFCBD9FF)),
                ),
                SafeArea(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F1E5B),
                      ),
                    ),
                    const SizedBox(height: 24),
                    buildTextField(
                      label: "Name",
                      controller: _nameController,
                      validatorMessage: "Please enter your name",
                    ),
                    buildTextField(
                      label: "Email",
                      controller: _emailController,
                      validatorMessage: "Please enter your email",
                    ),
                    buildTextField(
                      label: "Phone",
                      controller: _phoneController,
                      validatorMessage: "Please enter your phone",
                    ),
                    buildDropdown(),
                    buildTextField(
                      label: "Comment",
                      controller: _commentController,
                      validatorMessage: "Please enter your comment",
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildSocialIcon('assets/medsos/tiktok.png'),
                          buildSocialIcon('assets/medsos/wa.png'),
                          buildSocialIcon('assets/medsos/ig.png'),
                          buildSocialIcon('assets/medsos/yt.png'),
                          buildSocialIcon('assets/medsos/x.png'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1F1E5B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 16,
                          ),
                        ),
                        onPressed: () {
                          setState(() {});
                          if (_formKey.currentState!.validate()) {
                            // Do something like submit data
                          }
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    required String validatorMessage,
    int maxLines = 1,
  }) {
    bool hasError = controller.text.isEmpty;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: "Enter Your $label",
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              errorStyle: const TextStyle(height: 0), // Hide default error text
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return validatorMessage;
              }
              return null;
            },
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child:
                hasError
                    ? Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        validatorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                        key: ValueKey(label),
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown() {
    bool hasError = _selectedSubject == null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Subject"),
          DropdownButtonFormField<String>(
            value: _selectedSubject,
            hint: const Text("Select Subject"),
            items:
                subjects.map((subject) {
                  return DropdownMenuItem<String>(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedSubject = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select subject';
              }
              return null;
            },
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              errorStyle: TextStyle(height: 0),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child:
                hasError
                    ? const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "Please select subject",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                        key: ValueKey('subject_error'),
                      ),
                    )
                    : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget buildSocialIcon(String assetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Image.asset(assetPath, height: 40, width: 40),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
