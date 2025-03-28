import 'person.dart';

class Student extends Person {
  String studentId;
  double theory;
  double practice;

  Student(super.fullName, super.gender, super.phone, super.email, this.studentId, this.theory, this.practice);

  double calculateFinalMark() {
    return (theory + practice) / 2;
  }
}
