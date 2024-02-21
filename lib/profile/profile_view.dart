import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/commmon/component/layout/default_layout.dart';
import 'package:gdsc/commmon/const/colors.dart';
import 'package:gdsc/profile/profile_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/auth_controller.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({Key ? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  XFile? _pickedFile;



  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return DefaultLayout(
      backgroundColor: BG_COLOR,
        child: StreamBuilder<DocumentSnapshot>(
          stream: users.doc(user?.uid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData){
              return CircularProgressIndicator();
            }
            var userData = snapshot.data!.data();
            String userName = (userData as Map<String, dynamic>)['name'] ?? '이름값 없음';
            String userNickName = (userData)['nickname'] ?? '이름값 없음';
            int userAge = (userData)['age'] ?? '이름값 없음';
            return Center(
              child: Column(
                children: [
                  SizedBox(height: 60,),
                  if (_pickedFile == null)
                    InkWell(
                        onTap: (){
                          _showBottomSheet();
                        },
                        customBorder:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: user?.photoURL != null // 유저 포토가 있는경우
                            ? Ink(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      '${user?.photoURL}'
                                  )
                              )
                          ),
                        )
                            : Ink(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'asset/people/profile.png'
                                  )
                              )
                          ),
                        )
                    )
                  else
                    InkWell(
                      onTap: (){
                      },
                      customBorder:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 2, color: Theme.of(context).colorScheme.primary),
                          image: DecorationImage(
                              image: FileImage(File(_pickedFile!.path)),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${userNickName}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  ProfileList(
                      child: createRows2(
                          "이름: ",
                          "${userName}"
                      )
                  ),
                  ProfileList(
                      child: createRows2(
                          "나이: ",
                          "${userAge}"
                      )
                  ),

                  ProfileList(
                      child: createRows2(
                          "이메일: ",
                          "${user?.email}"
                      )
                  ),
                  ProfileList(
                      child: createRows3(
                          "총 뛴 거리:",
                          150,
                          "Km"
                      )
                  ),
                  ProfileList(
                      child: createRows3(
                          '지금까지 모은 포인트: ',
                          50,
                          "point"
                      )
                  ),
                  SizedBox(height: 25,),
                  ElevatedButton(
                      onPressed:(){
                    AuthController.instance.logout();
                  },
                      child: Text('로그아웃',style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: BODY_TEXT_COLOR
                      ),
                      )
                  ),


                ],

              ),
            );
          }

    )
    );
  }

  _showBottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => _getCameraImage(),
              child: const Text('사진찍기'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _getPhotoLibraryImage(),
              child: const Text('라이브러리에서 불러오기'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
  _getCameraImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

  _getPhotoLibraryImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = _pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }


}

class MyClipper extends CustomClipper<Rect> {
  Rect getClip(Size size) {    // 하위 요소의 사이즈를 가져오는 메소드
    return Rect.fromLTWH(0, 0, size.width, size.height);    // 하위 요소의 사이즈에 상관없이 넓이와 높이 사이즈를 200px, 100px로 놓았다.
  }

  bool shouldReclip(oldClipper) {
     return false;
  }
}

Row createRows2 (String title, String units){
  return Row(

    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(6),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: BODY_TEXT_COLOR,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        flex: 3,
      ),

      Expanded(
        child: Container(
          padding: EdgeInsets.all(6),
          width: 200,
          child: Text(
            units,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: BODY_TEXT_COLOR,
                fontWeight: FontWeight.bold,
                fontSize: 15
            ),
          ),
        ),
        flex: 7,
      )
    ],
  );
}



Row createRows3 (String title, int count, String units){
  return Row(

    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(6),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: BODY_TEXT_COLOR,
              fontWeight: FontWeight.bold,
              fontSize: 15,
          ),
          ),
        ),
      ),

      Expanded(
        child: Container(
          padding: EdgeInsets.all(6),
          child: Text(
            "$count"+
            units,
            textAlign: TextAlign.end,
            style: TextStyle(
                color: BODY_TEXT_COLOR,
                fontWeight: FontWeight.bold,
                fontSize: 15
                ),
          ),
        ),
      )
    ],
  );
}

