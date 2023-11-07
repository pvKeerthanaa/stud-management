class Student {
  String name;
  String branch;
  int rollNo;
  String phoneNumber;
  String fatherName;
  String motherName;

  Student({
    required this.name,
    required this.branch,
    required this.rollNo,
    required this.phoneNumber,
    required this.fatherName,
    required this.motherName,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'branch': branch,
      'rollNo': rollNo,
      'phoneNumber': phoneNumber,
      'fatherName': fatherName,
      'motherName': motherName,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      branch: json['branch'],
      rollNo: json['rollNo'],
      phoneNumber: json['phoneNumber'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
    );
  }
}
