import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:primer_proyecto/firebase/firebase_auth.dart';
import 'package:primer_proyecto/responsive.dart';
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

  EmailAuth emailAuth = EmailAuth();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final txtEmail = TextFormField(
      decoration: const InputDecoration(
          icon: Icon(Icons.email),
          label: Text('Email: '),
          border: OutlineInputBorder()),
      controller: email,
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
        controller: password,
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

    final txtLogin = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text('Already have an account? Log in',
              style: Theme.of(context).textTheme.labelLarge)),
    );
    final btnRegister = SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        text: 'Sign up',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            emailAuth?.createUserWithEmailAndPassword(
                email: email.text, password: password.text);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
            Navigator.pushNamed(context, '/dash');
          }
          ;
        });

    final btnPhoto = InkWell(
      onTap: () {
        showSelectionDialog(context);
      },
      child: Icon(
        Icons.add_a_photo,
        size: 30.0,
      ),
    );

    final photo = AssetImage('assets/perfil_default.png');

    final imgAvatar = CircleAvatar(
      radius: 80.0,
      backgroundImage: _imageFile == null
          ? photo
          : Image.file(File(_imageFile!.path.toString())).image,
      backgroundColor: Colors.white10,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 0.5,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/fondo.png'))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Form(
                      key: _formKey,
                      child: Responsive(
                          mobile: MobileScreen(
                              imgAvatar: imgAvatar,
                              btnPhoto: btnPhoto,
                              spaceHorizontal: spaceHorizontal,
                              txtFirstName: txtFirstName,
                              txtLastName: txtLastName,
                              txtEmail: txtEmail,
                              txtPassword: txtPassword,
                              btnRegister: btnRegister,
                              txtLogin: txtLogin),
                          tablet: TabletDesktopScreen(
                              imgAvatar: imgAvatar,
                              btnPhoto: btnPhoto,
                              spaceHorizontal: spaceHorizontal,
                              txtFirstName: txtFirstName,
                              txtLastName: txtLastName,
                              txtEmail: txtEmail,
                              txtPassword: txtPassword,
                              btnRegister: btnRegister,
                              txtLogin: txtLogin),
                          desktop: TabletDesktopScreen(
                              imgAvatar: imgAvatar,
                              btnPhoto: btnPhoto,
                              spaceHorizontal: spaceHorizontal,
                              txtFirstName: txtFirstName,
                              txtLastName: txtLastName,
                              txtEmail: txtEmail,
                              txtPassword: txtPassword,
                              btnRegister: btnRegister,
                              txtLogin: txtLogin))),
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
                    leading: Icon(
                      Icons.camera,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: Text(
                      'Camera',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      selectOpction(context, ImageSource.gallery);
                    },
                    leading: Icon(Icons.image,
                        color: Theme.of(context).iconTheme.color),
                    title: Text('Gallery',
                        style: Theme.of(context).textTheme.bodyLarge),
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

class MobileScreen extends StatelessWidget {
  const MobileScreen({
    super.key,
    required this.imgAvatar,
    required this.btnPhoto,
    required this.spaceHorizontal,
    required this.txtFirstName,
    required this.txtLastName,
    required this.txtEmail,
    required this.txtPassword,
    required this.btnRegister,
    required this.txtLogin,
  });

  final CircleAvatar imgAvatar;
  final InkWell btnPhoto;
  final SizedBox spaceHorizontal;
  final TextFormField txtFirstName;
  final TextFormField txtLastName;
  final TextFormField txtEmail;
  final TextFormField txtPassword;
  final SocialLoginButton btnRegister;
  final Padding txtLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        imgAvatar,
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
        txtLogin
      ],
    );
  }
}

class TabletDesktopScreen extends StatelessWidget {
  const TabletDesktopScreen({
    super.key,
    required this.imgAvatar,
    required this.btnPhoto,
    required this.spaceHorizontal,
    required this.txtFirstName,
    required this.txtLastName,
    required this.txtEmail,
    required this.txtPassword,
    required this.btnRegister,
    required this.txtLogin,
  });

  final CircleAvatar imgAvatar;
  final InkWell btnPhoto;
  final SizedBox spaceHorizontal;
  final TextFormField txtFirstName;
  final TextFormField txtLastName;
  final TextFormField txtEmail;
  final TextFormField txtPassword;
  final SocialLoginButton btnRegister;
  final Padding txtLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imgAvatar,
            spaceHorizontal,
            btnPhoto,
            spaceHorizontal,
            txtLogin
          ],
        )),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              child: Column(
                children: [
                  txtFirstName,
                  spaceHorizontal,
                  txtLastName,
                  spaceHorizontal,
                  txtEmail,
                  spaceHorizontal,
                  txtPassword,
                  spaceHorizontal,
                  btnRegister
                ],
              ),
            ),
          ],
        ))
      ],
    );
  }
}

bool validateStructure(String value) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
