List<int> winingNumbers = [12, 6, 34, 22, 41, 9];

List<String> fruits = [
  'Mango',
  'Apple',
  'Banana',
  'Avocado',
  'WaterMelon',
  'Papaya',
  'Guava'
];
void main() {
  //pieMaker();
  List<int> ticket1 = [45, 2, 9, 18, 12, 33];
  List<int> ticket2 = [41, 17, 26, 32, 7, 35];
  checkNumbers(ticket2);
}

void checkNumbers(List<int> tickets) {
  int matchedNumbers = 0;
  for (var ticket in tickets) {
    for (var number in winingNumbers) {
      if (ticket == number) {
        matchedNumbers++;
      }
    }
  }
  print('You have $matchedNumbers matches');
}

void pieMaker() {
  fruits.forEach((value) {
    print('${value}pie');
  });
}

void printLyrics() {
  int startingNumber = 99;
  int remainingNumber;
  for (int i = startingNumber; i >= 0; i--) {
    if (i == 0) {
      startingNumber = 99;
      String endLyrics =
          'No more bottles of beer on the wall, no more bottles of beer.' +
              'Go to the store and buy some more, $startingNumber bottles of beer on the wall.';

      print(endLyrics);
    } else {
      remainingNumber = i - 1;
      String lyrics;
      if (i == 1) {
        lyrics = '$i bottle of beer on the wall, $i bottle of beer.' +
            'Take one down and pass it around, no more bottles of beer on the wall.';
      } else {
        lyrics = '$i bottles of beer on the wall, $i bottles of beer.' +
            'Take one down and pass it around, $remainingNumber bottles of beer on the wall.';
      }
      print(lyrics);
    }
  }
}
//Assignment TaskCallback
