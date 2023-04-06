import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:primer_proyecto/firebase/firebase_auth.dart';
import 'package:primer_proyecto/provider/them_provider.dart';
import 'package:primer_proyecto/responsive.dart';
import 'package:primer_proyecto/widgets/loading_modal_widget.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _selectColor = "Light";
  List<String> _colors = ["Light", "Dark", "Sky"];

  bool isLoading = false;

  EmailAuth emailAuth = EmailAuth();

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

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

  void onThemeChange(String value, ThemeProvider themeProvider) async {
    if (value == "Light") {
      themeProvider.setThemeData(0, context);
    } else if (value == "Dark") {
      themeProvider.setThemeData(1, context);
    } else {
      themeProvider.setThemeData(2, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    final txtEmail = TextFormField(
      decoration: const InputDecoration(
          label: Text('Email user'), border: OutlineInputBorder()),
      controller: controllerEmail,
    );

    final txtPassword = TextFormField(
      decoration: const InputDecoration(
          label: Text('Password user'), border: OutlineInputBorder()),
      controller: controllerPassword,
    );

    final txtRegister = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: Text('Crear cuenta',
              style: Theme.of(context).textTheme.labelLarge)),
    );

    final txtAboutUs = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/onboarding');
          },
          child: const Text('About Us',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.black,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 2.0,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                        offset: Offset(1.0, 1.0))
                  ]))),
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
          /*isLoading = true;
          setState(() {});
          emailAuth
              .signInWithEmailAndPassword(
                  email: controllerEmail.text,
                  password: controllerPassword.text)
              .then((value) {
            if (value) {
              Navigator.pushNamed(context, '/dash');
            } else {
              //snackbar error
            }
          });
          isLoading = false;
          setState(() {});*/
        });

    final btnTheme = InkWell(
      onTap: () {
        themChangeDialog(theme);
      },
      child: const Icon(
        Icons.settings,
        size: 40.0,
      ),
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
              child: Responsive(
                  mobile: MobileScreen(
                      btnTheme: btnTheme,
                      txtAboutUs: txtAboutUs,
                      spaceHorizontal: spaceHorizontal,
                      txtEmail: txtEmail,
                      txtPassword: txtPassword,
                      btnEmail: btnEmail,
                      btnGoogle: btnGoogle,
                      btnFacebook: btnFacebook,
                      btnGithub: btnGithub,
                      txtRegister: txtRegister),
                  tablet: TabletDesktopScreen(
                      btnTheme: btnTheme,
                      txtAboutUs: txtAboutUs,
                      spaceHorizontal: spaceHorizontal,
                      txtEmail: txtEmail,
                      txtPassword: txtPassword,
                      btnEmail: btnEmail,
                      btnGoogle: btnGoogle,
                      btnFacebook: btnFacebook,
                      btnGithub: btnGithub,
                      txtRegister: txtRegister),
                  desktop: TabletDesktopScreen(
                      btnTheme: btnTheme,
                      txtAboutUs: txtAboutUs,
                      spaceHorizontal: spaceHorizontal,
                      txtEmail: txtEmail,
                      txtPassword: txtPassword,
                      btnEmail: btnEmail,
                      btnGoogle: btnGoogle,
                      btnFacebook: btnFacebook,
                      btnGithub: btnGithub,
                      txtRegister: txtRegister)),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container()
        ],
      ),
    );
  }

  themChangeDialog(ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          title: Text(
            "Seleccione un tema",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RadioGroup<String>.builder(
                    groupValue: _selectColor,
                    onChanged: (val) {
                      setState(() {
                        _selectColor = val!;
                      });
                      onThemeChange(_selectColor, themeProvider);
                    },
                    items: _colors,
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    itemBuilder: (item) => RadioButtonBuilder(item)),
              ],
            ),
          ),
          actions: [
            MaterialButton(
              child: Text(
                "Close",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      }),
    );
  }
}

class MobileScreen extends StatelessWidget {
  const MobileScreen({
    super.key,
    required this.btnTheme,
    required this.txtAboutUs,
    required this.spaceHorizontal,
    required this.txtEmail,
    required this.txtPassword,
    required this.btnEmail,
    required this.btnGoogle,
    required this.btnFacebook,
    required this.btnGithub,
    required this.txtRegister,
  });

  final InkWell btnTheme;
  final Padding txtAboutUs;
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
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(top: 50, left: 20, child: btnTheme),
        Positioned(top: 30, right: 20, child: txtAboutUs),
        Column(
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
        ),
      ],
    );
  }
}

class TabletDesktopScreen extends StatelessWidget {
  const TabletDesktopScreen({
    super.key,
    required this.btnTheme,
    required this.txtAboutUs,
    required this.spaceHorizontal,
    required this.txtEmail,
    required this.txtPassword,
    required this.btnEmail,
    required this.btnGoogle,
    required this.btnFacebook,
    required this.btnGithub,
    required this.txtRegister,
  });

  final InkWell btnTheme;
  final Padding txtAboutUs;
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
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(top: 50, left: 15, child: btnTheme),
        Positioned(bottom: 30, left: 15, child: txtAboutUs),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [LogoImage(), txtRegister],
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
                  width: 400,
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
                ),
              ],
            ))
          ],
        )
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
        SizedBox(height: 20.0)
      ],
    );
  }
}
