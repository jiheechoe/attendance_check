class ParticipationStudent {
  final String dept;
  final String num;
  final String name;
  final String count;
  final String time;


  ParticipationStudent({
    required this.dept,
    required this.num,
    required this.name,
    required this.count,
    required this.time
  });
}

List<ParticipationStudent> p_students = [
  ParticipationStudent(
      dept: '컴퓨터소프트웨어공학과',
      num: '20225528',
      name: '민지희',
      count: '4',
      time: '2024-10-14 05:27:29'),
  ParticipationStudent(
      dept: '의료IT공학과',
      num: '20225524',
      name: '김형은',
      count: '9',
      time: '0000-00-00 00:00:00'),
  ParticipationStudent(
      dept: '소프트웨어공학과',
      num: '20225528',
      name: '민지희',
      count: '6',
      time: '0000-00-00 00:00:00'),
  ParticipationStudent(
      dept: '소프트웨어공학과',
      num: '20225528',
      name: '민지희',
      count: '5',
      time: '0000-00-00 00:00:00')
];