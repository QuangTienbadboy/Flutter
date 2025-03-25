import 'dart:io';
import 'course.dart';

bool validateCourseCode(String courseCode) {
  // Biểu thức chính quy kiểm tra mã khóa học phải có dạng FW + 3 chữ số
  RegExp regExp = RegExp(r'^FW\d{3}$');
  return regExp.hasMatch(courseCode);
}

void outputInfo({required Course course}) {
  print('Course Code: ${course.code}');
  print('Course Name: ${course.name}');
  print("Course Duration: ${course.duration}");
  print("Course Status: ${course.status}");
  print("Course Flag: ${course.flag}");
}

void inputInfo({required Course course, required List<Course> courses}) {
  bool isValidCode = false;

  while (!isValidCode) {
    try {
      print('Enter course code (Format: FW + 3 digits, Not duplicated):');
      String code = stdin.readLineSync()!;

      // Kiểm tra tính hợp lệ của mã khóa học
      if (!validateCourseCode(code)) {
        print('Error: Invalid course code. It should follow the format FW + 3 digits.');
      } else if (courses.any((c) => c.code == code)) {
        print('Error: This course code is already in use. Please enter a unique code.');
      } else {
        course.code = code;
        isValidCode = true;
      }
    } catch (e) {
      print('Error: Please enter a valid course code.');
    }
  }

  print('Enter course name:');
  course.name = stdin.readLineSync()!;

  try {
    print('Enter course duration:');
    course.duration = double.parse(stdin.readLineSync()!);

    // Chọn trạng thái qua radio button

    bool isValidStatus = false;
    while (!isValidStatus) {
      print('Choose course status:');
      print('1. Active');
      print('2. In-active');
      String? choice = stdin.readLineSync();
      switch (choice) {
        case '1':
          course.status = 'active';
          isValidStatus = true;
          break;
        case '2':
          course.status = 'in-active';
          isValidStatus = true;
          break;
        default:
          print('Invalid choice. Please choose either 1 or 2.');

      }
    }

    bool isValidFlag = false;
    while (!isValidFlag) {
      print('Choose course flag:');
      print('1. Optional');
      print('2. Mandatory');
      print('3. N/A');

      String? flagChoice = stdin.readLineSync();
      switch (flagChoice) {
        case '1':
          course.flag = 'optional';
          isValidFlag = true;
          break;
        case '2':
          course.flag = 'mandatory';
          isValidFlag = true;
          break;
        case '3':
          course.flag = 'N/A';
          isValidFlag = true;
          break;
        default:
          print('Invalid choice. Please choose either 1, 2, or 3.');
      }
    }
  } catch (e) {
    print('Error: Please enter a valid number for course duration.');
  }
   /*   print('Choose course status:');
      print('1. optional');
      print('2. mandatory');
      print('3. N/A');
      String? choice = stdin.readLineSync();
      switch (choice) {
        case '1':
          course.flag = 'optional';
          isValidStatus = true;
          break;
        case '2':
          course.flag = 'mandatory';
          isValidStatus = true;
          break;
        case '3':
          course.flag = 'N/A';
          isValidFlag = true;
          default:
          print('Invalid choice. Please choose either 1 or 2 or 3.');
    */
    /*  print('Enter course flag (optional/mandatory/N/A):');
      course.flag = stdin.readLineSync()!;
      if (course.flag == 'optional' || course.flag == 'mandatory' || course.flag == 'N/A') {
        isValidFlag = true;
      } else {
        print('Invalid flag. Please enter either "optional", "mandatory", or "N/A".');
      }
    }
  } catch (e) {
    print('Error: Please enter a valid number for course duration.');

      }*/
}

void main() {
  List<Course> courses = [];
  int choice;

  do {
    print('1. Add Course');
    print('2. Display Courses');
    print('3. Search by Course Name');
    print('4. Search by Course Code');
    print('0. Exit');

    print("Your choice: ");
    choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        var course = Course(
          code: '', // Giá trị khởi tạo ban đầu
          name: '',
          duration: 0.0,
          status: '',
          flag: '',
        );
        inputInfo(course: course, courses: courses);
        courses.add(course);
        break;
      case 2:
        for (var course in courses) {
          outputInfo(course: course);
        }
        break;
      case 3:
        print('Enter course name to search:');
        String searchName = stdin.readLineSync()!;
        var filteredCourses = courses.where((c) => c.name == searchName);
        if (filteredCourses.isEmpty) {
          print('No course found with the name $searchName');
        } else {
          for (var course in filteredCourses) {
            outputInfo(course: course);
          }
        }
        break;
      case 4:
        print('Enter course code to search:');
        String searchCode = stdin.readLineSync()!;
        var course = courses.firstWhere(
              (c) => c.code == searchCode,
          orElse: () => Course(
            code: 'N/A', // Khởi tạo giá trị mặc định
            name: 'Unknown',
            duration: 0.0,
            status: 'inactive',
            flag: 'N/A',
          ),
        );
        outputInfo(course: course);
        break;
      case 0:
        print('Exiting...');
        break;
      default:
        print('Invalid choice, please try again.');
    }
  } while (choice != 0);
}
