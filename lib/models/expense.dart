class NewExpense {
  String amount;
  String category;
  String type;
  String period;
  String details;
  String day;
  String date;
  String month;
  String year;
  String time;

  NewExpense({
    required this.amount,
    required this.category,
    this.type = 'out',
    required this.period,
    required this.details,
    required this.day,
    required this.date,
    required this.month,
    required this.year,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'type': type,
      'period': period,
      'details': details,
      'day': day,
      'date': date,
      'month': month,
      'year': year,
      'time': time,
    };
  }

  factory NewExpense.fromMap(Map<String, dynamic> map) {
    return NewExpense(
      amount: map['amount'],
      category: map['category'],
      type: map['type'],
      period: map['period'],
      details: map['details'],
      day: map['day'],
      date: map['date'],
      month: map['month'],
      year: map['year'],
      time: map['time'],
    );
  }
}
