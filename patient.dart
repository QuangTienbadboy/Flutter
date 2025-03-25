class Patient {
  String name;
  int age;
  String disease;

  // Constructor
  Patient(this.name, this.age, this.disease);
}

void main() {
  // khởi tạo đối tượng
  Patient patient = Patient('John Doe', 45, 'Flu');

  // hiển thị đối tượng
  print('Name: ${patient.name}');
  print('Age: ${patient.age}');
  print('Disease: ${patient.disease}');
}
