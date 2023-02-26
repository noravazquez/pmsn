import 'package:flutter/material.dart';
import 'package:primer_proyecto/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final txtEmail = TextFormField(
    decoration: const InputDecoration(
        label: Text('Email user'), border: OutlineInputBorder()),
  );
  final txtPassword = TextFormField(
    decoration: const InputDecoration(
        label: Text('Password user'), border: OutlineInputBorder()),
  );
  final spaceHorizontal = SizedBox(
    height: 10,
  );

  final btnGoogle = SocialLoginButton(
      buttonType: SocialLoginButtonType.google, onPressed: () {});
  final btnFacebook = SocialLoginButton(
      buttonType: SocialLoginButtonType.facebook, onPressed: () {});
  final btnGithub = SocialLoginButton(
      buttonType: SocialLoginButtonType.github, onPressed: () {});

  final imageLogo = Image.asset(
    'assets/logo.png',
    height: 200,
  );

  @override
  Widget build(BuildContext context) {
    final txtRegister = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text('Crear cuenta',
              style: TextStyle(
                  fontSize: 17,
                  decoration: TextDecoration.underline,
                  color: Colors.blueGrey))),
    );
    final btnEmail = SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        onPressed: () {
          isLoading = true;
          setState(() {});
          Future.delayed(Duration(milliseconds: 4000)).then((value) {
            isLoading = false;
            setState(() {});
            Navigator.pushNamed(context, '/dash');
          });
        });
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      txtEmail,
                      spaceHorizontal,
                      txtPassword,
                      spaceHorizontal,
                      btnEmail,
                      spaceHorizontal,
                      btnGoogle,
                      spaceHorizontal,
                      btnFacebook,
                      spaceHorizontal,
                      btnGithub,
                      spaceHorizontal,
                      txtRegister
                    ],
                  ),
                  Positioned(
                    top: 100,
                    child: imageLogo,
                  )
                ],
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container()
        ],
      ),
    );
  }
}
