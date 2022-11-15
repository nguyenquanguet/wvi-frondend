import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnmo_mis/widgets/custom_text.dart';

import '../../constants/style.dart';
import '../../controllers/authentication_controller.dart';

class AuthenticationPage extends StatelessWidget {
  AuthenticationPage({Key? key}) : super(key: key);

  final AuthenticationController authController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => authController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Image.asset("assets/icons/logo.png",
                                height: 50, width: 150),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text("Login",
                              style: GoogleFonts.roboto(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: "World Vision VNMO MIS.",
                            color: lightGrey,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: authController.usernameTxt,
                        decoration: InputDecoration(
                            labelText: "Username",
                            hintText: "abc",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: authController.passwordTxt,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "123",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(value: true, onChanged: (value) {}),
                              const CustomText(text: "Remember Me"),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          authController.getLoginAdmin();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: active,
                              borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const CustomText(
                            text: "Login",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
