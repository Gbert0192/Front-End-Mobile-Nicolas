import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class ParkingLotProvider with ChangeNotifier {
  final Random _random = Random();

  List<ParkingLot> lots = [];
  List<UserSearchHistory> searches = [];

  ParkingLotProvider() {
    lots = [
      ParkingLot(
        id: 1,
        name: "Medan Mall",
        address: "Jl. M. T. Haryono No.8, Kota Medan",
        openTime: "09:00",
        closeTime: "20:00",
        hourlyPrice: 5000,
        starterPrice: 3000,
        image: "assets/images/building/Medan Mall.png",
        spotCount: 0,
        floor: 4,
        spots: [
          Floor(
            number: 'G',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A01",
                  "A02",
                  "A03",
                  "A04",
                  "A05",
                  "A06",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B01",
                  "B02",
                  "B03",
                  "B04",
                  "B05",
                  "B06",
                ]),
              ),
            ],
          ),
          Floor(
            number: '1',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A07",
                  "A08",
                  "A09",
                  "A10",
                  "A11",
                  "A12",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B07",
                  "B08",
                  "B09",
                  "B10",
                  "B11",
                  "B12",
                ]),
              ),
            ],
          ),
          Floor(
            number: '2',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A13",
                  "A14",
                  "A15",
                  "A16",
                  "A17",
                  "A18",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B13",
                  "B14",
                  "B15",
                  "B16",
                  "B17",
                  "B18",
                ]),
              ),
            ],
          ),
          Floor(
            number: '3',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A19",
                  "A20",
                  "A21",
                  "A22",
                  "A23",
                  "A24",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B19",
                  "B20",
                  "B21",
                  "B22",
                  "B23",
                  "B24",
                ]),
              ),
            ],
          ),
        ],
      ),
      ParkingLot(
        id: 2,
        name: "Aryaduta",
        address: " Jl. Kapten Maulana Lubis No.8, Kota Medan",
        openTime: "06:00",
        closeTime: "22:30",
        hourlyPrice: 7000,
        starterPrice: 4000,
        image: "assets/images/building/Aryaduta.png",
        spotCount: 0,
        floor: 2,
        spots: [
          Floor(
            number: '1',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A01",
                  "A02",
                  "A03",
                  "A04",
                  "A05",
                  "A06",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B01",
                  "B02",
                  "B03",
                  "B04",
                  "B05",
                  "B06",
                ]),
              ),
            ],
          ),
          Floor(
            number: '2',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A07",
                  "A08",
                  "A09",
                  "A10",
                  "A11",
                  "A12",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B07",
                  "B08",
                  "B09",
                  "B10",
                  "B11",
                  "B12",
                ]),
              ),
            ],
          ),
        ],
      ),
      ParkingLot(
        id: 3,
        name: "Centre Point",
        address: "Jl. Centre Point No.15, Kota Medan",
        openTime: "07:00",
        closeTime: "23:00",
        hourlyPrice: 6000,
        starterPrice: 3500,
        image: "assets/images/building/Centre Point.png",
        spotCount: 0,
        floor: 6,
        spots: List.generate(
          6,
          (floorIndex) => Floor(
            number: floorIndex == 0 ? 'G' : floorIndex.toString(),
            areas: [
              Area(
                name: "A",
                spots: List.generate(
                  6,
                  (i) => Spot(
                    code: "A${floorIndex}${i + 1}",
                    status: _randomSpotStatus(),
                  ),
                ),
              ),
              Area(
                name: "B",
                spots: List.generate(
                  6,
                  (i) => Spot(
                    code: "B${floorIndex}${i + 1}",
                    status: _randomSpotStatus(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ParkingLot(
        id: 4,
        name: "Lippo Plaza",
        address: "Jl. Veteran No.20, Kota Medan",
        openTime: "08:00",
        closeTime: "22:00",
        hourlyPrice: 5500,
        starterPrice: 3500,
        image: "assets/images/building/Lippo Plaza.png",
        spotCount: 0,
        floor: 3,
        spots: [
          Floor(
            number: 'G',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A01",
                  "A02",
                  "A03",
                  "A04",
                  "A05",
                  "A06",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B01",
                  "B02",
                  "B03",
                  "B04",
                  "B05",
                  "B06",
                ]),
              ),
            ],
          ),
          Floor(
            number: '1',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A07",
                  "A08",
                  "A09",
                  "A10",
                  "A11",
                  "A12",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B07",
                  "B08",
                  "B09",
                  "B10",
                  "B11",
                  "B12",
                ]),
              ),
            ],
          ),
          Floor(
            number: '2',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A13",
                  "A14",
                  "A15",
                  "A16",
                  "A17",
                  "A18",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B13",
                  "B14",
                  "B15",
                  "B16",
                  "B17",
                  "B18",
                ]),
              ),
            ],
          ),
        ],
      ),
      ParkingLot(
        id: 4,
        name: "Lippo Plaza",
        address: "Jl. Brigjen Katamso No. 123, Kota Medan",
        openTime: "08:00",
        closeTime: "21:00",
        hourlyPrice: 5500,
        starterPrice: 3500,
        image: "assets/images/building/Lippo Plaza.png",
        spotCount: 0,
        floor: 3,
        spots: [
          Floor(
            number: 'G',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A01",
                  "A02",
                  "A03",
                  "A04",
                  "A05",
                  "A06",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B01",
                  "B02",
                  "B03",
                  "B04",
                  "B05",
                  "B06",
                ]),
              ),
            ],
          ),
          Floor(
            number: '1',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A07",
                  "A08",
                  "A09",
                  "A10",
                  "A11",
                  "A12",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B07",
                  "B08",
                  "B09",
                  "B10",
                  "B11",
                  "B12",
                ]),
              ),
            ],
          ),
          Floor(
            number: '2',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A13",
                  "A14",
                  "A15",
                  "A16",
                  "A17",
                  "A18",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B13",
                  "B14",
                  "B15",
                  "B16",
                  "B17",
                  "B18",
                ]),
              ),
            ],
          ),
        ],
      ),
      ParkingLot(
        id: 5,
        name: "Grand City Hall",
        address: "Jl. Asia No. 77, Kota Medan",
        openTime: "07:00",
        closeTime: "22:00",
        hourlyPrice: 6000,
        starterPrice: 4000,
        image: "assets/images/building/Grand City Hall.png",
        spotCount: 0,
        floor: 3,
        spots: [
          Floor(
            number: 'G',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A01",
                  "A02",
                  "A03",
                  "A04",
                  "A05",
                  "A06",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B01",
                  "B02",
                  "B03",
                  "B04",
                  "B05",
                  "B06",
                ]),
              ),
            ],
          ),
          Floor(
            number: '1',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A07",
                  "A08",
                  "A09",
                  "A10",
                  "A11",
                  "A12",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B07",
                  "B08",
                  "B09",
                  "B10",
                  "B11",
                  "B12",
                ]),
              ),
            ],
          ),
          Floor(
            number: '2',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A13",
                  "A14",
                  "A15",
                  "A16",
                  "A17",
                  "A18",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B13",
                  "B14",
                  "B15",
                  "B16",
                  "B17",
                  "B18",
                ]),
              ),
            ],
          ),
        ],
      ),
      ParkingLot(
        id: 6,
        name: "Sun Plaza",
        address: "Jl. Gatot Subroto No. 15, Kota Medan",
        openTime: "08:00",
        closeTime: "22:30",
        hourlyPrice: 5800,
        starterPrice: 3700,
        image: "assets/images/building/Sun Plaza.png",
        spotCount: 0,
        floor: 2,
        spots: [
          Floor(
            number: 'G',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A01",
                  "A02",
                  "A03",
                  "A04",
                  "A05",
                  "A06",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B01",
                  "B02",
                  "B03",
                  "B04",
                  "B05",
                  "B06",
                ]),
              ),
            ],
          ),
          Floor(
            number: '1',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A07",
                  "A08",
                  "A09",
                  "A10",
                  "A11",
                  "A12",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B07",
                  "B08",
                  "B09",
                  "B10",
                  "B11",
                  "B12",
                ]),
              ),
            ],
          ),
        ],
      ),
      ParkingLot(
        id: 7,
        name: "Radisson",
        address: "Jl. S. Parman No. 45, Kota Medan",
        openTime: "07:00",
        closeTime: "23:00",
        hourlyPrice: 6500,
        starterPrice: 4000,
        image: "assets/images/building/Radisson.png",
        spotCount: 0,
        floor: 3,
        spots: [
          Floor(
            number: 'G',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A01",
                  "A02",
                  "A03",
                  "A04",
                  "A05",
                  "A06",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B01",
                  "B02",
                  "B03",
                  "B04",
                  "B05",
                  "B06",
                ]),
              ),
            ],
          ),
          Floor(
            number: '1',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A07",
                  "A08",
                  "A09",
                  "A10",
                  "A11",
                  "A12",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B07",
                  "B08",
                  "B09",
                  "B10",
                  "B11",
                  "B12",
                ]),
              ),
            ],
          ),
          Floor(
            number: '2',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A13",
                  "A14",
                  "A15",
                  "A16",
                  "A17",
                  "A18",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B13",
                  "B14",
                  "B15",
                  "B16",
                  "B17",
                  "B18",
                ]),
              ),
            ],
          ),
        ],
      ),
      ParkingLot(
        id: 8,
        name: "Manhattan Time Square",
        address: "Jl. Thamrin No. 99, Kota Medan",
        openTime: "09:00",
        closeTime: "22:00",
        hourlyPrice: 6200,
        starterPrice: 3900,
        image: "assets/images/building/Manhattan Time Square.png",
        spotCount: 0,
        floor: 4,
        spots: [
          Floor(
            number: 'G',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A01",
                  "A02",
                  "A03",
                  "A04",
                  "A05",
                  "A06",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B01",
                  "B02",
                  "B03",
                  "B04",
                  "B05",
                  "B06",
                ]),
              ),
            ],
          ),
          Floor(
            number: '1',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A07",
                  "A08",
                  "A09",
                  "A10",
                  "A11",
                  "A12",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B07",
                  "B08",
                  "B09",
                  "B10",
                  "B11",
                  "B12",
                ]),
              ),
            ],
          ),
          Floor(
            number: '2',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A13",
                  "A14",
                  "A15",
                  "A16",
                  "A17",
                  "A18",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B13",
                  "B14",
                  "B15",
                  "B16",
                  "B17",
                  "B18",
                ]),
              ),
            ],
          ),
          Floor(
            number: '3',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A19",
                  "A20",
                  "A21",
                  "A22",
                  "A23",
                  "A24",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B19",
                  "B20",
                  "B21",
                  "B22",
                  "B23",
                  "B24",
                ]),
              ),
            ],
          ),
        ],
      ),
      ParkingLot(
        id: 9,
        name: "Plaza Medan Fair",
        address: "Jl. Gatot Subroto No. 8, Kota Medan",
        openTime: "08:30",
        closeTime: "21:30",
        hourlyPrice: 5600,
        starterPrice: 3600,
        image: "assets/images/building/Plaza Medan Fair.png",
        spotCount: 0,
        floor: 3,
        spots: [
          Floor(
            number: 'G',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A01",
                  "A02",
                  "A03",
                  "A04",
                  "A05",
                  "A06",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B01",
                  "B02",
                  "B03",
                  "B04",
                  "B05",
                  "B06",
                ]),
              ),
            ],
          ),
          Floor(
            number: '1',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A07",
                  "A08",
                  "A09",
                  "A10",
                  "A11",
                  "A12",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B07",
                  "B08",
                  "B09",
                  "B10",
                  "B11",
                  "B12",
                ]),
              ),
            ],
          ),
          Floor(
            number: '2',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A13",
                  "A14",
                  "A15",
                  "A16",
                  "A17",
                  "A18",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B13",
                  "B14",
                  "B15",
                  "B16",
                  "B17",
                  "B18",
                ]),
              ),
            ],
          ),
        ],
      ),
      ParkingLot(
        id: 10,
        name: "Delipark",
        address: "Jl. Stasiun No. 5, Kota Medan",
        openTime: "06:30",
        closeTime: "22:30",
        hourlyPrice: 5400,
        starterPrice: 3500,
        image: "assets/images/building/Delipark.png",
        spotCount: 0,
        floor: 2,
        spots: [
          Floor(
            number: 'G',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A01",
                  "A02",
                  "A03",
                  "A04",
                  "A05",
                  "A06",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B01",
                  "B02",
                  "B03",
                  "B04",
                  "B05",
                  "B06",
                ]),
              ),
            ],
          ),
          Floor(
            number: '1',
            areas: [
              Area(
                name: "A",
                spots: _generateRandomSpots([
                  "A07",
                  "A08",
                  "A09",
                  "A10",
                  "A11",
                  "A12",
                ]),
              ),
              Area(
                name: "B",
                spots: _generateRandomSpots([
                  "B07",
                  "B08",
                  "B09",
                  "B10",
                  "B11",
                  "B12",
                ]),
              ),
            ],
          ),
        ],
      ),
    ];

    for (var lot in lots) {
      lot.spotCount = _countFreeSpots(lot);
    }
  }

  List<Spot> _generateRandomSpots(List<String> codes) {
    SpotStatus randomStat = _randomSpotStatus();
    final now = DateTime.now();
    final r = Random();
    return codes
        .map(
          (code) => Spot(
            code: code,
            status: randomStat,
            date:
                randomStat == SpotStatus.occupied
                    ? DateTime(
                      now.year,
                      now.month,
                      now.day,
                      r.nextInt(24),
                      r.nextInt(60),
                    )
                    : null,
          ),
        )
        .toList();
  }

  SpotStatus _randomSpotStatus() {
    final double rand = _random.nextDouble();

    if (rand < 0.6) {
      return SpotStatus.free;
    } else if (rand < 0.9) {
      return SpotStatus.occupied;
    } else {
      return SpotStatus.booked;
    }
  }

  int _countFreeSpots(ParkingLot lot) {
    int count = 0;
    for (var floor in lot.spots) {
      for (var area in floor.areas) {
        for (var spot in area.spots) {
          if (spot.status == SpotStatus.free) {
            count++;
          }
        }
      }
    }
    return count;
  }

  UserSearchHistory? loadHistory(int user_id) {
    return searches.firstWhereOrNull((item) => item.user_id == user_id);
  }

  List<ParkingLot>? searchLot(int user_id, String key) {
    final filterLots =
        lots
            .where(
              (item) => item.name.toLowerCase().contains(key.toLowerCase()),
            )
            .toList();

    final history = searches.firstWhereOrNull(
      (item) => item.user_id == user_id,
    );

    if (history == null) return null;

    history.searchHistory.remove(key.trim());

    history.searchHistory.insert(0, key.trim());
    notifyListeners();
    return filterLots;
  }

  void deleteLot(int user_id, String key) {
    final history = searches.firstWhereOrNull(
      (item) => item.user_id == user_id,
    );

    if (history == null) return null;

    history.searchHistory.remove(key.trim());
    notifyListeners();
  }
}

class UserSearchHistory {
  final int user_id;
  final List<String> searchHistory;

  UserSearchHistory(this.user_id, this.searchHistory);
}
