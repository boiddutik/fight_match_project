// Convert height to feet and inches
String convertCmToFeetAndInche(int value) {
  double inches = value / 2.54;
  int feet = (inches ~/ 12);
  double remainingInches = inches % 12;
  remainingInches = remainingInches.roundToDouble();
  if (remainingInches == 12) {
    feet += 1;
    remainingInches = 0;
  }
  return '$feet\' ${remainingInches.toInt()}"';
}

int poundsToKg(int pounds) {
  double kg = pounds * 0.453592;
  return kg.round();
}
