import 'package:flutter/material.dart';

// 공통된 Text 위젯을 위한 커스텀 위젯 생성
class CustomText extends StatelessWidget {
  final String id;
  final double? size; // int?를 double?로 변경

  const CustomText({
    Key? key,
    required this.id,
    this.size,
    required FontWeight fontWeight,
    //required Color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      id,
      style: Theme.of(context).textTheme.titleSmall?.copyWith( // 굵게
        color: Colors.black,
        fontSize: size, // fontSize에 size 전달
      ),
    );
  }
}
