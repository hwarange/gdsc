import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdsc/commmon/const/colors.dart'; // Cloud Firestore 패키지 import

enum IconState {
  start,
  pause,
}

class RunningBox extends StatefulWidget {
  final String detinationName;

  const RunningBox({
    Key ?key,
    required this.detinationName
  }) : super (key: key);
  @override
  _RunningBoxState createState() => _RunningBoxState();
}

class _RunningBoxState extends State<RunningBox> {
  Timer ? _timer;
  double _remainingDistance = 10.0; // 초기 거리 설정
  IconState _iconState = IconState.start;
  bool _isRunning = false;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User? user = FirebaseAuth.instance.currentUser;

  void _startRunning() {
    if (!_isRunning) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_remainingDistance > 0) {
          setState(() {
            _remainingDistance -= 0.1; // 0.1씩 감소
          });
        } else {
          _timer!.cancel();
        }
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  void _pauseRunning() {
    if (_isRunning) {
      _timer!.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // 타이머 취소
    super.dispose(); // 부모 클래스의 dispose 메서드 호출
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 300,
      decoration: BoxDecoration(
        color: BG_COLOR, // 예시로 색상 지정
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('destinations').snapshots(), // 파이어스토어에서 데이터 가져오기
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(); // 데이터가 없을 경우 로딩 표시
              }
              // 데이터 가져오기

              // 여기서 destinationData를 이용하여 목적지 정보를 가져와 사용할 수 있습니다.
              // 예를 들어, destinationData['latitude']와 destinationData['longitude']를 사용하여 목적지 좌표를 가져올 수 있습니다.

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 목적지 정보를 표시하는 부분 (예시로만 작성)
                  FutureBuilder(
                    future: users.doc(user!.uid).get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      var userData = snapshot.data;
                      var userNickname = userData!['nickname'] ?? 'User'; // 유저의 닉네임 가져오기
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          userNickname,
                          style: TextStyle(
                              color: W_BOX_COLOR,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(color: W_BOX_COLOR, width: 3),
                            right: BorderSide(color: W_BOX_COLOR ,width: 3)
                        )
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "${widget.detinationName}",
                      style: TextStyle(
                          color: W_BOX_COLOR,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ), // 목적지 이름 표시
                  ElevatedButton(
                    onPressed: () {
                      if (_iconState == IconState.start) {
                        _startRunning();
                        setState(() {
                          _iconState = IconState.pause;
                        });
                      } else {
                        _pauseRunning();
                        setState(() {
                          _iconState = IconState.start;
                        });
                      }
                    },
                    child: _iconState == IconState.start ? Icon(Icons.play_arrow) : Icon(Icons.pause),
                  ),
                ],
              );
            },
          ),
          LinearProgressIndicator(
            value: _remainingDistance / 10.0, // 전체 거리 예시로 10.0으로 설정
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }
}
