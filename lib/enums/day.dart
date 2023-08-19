enum Day {
  monday('Monday', 'monday'),
  tuesday('Tuesday', 'tuesday'),
  wednesday('Wednesday', 'wednesday'),
  thursday('Thursday', 'thursday'),
  friday('Friday', 'friday'),
  saturday('Saturday', 'saturday'),
  sunday('Sunday', 'sunday');

  const Day(this.title, this.json);
  final String title;
  final String json;
}

class DayFun {
  static Day fromMap(String expression) {
    switch (expression) {
      case 'monday':
        return Day.monday;
      case 'tuesday':
        return Day.tuesday;
      case 'wednesday':
        return Day.wednesday;
      case 'thursday':
        return Day.thursday;
      case 'friday':
        return Day.friday;
      case 'saturday':
        return Day.saturday;
      case 'sunday':
        return Day.sunday;
      default:
        return Day.sunday;
    }
  }
}
