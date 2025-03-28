import 'student.dart';
import 'teacher.dart';
import 'person.dart';
import 'dart:io';

bool _isValidPhone(String phone) {
  // Kiểm tra số điện thoại chỉ chứa 10 chữ số
  return RegExp(r'^\d{10}$').hasMatch(phone);
}

bool _isValidEmail(String email) {
  // Kiểm tra email phải chứa ký tự '@'
  return email.contains('@');
}

bool _isValidFWId(String id) {
  // Kiểm tra ID FW phải bắt đầu bằng chữ cái và kết thúc bằng 3 chữ số
  return RegExp(r'^[A-Za-z]\d{3}$').hasMatch(id);
}

void _inputData(List<Person> people) {
  stdout.write("Enter 1 for Student or 2 for Teacher: ");
  String? type = stdin.readLineSync();

  if (type == null || (type != '1' && type != '2')) {
    print("Invalid type! Please enter 1 for Student or 2 for Teacher.");
    return;
  }

  stdout.write("Full name: ");
  String? fullName = stdin.readLineSync();
  stdout.write("Gender: ");
  String? gender = stdin.readLineSync();

  String? phone;
  do {
    stdout.write("Phone (10 digits): ");
    phone = stdin.readLineSync();
    if (phone == null || !_isValidPhone(phone)) {
      print("Invalid phone number. Please enter a valid 10-digit number.");
    }
  } while (phone == null || !_isValidPhone(phone));

  String? email;
  do {
    stdout.write("Email: ");
    email = stdin.readLineSync();
    if (email == null || !_isValidEmail(email)) {
      print("Invalid email. Please enter a valid email with '@'.");
    }
  } while (email == null || !_isValidEmail(email));

  if (fullName == null || gender == null || phone == null || email == null) {
    print("Please fill in all the required fields.");
    return;
  }

  if (type == '1') {
    stdout.write("Student ID (FW format - one letter and 3 digits): ");
    String? studentId = stdin.readLineSync();
    while (studentId == null || !_isValidFWId(studentId)) {
      print("Invalid Student ID. Must start with one letter and end with 3 digits.");
      stdout.write("Student ID: ");
      studentId = stdin.readLineSync();
    }

    stdout.write("Theory mark: ");
    double? theory = double.tryParse(stdin.readLineSync() ?? '');
    stdout.write("Practice mark: ");
    double? practice = double.tryParse(stdin.readLineSync() ?? '');

    if (theory == null || practice == null) {
      print("Invalid input for student details. Please try again.");
      return;
    }

    people.add(Student(fullName, gender, phone, email, studentId, theory, practice));
    print("Student added successfully!");
  } else if (type == '2') {
    stdout.write("Basic salary: ");
    double? basicSalary = double.tryParse(stdin.readLineSync() ?? '');
    stdout.write("Subsidy: ");
    double? subsidy = double.tryParse(stdin.readLineSync() ?? '');

    if (basicSalary == null || subsidy == null) {
      print("Invalid input for teacher details. Please try again.");
      return;
    }

    people.add(Teacher(fullName, gender, phone, email, basicSalary, subsidy));
    print("Teacher added successfully!");
  }
}

void _updateStudentInfo(List<Person> people) {
  stdout.write("Enter Student ID to update: ");
  String? studentId = stdin.readLineSync();

  if (studentId == null) {
    print("Student ID is required.");
    return;
  }

  Person? person = people.firstWhere(
        (p) => p is Student && (p as Student).studentId == studentId,
    orElse: () => null as Student,
  );

  if (person == null) {
    print("Student not found!");
    return;
  }

  // Nếu đối tượng tìm được là Student, tiếp tục thực hiện cập nhật.
  if (person is Student) {
    stdout.write("Update theory mark: ");
    double? theory = double.tryParse(stdin.readLineSync() ?? '');
    stdout.write("Update practice mark: ");
    double? practice = double.tryParse(stdin.readLineSync() ?? '');

    if (theory != null && practice != null) {
      person.theory = theory;
      person.practice = practice;
      print("Student updated successfully!");
    } else {
      print("Invalid input for marks.");
    }
  }
}

void _displayTeachersWithHighSalary(List<Person> people) {
  print("\n--- Teachers with salary higher than 1000 ---");
  for (var person in people) {
    if (person is Teacher) {
      double salary = person.calculateSalary();
      if (salary > 1000) {
        print("Name: ${person.fullName}, Salary: $salary");
      }
    }
  }
}

void _reportPassedStudents(List<Person> people) {
  print("\n--- Students passed the course (final mark >= 6) ---");
  for (var person in people) {
    if (person is Student) {
      double finalMark = person.calculateFinalMark();
      if (finalMark >= 6) {
        print("Student ID: ${person.studentId}, Final Mark: $finalMark");
      }
    }
  }
}

void main() {
  List<Person> people = [];

  while (true) {
    print("\n--- Menu ---");
    print("1. Input data");
    print("2. Update student info");
    print("3. Display teacher salary > 1000");
    print("4. Report students passed (final mark >= 6)");
    print("5. Quit");
    stdout.write("Select an option: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        _inputData(people);
        break;
      case '2':
        _updateStudentInfo(people);
        break;
      case '3':
        _displayTeachersWithHighSalary(people);
        break;
      case '4':
        _reportPassedStudents(people);
        break;
      case '5':
        exit(0);
      default:
        print("Invalid option!");
    }
  }
}
