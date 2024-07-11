import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DataEntity {
  @Id(assignable: false)
  int? id;
  String date;
  String name;
  String category;
  String location;
  String parsedDate;
  String parsedTime;
  String timeOfDay;

  DataEntity({
    this.id,
    required this.date,
    required this.name,
    required this.category,
    required this.location,
    this.parsedDate = '',
    this.parsedTime = '',
    this.timeOfDay = '',
  }):super();

  DataEntity.fromMap(Map<String, dynamic> map)
      :this (
    date: map['date'] ?? '',
    name: map['name'] ?? '',
    category: map['category'] ?? '',
    location: map['location'] ?? '',
    parsedDate: _parseDate(map['date'] ?? ''),
    parsedTime: _parseTime(map['date'] ?? ''),
    timeOfDay: _getTimeOfDay(_parseTime(map['date'] ?? '')),
  );

  static String _getTimeOfDay(String time) {
    try {
      DateTime dateTime = DateFormat('HH:mm').parse(time);
      int hour = dateTime.hour;

      if (hour >= 5 && hour < 12) {
        return 'সকাল';
      } else if (hour == 12) {
        return 'দুপুর';
      } else if (hour > 12 && hour < 17) {
        return 'বিকাল';
      } else if (hour >= 17 && hour < 21) {
        return 'সন্ধ্যা';
      } else {
        return 'রাত';
      }
    } catch (e) {
      return '';
    }
  }

  static String _parseDate(String timestamp) {
    try {
      int timestampInt = int.parse(timestamp);
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampInt * 1000);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static String _parseTime(String timestamp) {
    try {
      int timestampInt = int.parse(timestamp);
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampInt * 1000);
      return DateFormat('HH:mm').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  @override
  Map<String, dynamic> toJson() => {

  };

}