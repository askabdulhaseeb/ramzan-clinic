enum Gender {
  male('Male', 'male'),
  female('Female', 'female'),
  other('other', 'other');

  const Gender(this.title, this.json);
  final String title;
  final String json;
}

class GenderFun {
  static Gender fromMap(String expression) {
    switch (expression) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      case 'other':
        return Gender.other;
      default:
        return Gender.other;
    }
  }
}
