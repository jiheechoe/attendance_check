import 'package:attendance_check/feature/Home/widget/Button/animation_Button.dart';
import 'package:attendance_check/feature/Home/widget/Button/button.dart';
import 'package:flutter/material.dart';
import 'package:attendance_check/feature/Home/model/homeModel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:attendance_check/feature/Home/view_model/HomeViewModel.dart';
import 'package:attendance_check/feature/Drawer/drawerScreen.dart';
import 'package:attendance_check/feature/Home/widget/card.dart'; // 카드 위젯 임포트

class HomeScreen extends HookWidget {
  final String role;
  final String id;

  HomeScreen({
    required this.role,
    required this.id,
  });

  final qrCodeScanner Scanner = qrCodeScanner(); // QR 코드 스캐너 인스턴스 생성
  ScheduleViewModel scheduleViewModel = ScheduleViewModel(); // ViewModel 선언

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        iconTheme: IconThemeData(color: Colors.black),
        flexibleSpace: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.5,
          ),
          child: Center(
            child: Image.asset(
              'assets/logo.png',
              height: MediaQuery.of(context).size.height * 0.1,
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                color: Colors.black,
              );
            },
          ),
        ],
      ),
      endDrawer: DrawerScreen(
        role: role,
        id: id,
      ),
      drawerScrimColor: Colors.black.withOpacity(0.5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 일정 카드 표시
            buildScheduleCard(context),

            // '학부생' 역할인 경우 QR 코드 스캐너 애니메이션 버튼 추가
            if (role == '학부생')
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: animationButton(
                  icon: Icons.qr_code_scanner, // QR 코드 아이콘 직접 사용
                  iconSize: 40, // 아이콘 크기 설정
                  iconColor: Theme.of(context).colorScheme.scrim, // 아이콘 색상 설정
                  defaultSize: const Offset(80, 80), // 버튼 기본 크기 설정
                  clickedSize: const Offset(70, 70), // 버튼 클릭 시 크기
                  defaultButtonColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), // 버튼 색상
                  clickedButtonColor: Theme.of(context).colorScheme.primary, // 클릭 시 버튼 색상
                  circularRadius: 50,
                  onTap: () {
                    // QR 코드 스캔 시작 (기능 추가 필요)
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildScheduleCard(BuildContext context) {
    return StreamBuilder<List<Schedule>>(
      stream: scheduleViewModel.getScheduleStream(), // Firestore에서 일정 데이터 가져오기
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // 로딩 중일 때
        }
        if (snapshot.hasError) {
          print('오류 세부사항: ${snapshot.error}');
          return Center(child: Text('일정을 불러오는 중 오류가 발생했습니다: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('등록된 일정이 없습니다.'));
        }

        List<Schedule> schedules = snapshot.data!;
        return ScheduleCard(schedules: schedules); // 일정 데이터를 카드로 표시
      },
    );
  }
}