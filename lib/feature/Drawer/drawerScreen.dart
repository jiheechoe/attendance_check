import 'package:attendance_check/feature/Drawer/widget/IdText.dart';
import 'package:attendance_check/feature/Drawer/widget/button.dart';
import 'package:attendance_check/feature/Drawer/widget/currentBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model/AttendanceViewModel.dart';

class DrawerScreen extends StatefulWidget {
  final String role;
  final String id;

  DrawerScreen({
    required this.role,
    required this.id,
  });

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    AttendanceViewModel viewModel = AttendanceViewModel(); // ViewModel 인스턴스 생성

    return Drawer(
      backgroundColor: Theme.of(context).primaryColorDark,
      child: Stack(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Stack(
                children: [
                  Positioned(
                    top: -1.h, // 반응형 높이 설정
                    left: 99.w,
                    child: CircleAvatar(
                      radius: 0,
                      child: Icon(Icons.account_circle, size: 70.w),
                    ),
                  ),
                  if (widget.role != '관리자' && widget.role != '학부생')
                    Positioned(
                      top: 100.h, // 반응형 높이 설정
                      left: 82.w,
                      child: CustomText(
                        id: '정보없음',
                        size: 30.w, // 역할 표시
                      ),
                    ),
                  if (widget.role == '관리자' || widget.role == '학부생')
                    Positioned(
                      top: 78.h, // 반응형 높이 설정
                      left: 94.w,
                      child: CustomText(
                          id: widget.role,
                          size: 30.w // 역할 표시
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomCenter, // 가로 방향으로 가운데 정렬
                    child: Padding(
                      padding: EdgeInsets.only(top: 123.h), // 세로 위치 조정
                      child: CustomText(
                        id: widget.id,
                        size: 20.sp, // 아이디 표시
                      ),
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          Positioned(
            top: 220.h, // 첫 번째 버튼의 위치를 조정
            left: 0,
            right: 0,
            child: Divider(
              color: Colors.grey,
              thickness: 3,
            ),
          ),
          if (widget.role == '관리자') ...[
            ParticipationButton( //참여 학생
              onPressed: () {
              },role: widget.role,
              id: widget.id,
            ),
            CurrentButton( // 현황
              onPressed: () {
              },role: widget.role,
            id: widget.id,
            ),
            RaffleButton( //추첨
              onPressed: () {},role: widget.role,
              id: widget.id,
            ),
          ] else if (widget.role == '학부생') ...[
            FutureBuilder<int?>(
              future: viewModel.getTotalAttendanceByStudentId(widget.id), // student_id를 통해 데이터 가져옴
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // 로딩 상태 표시
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  int currentProgress = snapshot.data ?? 0; // Firestore에서 가져온 출석 데이터
                  int totalProgress = 9; // 총 출석 가능 횟수

                  return CurrentBar(
                    currentProgress: currentProgress, // Firestore 값 반영
                    totalProgress: totalProgress,
                  );
                } else {
                  return Text('No data available');
                }
              },
            ),
          ] else ...[ // 로그인 전에 로그인 버튼과 회원가입 버튼
            LogInButton(onPressed: () {}),
            JoinButton(onPressed: () {}),
          ],
          if (widget.role == '관리자' || widget.role == '학부생')
            LogOutButton(onPressed: () {}),
          Logo(onPressed: () {}),
        ],
      ),
    );
  }
}