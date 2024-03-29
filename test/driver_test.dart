import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tracker/models/driver.dart';
import 'package:trip_tracker/models/trip.dart';

void main() {
  test('drivers are initialized with a name.', () {
    final driver = Driver('Crash Test Dummy');

    expect(driver.name == 'Crash Test Dummy', true);
  });

  test('drivers are initialized with no trips.', () {
    final driver = Driver('Crash Test Dummy');

    expect(driver.tripCount == 0, true);
  });

  final validTrip1 = Trip(
    driver: 'Crash Test Dummy',
    startTime: DateTime(2017, 9, 7, 7, 15).millisecondsSinceEpoch,
    endTime: DateTime(2017, 9, 7, 7, 45).millisecondsSinceEpoch,
    distance: 17.3,
  );

  final validTrip2 = Trip(
    driver: 'Crash Test Dummy',
    startTime: DateTime(2017, 9, 7, 6, 12).millisecondsSinceEpoch,
    endTime: DateTime(2017, 9, 7, 6, 32).millisecondsSinceEpoch,
    distance: 21.8,
  );

  final invalidTrip1 = Trip(
    driver: 'Crash Test Dummy',
    startTime: DateTime(2017, 9, 7, 1, 12).millisecondsSinceEpoch,
    endTime: DateTime(2017, 9, 7, 12, 32).millisecondsSinceEpoch,
    distance: 21.8,
  );

  final invalidTrip2 = Trip(
    driver: 'Crash Test Dummy',
    startTime: DateTime(2017, 9, 7, 6, 12).millisecondsSinceEpoch,
    endTime: DateTime(2017, 9, 7, 6, 13).millisecondsSinceEpoch,
    distance: 210.8,
  );

  test(
    'drivers can add trips with average speeds between 5 and 100 mph.',
    () {
      final driver = Driver('Crash Test Dummy');

      expect(driver.tripCount == 0, true);

      driver.addTrip(validTrip1);
      expect(driver.tripCount == 1, true);

      driver.addTrip(validTrip2);
      expect(driver.tripCount == 2, true);
    },
  );

  test(
    'drivers cannot add trips with average speeds below 5 mph or above 100 mph',
    () {
      final driver = Driver('Crash Test Dummy');

      expect(driver.tripCount == 0, true);

      driver.addTrip(invalidTrip1);
      expect(driver.tripCount == 0, true);

      driver.addTrip(invalidTrip2);
      expect(driver.tripCount == 0, true);
    },
  );

  test('total distance driven increments when a new trip is added.', () {
    final driver = Driver('Crash Test Dummy');

    expect(driver.distanceTraveled == 0, true);

    driver.addTrip(validTrip1);
    expect(driver.distanceTraveled == 17, true);

    driver.addTrip(validTrip2);
    expect(driver.distanceTraveled == 39, true);
  });

  test('total time driven increments when a new trip is added.', () {
    final driver = Driver('Crash Test Dummy');

    expect(driver.driveTime == 0, true);

    driver.addTrip(validTrip1);
    expect(driver.driveTime / Duration.millisecondsPerMinute == 30, true);

    driver.addTrip(validTrip2);
    expect(driver.driveTime / Duration.millisecondsPerMinute == 50, true);
  });

  test('able to correctly state distance driven and average speed.', () {
    final driver = Driver('Crash Test Dummy');

    expect(driver.tripStatement == 'Crash Test Dummy: 0', true);
    driver.addTrip(validTrip1);
    driver.addTrip(validTrip2);
    expect(driver.tripStatement == 'Crash Test Dummy: 39 miles @ 47 mph', true);
  });
}
