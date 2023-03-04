import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:primer_proyecto/responsive.dart';
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

  final imageLogo = Image.asset('assets/logo.png');

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
                  Positioned(top: 20, child: Lottie.asset('a')),
                  Responsive(
                    mobile: MobileLoginScreen(
                        spaceHorizontal: spaceHorizontal,
                        txtEmail: txtEmail,
                        txtPassword: txtPassword,
                        btnEmail: btnEmail,
                        btnGoogle: btnGoogle,
                        btnFacebook: btnFacebook,
                        btnGithub: btnGithub,
                        txtRegister: txtRegister),
                    tablet: TabletDesktopScreen(
                        spaceHorizontal: spaceHorizontal,
                        txtEmail: txtEmail,
                        txtPassword: txtPassword,
                        btnEmail: btnEmail,
                        btnGoogle: btnGoogle,
                        btnFacebook: btnFacebook,
                        btnGithub: btnGithub,
                        txtRegister: txtRegister),
                    desktop: TabletDesktopScreen(
                        spaceHorizontal: spaceHorizontal,
                        txtEmail: txtEmail,
                        txtPassword: txtPassword,
                        btnEmail: btnEmail,
                        btnGoogle: btnGoogle,
                        btnFacebook: btnFacebook,
                        btnGithub: btnGithub,
                        txtRegister: txtRegister),
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

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    super.key,
    required this.spaceHorizontal,
    required this.txtEmail,
    required this.txtPassword,
    required this.btnEmail,
    required this.btnGoogle,
    required this.btnFacebook,
    required this.btnGithub,
    required this.txtRegister,
  });

  final SizedBox spaceHorizontal;
  final TextFormField txtEmail;
  final TextFormField txtPassword;
  final SocialLoginButton btnEmail;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;
  final SocialLoginButton btnGithub;
  final Padding txtRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LogoImage(),
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
    );
  }
}

class TabletDesktopScreen extends StatelessWidget {
  const TabletDesktopScreen({
    super.key,
    required this.spaceHorizontal,
    required this.txtEmail,
    required this.txtPassword,
    required this.btnEmail,
    required this.btnGoogle,
    required this.btnFacebook,
    required this.btnGithub,
    required this.txtRegister,
  });

  final SizedBox spaceHorizontal;
  final TextFormField txtEmail;
  final TextFormField txtPassword;
  final SocialLoginButton btnEmail;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;
  final SocialLoginButton btnGithub;
  final Padding txtRegister;

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
          children: [LogoImage(), spaceHorizontal, txtRegister],
        )),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 450,
              child: Column(children: [
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
              ]),
            )
          ],
        ))
      ],
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Spacer(),
            Expanded(child: Image.asset("assets/logo.png")),
            Spacer()
          ],
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
