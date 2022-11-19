class Profile {
  final String gender;
  final DateTime birth;
  final double height;
  final String heightUnit;
  final double weight;
  final String weightUnit;
  final String name;

  Profile(this.gender, this.birth, this.height, this.heightUnit, this.weight,
      this.weightUnit, this.name);

  int getAge() {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birth.year;
    int month1 = currentDate.month;
    int month2 = birth.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birth.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
