class NewTransaction {
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
  String deletedTime;

  NewTransaction({
    required this.category,
    required this.details,
    required this.amount,
    required this.type,
    required this.period,
    this.date = "0",
    this.day = "0",
    this.month = "0",
    this.year = "0",
    this.time = '0',
    this.deletedTime = '0',
  });

  // Convert NewTransaction to a Map
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

  // Create a NewTransaction instance from a Map
  factory NewTransaction.fromMap(Map<String, dynamic> map) {
    return NewTransaction(
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
