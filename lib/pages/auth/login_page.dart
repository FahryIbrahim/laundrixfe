// ignore_for_file: unused_import

import 'dart:collection';

import 'package:d_button/d_button.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../config/app_response.dart';
import '../../config/app_session.dart';
import '../../config/failure.dart';
import '../../config/nav.dart';
import '../../datasources/user_datasource.dart';
import '../../providers/login_provider.dart';
import '../dashboard_page.dart';
import 'register_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  execute() {
    bool validInput = formKey.currentState!.validate();
    if (!validInput) return;

    setLoginStatus(ref, 'Loading');

    UserDatasource.login(
      edtEmail.text,
      edtPassword.text,
    ).then((value) {
      String newStatus = '';

      value.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ServerFailure:
              newStatus = 'Server Error';
              DInfo.toastError(newStatus);
              break;
            case NotFoundFailure:
              newStatus = 'Error Not Found';
              DInfo.toastError(newStatus);
              break;
            case ForbiddenFailure:
              newStatus = 'You don\'t have access';
              DInfo.toastError(newStatus);
              break;
            case BadRequestFailure:
              newStatus = 'Bad request';
              DInfo.toastError(newStatus);
              break;
            case InvalidInputFailure:
              newStatus = 'Invalid Input';
              AppResponse.invalidInput(context, failure.message ?? '{}');
              break;
            case UnauthorisedFailure:
              newStatus = 'Login Failed';
              DInfo.toastError(newStatus);
              break;
            default:
              newStatus = 'Request Error';
              DInfo.toastError(newStatus);
              newStatus = failure.message ?? '-';
              break;
          }
          setLoginStatus(ref, newStatus);
        },
        (result) {
          AppSession.setUser(result['data']);
          AppSession.setBearerToken(result['token']);
          DInfo.toastSuccess('Login Success');
          setLoginStatus(ref, 'Success');
          Nav.replace(context, const DashboardPage());
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -165,
            left: -45,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0x00ff6600).withOpacity(0.75),
              ),
            ),
          ),
          Positioned(
            top: -45,
            left: -165,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0x00ff6600).withOpacity(0.75),
              ),
            ),
          ),
          Positioned(
            bottom: -45,
            right: -165,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0x00d7d7d7).withOpacity(0.75),
              ),
            ),
          ),
          Positioned(
            bottom: -165,
            right: -45,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0x00d7d7d7).withOpacity(0.75),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(50, 16, 50, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Login_image.png',
                    width: 175,
                    height: 175,
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Log in to your Laundrix \nAccount',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.robotoSlab(
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              const AspectRatio(
                                aspectRatio: 1 / 2,
                              ),
                              DView.spaceWidth(10),
                              Container(
                                width: 320,
                                height: 40,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 0,
                                      offset: Offset(0, 0),
                                      spreadRadius: 0,
                                    ),
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 3,
                                      offset: Offset(0, 1),
                                      spreadRadius: 0,
                                    ),
                                    BoxShadow(
                                      color: Color(0x16000000),
                                      blurRadius: 6,
                                      offset: Offset(0, 6),
                                      spreadRadius: 0,
                                    ),
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 8,
                                      offset: Offset(0, 13),
                                      spreadRadius: 0,
                                    ),
                                    BoxShadow(
                                      color: Color(0x02000000),
                                      blurRadius: 9,
                                      offset: Offset(0, 22),
                                      spreadRadius: 0,
                                    ),
                                    BoxShadow(
                                      color: Color(0x00000000),
                                      blurRadius: 10,
                                      offset: Offset(0, 35),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: edtEmail,
                                  decoration: const InputDecoration(
                                    icon: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.email,
                                        color: Colors.red,
                                      ),
                                    ),
                                    hintText: 'Enter your email',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFA1A1A1),
                                      fontFamily: 'Roboto-Slab',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.5, horizontal: 2.0),
                                    border: InputBorder
                                        .none, // Remove the black outline
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        DView.spaceHeight(16),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              const AspectRatio(
                                aspectRatio: 1 / 2,
                              ),
                              DView.spaceWidth(10),
                              Container(
                                width: 320,
                                height: 40,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 0,
                                      offset: Offset(0, 0),
                                      spreadRadius: 0,
                                    ),
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 3,
                                      offset: Offset(0, 1),
                                      spreadRadius: 0,
                                    ),
                                    BoxShadow(
                                      color: Color(0x16000000),
                                      blurRadius: 6,
                                      offset: Offset(0, 6),
                                      spreadRadius: 0,
                                    ),
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 8,
                                      offset: Offset(0, 13),
                                      spreadRadius: 0,
                                    ),
                                    BoxShadow(
                                      color: Color(0x02000000),
                                      blurRadius: 9,
                                      offset: Offset(0, 22),
                                      spreadRadius: 0,
                                    ),
                                    BoxShadow(
                                      color: Color(0x00000000),
                                      blurRadius: 10,
                                      offset: Offset(0, 35),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: edtPassword,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    icon: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.key,
                                        color: Colors.red,
                                      ),
                                    ),
                                    hintText: 'Enter your Password',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFA1A1A1),
                                      fontFamily: 'Roboto-Slab',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.5, horizontal: 2.0),
                                    border: InputBorder
                                        .none, // Remove the black outline
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        DView.spaceHeight(16),
                        Consumer(builder: (_, wiRef, __) {
                          String status = wiRef.watch(loginStatusProvider);
                          if (status == 'Loading') {
                            return DView.loadingCircle();
                          }
                          return Container(
                            width: 320,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6600),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 0,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x16000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 6),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x0C000000),
                                  blurRadius: 8,
                                  offset: Offset(0, 13),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x02000000),
                                  blurRadius: 9,
                                  offset: Offset(0, 22),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x00000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 35),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: TextButton(
                              onPressed: () => execute(),
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto', // Change the font here
                                ),
                              ),
                            ),
                          );
                        }),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Nav.push(context, const RegisterPage());
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: 'Doesn\'t have an account? ',
                                  style: GoogleFonts.robotoSlab(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Register',
                                      style: GoogleFonts.robotoSlab(
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFFF6600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
