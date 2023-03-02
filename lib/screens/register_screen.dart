import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  XFile? _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  final txtFirstName = TextFormField(
    decoration: const InputDecoration(
        icon: Icon(Icons.person),
        label: Text('First Name: '),
        border: OutlineInputBorder()),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your first name';
      }
      return null;
    },
  );
  final txtLastName = TextFormField(
      decoration: const InputDecoration(
          icon: Icon(Icons.person),
          label: Text('Last Name: '),
          border: OutlineInputBorder()),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your last name';
        }
        return null;
      });
  final txtEmail = TextFormField(
    decoration: const InputDecoration(
        icon: Icon(Icons.email),
        label: Text('Email: '),
        border: OutlineInputBorder()),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      } else if (!EmailValidator.validate(value, true)) {
        return 'Invalid email, please enter valid email';
      } else {
        return null;
      }
    },
  );
  final txtPassword = TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
          icon: Icon(Icons.password),
          label: Text('Password: '),
          border: OutlineInputBorder()),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        } else if (!validateStructure(value)) {
          return 'Please enter valid password';
        } else {
          return null;
        }
      });
  final spaceHorizontal = SizedBox(
    height: 10,
  );

  final btnGoogle = SocialLoginButton(
      buttonType: SocialLoginButtonType.google, onPressed: () {});

  @override
  Widget build(BuildContext context) {
    final txtLogin = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text('Already have an account? Log in',
              style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  color: Colors.blueGrey))),
    );
    final btnRegister = SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        text: 'Sign up',
        backgroundColor: Colors.blue,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
            Navigator.pushNamed(context, '/dash');
          }
        });

    final btnPhoto = InkWell(
      onTap: () {
        showSelectionDialog(context);
      },
      child: Icon(
        Icons.add_a_photo,
        color: Colors.grey,
        size: 30.0,
      ),
    );

    final photo = AssetImage('assets/perfil_default.png');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 0.7,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/fondo_pantalla.png'))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 80.0,
                            backgroundImage: _imageFile == null
                                ? photo
                                : Image.file(File(_imageFile!.path.toString()))
                                    .image,
                            backgroundColor: Colors.white10,
                          ),
                          btnPhoto,
                          spaceHorizontal,
                          txtFirstName,
                          spaceHorizontal,
                          txtLastName,
                          spaceHorizontal,
                          txtEmail,
                          spaceHorizontal,
                          txtPassword,
                          spaceHorizontal,
                          btnRegister,
                          spaceHorizontal,
                          Text('or'),
                          spaceHorizontal,
                          btnGoogle,
                          spaceHorizontal,
                          txtLogin
                        ],
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showSelectionDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      selectOpction(context, ImageSource.camera);
                    },
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blueGrey,
                    ),
                    title: Text('Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      selectOpction(context, ImageSource.gallery);
                    },
                    leading: const Icon(
                      Icons.image,
                      color: Colors.blueGrey,
                    ),
                    title: Text('Gallery'),
                  )
                ],
              ),
            ),
          );
        });
  }

  void selectOpction(BuildContext context, ImageSource source) async {
    final XFile? image = await _imagePicker.pickImage(source: source);
    setState(() {
      _imageFile = image;
    });
    Navigator.of(context).pop();
  }
}

bool validateStructure(String value) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
