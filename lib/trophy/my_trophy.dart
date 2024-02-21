import 'package:flutter/material.dart';
import 'package:gdsc/commmon/component/layout/default_layout.dart';
import 'package:gdsc/commmon/const/colors.dart';
import 'package:gdsc/trophy/trophy_card.dart';

import '../controller/auth_controller.dart';

class MyTrophy extends StatelessWidget {
  const MyTrophy({Key ? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      DefaultLayout(
        backgroundColor: BG_COLOR,
          title: "나의 기록",
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: ListView(
                children: [
                  SingleSection(
                    title: "전체 통계",
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: BG_COLOR))
                        ),
                        child: Text('2024년 02월 14일부터',
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                          fontSize: 16,),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: BG_COLOR))
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text('20,000',
                                style: TextStyle(
                                  color: BODY_TEXT_COLOR,
                                  fontSize: 35,),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 10, 3, 3),
                              child: Text('걸음',
                                style: TextStyle(
                                  color: BODY_TEXT_COLOR,
                                  fontSize: 16,),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: BG_COLOR))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('총 소모시간:',
                            style: TextStyle(
                              color: BODY_TEXT_COLOR,
                              fontSize: 20
                            ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('120',
                                      style: TextStyle(
                                          color: BODY_TEXT_COLOR,
                                          fontSize: 20
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('분',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: BODY_TEXT_COLOR
                                      ),),
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: BG_COLOR))
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('총 뛴 거리:',
                              style: TextStyle(
                                color: BODY_TEXT_COLOR,
                                fontSize: 20
                              )),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('120',
                                      style: TextStyle(
                                          color: BODY_TEXT_COLOR,
                                          fontSize: 20
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('KM',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: BODY_TEXT_COLOR
                                      ),),
                                  )
                                ],
                              )
                            ],
                          )

                      )
                    ],
                  ),
                  SingleSection(
                      title: '주간 통계',
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: BG_COLOR))
                        ),
                        child: Text('2024년 02월 14일부터',
                          style: TextStyle(
                            color: BODY_TEXT_COLOR,
                            fontSize: 16,),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: BG_COLOR))
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text('20,000',
                                style: TextStyle(
                                  color: BODY_TEXT_COLOR,
                                  fontSize: 35,),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 10, 3, 3),
                              child: Text('걸음',
                                style: TextStyle(
                                  color: BODY_TEXT_COLOR,
                                  fontSize: 16,),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: BG_COLOR))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('총 소모시간:',
                              style: TextStyle(
                                  color: BODY_TEXT_COLOR,
                                  fontSize: 20
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('120',
                                      style: TextStyle(
                                          color: BODY_TEXT_COLOR,
                                          fontSize: 20
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('분',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: BODY_TEXT_COLOR
                                      ),),
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: BG_COLOR))
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('총 뛴 거리:',
                                  style: TextStyle(
                                      color: BODY_TEXT_COLOR,
                                      fontSize: 20
                                  )),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('120',
                                      style: TextStyle(
                                          color: BODY_TEXT_COLOR,
                                          fontSize: 20
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('KM',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: BODY_TEXT_COLOR
                                      ),),
                                  )
                                ],
                              )
                            ],
                          )

                      )
                    ],
                  ),
                  SingleSection(
                    title: "월간 통계",
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: BG_COLOR))
                        ),
                        child: Text('2024년 02월 14일부터',
                          style: TextStyle(
                            color: BODY_TEXT_COLOR,
                            fontSize: 16,),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: BG_COLOR))
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text('20,000',
                                style: TextStyle(
                                  color: BODY_TEXT_COLOR,
                                  fontSize: 35,),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 10, 3, 3),
                              child: Text('걸음',
                                style: TextStyle(
                                  color: BODY_TEXT_COLOR,
                                  fontSize: 16,),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: BG_COLOR))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('총 소모시간:',
                              style: TextStyle(
                                  color: BODY_TEXT_COLOR,
                                  fontSize: 20
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('120',
                                      style: TextStyle(
                                          color: BODY_TEXT_COLOR,
                                          fontSize: 20
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('분',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: BODY_TEXT_COLOR
                                      ),),
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: BG_COLOR))
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('총 뛴 거리:',
                                  style: TextStyle(
                                      color: BODY_TEXT_COLOR,
                                      fontSize: 20
                                  )),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('120',
                                      style: TextStyle(
                                          color: BODY_TEXT_COLOR,
                                          fontSize: 20
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('KM',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: BODY_TEXT_COLOR
                                      ),),
                                  )
                                ],
                              )
                            ],
                          )

                      ),
                      IconButton(
                        onPressed: (){
                          AuthController.instance.logout();
                        },
                        icon: Icon(Icons.login_outlined),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
      );
  }
}



