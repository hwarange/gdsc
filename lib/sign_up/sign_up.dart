import 'package:flutter/material.dart';
import 'package:gdsc/commmon/component/layout/default_layout.dart';
import '../../commmon/component/custom_text_form_field.dart';
import '../../commmon/const/colors.dart';
import '../../controller/auth_controller.dart';

class Sign_Up extends StatelessWidget {


  const Sign_Up({

    Key ? key

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var ageController = TextEditingController();
    var nicknameController = TextEditingController();

    return DefaultLayout(
      backgroundColor: Color(0xff81C784),
        title: "회원가입",
       child: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(16.0),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(
                height: 90,
              ),
              CustomTextFormField(
                controller: nameController,

                hintText: '이름을 입력해주세요.',
              ),
              const SizedBox(height: 16.0,),
              CustomTextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: '이메일을 입력해주세요.',
              ),
              const SizedBox(height: 16.0,),

              CustomTextFormField(
                controller: passwordController,
                hintText: '비밀번호를 입력해주세요.',
                obscureText: true,
              ),
              const SizedBox(height: 16.0,),
              CustomTextFormField(
                controller: ageController,
                hintText: '나이를 입력해주세요.',
              ),
              const SizedBox(height: 16.0,),
              CustomTextFormField(
                controller: nicknameController,
                hintText: '별명을 입력해주세요.',
              ),
              const SizedBox(height: 16.0,),
              GestureDetector(
                onTap: () {
                  AuthController.instance.register(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      nameController.text.trim(),
                      nicknameController.text.trim(),
                      int.parse(ageController.text.trim())
                    //register랑 순서일치 주의.
                  );
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Card(
                    color: BG_COLOR,
                    //margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2,
                    child: const Center(
                      child: Text(
                        '회원 가입',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),


            ],
                 ),
         ),
       ),
    );
  }
}
