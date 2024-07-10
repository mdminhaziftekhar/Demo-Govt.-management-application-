class DashboardModel {
  DateTime startDate = DateTime(2024, 1, 1);
  DateTime endDate = DateTime(2030, 1, 31);
  DateTime today = DateTime.now();

  final List<String> menuItemNames = [
    'মেনু নং\n০০০০১', 'মেনু নং\n০০০০২', 'মেনু নং\n০০০০৩',
    'মেনু নং\n০০০০৪', 'মেনু নং\n০০০০৫', 'মেনু নং\n০০০০৬',
  ];

  final List<String> menuItemImages = [
    'assets/images/menu1.png', 'assets/images/menu2.png', 'assets/images/menu3.png',
    'assets/images/menu4.png', 'assets/images/menu5.png', 'assets/images/menu6.png',
  ];


  String convertToBangla(String number) {
    Map<String, String> digitsMap = {
      '0': '০',
      '1': '১',
      '2': '২',
      '3': '৩',
      '4': '৪',
      '5': '৫',
      '6': '৬',
      '7': '৭',
      '8': '৮',
      '9': '৯',
    };
    String result = '';
    for (int i = 0; i < number.length; i++) {
      if (digitsMap.containsKey(number[i])) {
        result += digitsMap[number[i]]!;
      } else {
        result += number[i];
      }
    }
    return result;
  }

}