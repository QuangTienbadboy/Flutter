import 'person.dart';

class Teacher extends Person {
  double basicSalary;
  double subsidy;

  Teacher(super.fullName, super.gender, super.phone, super.email, this.basicSalary, this.subsidy);

  double calculateSalary() {
    return basicSalary + subsidy;
  }
}
