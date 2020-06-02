class CountRoom {
  static int count = 0;
  CountRoom countRoomObject;

  void incrementCount() {
    count++;
  }

  void decrementCount() {
    count--;
  }

  int getCount() {
    return count;
  }
}
