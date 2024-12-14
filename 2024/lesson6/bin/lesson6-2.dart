import 'dart:io';

Future<void> main(List<String> arguments) async {
  File file = File('./input');

  Map<Direction, int> brain = {};
  List<List<String>> field = [];
  await file
      .readAsLines()
      .then((lines) => lines.forEach((l) => field.add(l.split(''))));

  int startX = 0;
  int startY = 0;
  for (int iter = 0; iter < field.length; iter++) {
    for (int jiter = 0; jiter < field.length; jiter++) {
      if (field[iter][jiter] == "^") {
        startX = jiter;
        startY = iter;
      }
    }
  }

  Direction currentDirection = Direction.up;
  int count = 0;
  bool exit = false;
  DateTime startDateTime = DateTime.timestamp();
  for (int iter = 0; iter < field.length; iter++) {
    for (int jiter = 0; jiter < field.length; jiter++) {
      if (field[iter][jiter] == "#" || field[iter][jiter] == "^") {
        continue;
      }
      startDateTime = DateTime.timestamp();
      brain[Direction.up] = 0;
      brain[Direction.right] = 0;
      brain[Direction.down] = 0;
      brain[Direction.left] = 0;
      field[iter][jiter] = "O";
      int x = startX;
      int y = startY;
      currentDirection = Direction.up;
      exit = false;
      while (!outOfBound(x, y, currentDirection, field.length)) {
        switch (currentDirection) {
          case Direction.up:
            if (field[y - 1][x] == "O") {
              brain[currentDirection] = (brain[currentDirection]! + 1);
              currentDirection = Direction.right;
            } else if (field[y - 1][x] == "#") {
              currentDirection = Direction.right;
            } else {
              y = y - 1;
            }

          case Direction.right:
            if (field[y][x + 1] == "O") {
              brain[currentDirection] = (brain[currentDirection]! + 1);
              currentDirection = Direction.down;
            } else if (field[y][x + 1] == "#") {
              currentDirection = Direction.down;
            } else {
              x = x + 1;
            }

          case Direction.down:
            if (field[y + 1][x] == "O") {
              brain[currentDirection] = (brain[currentDirection]! + 1);
              currentDirection = Direction.left;
            } else if (field[y + 1][x] == "#") {
              currentDirection = Direction.left;
            } else {
              y = y + 1;
            }

          case Direction.left:
            if (field[y][x - 1] == "O") {
              brain[currentDirection] = (brain[currentDirection]! + 1);
              currentDirection = Direction.up;
            } else if (field[y][x - 1] == "#") {
              currentDirection = Direction.up;
            } else {
              x = x - 1;
            }
        }
        for (var value in brain.values) {
          if (value >= 2) {
            count = count + 1;
            // print(brain);
            exit = true;
            break;
          }
        }
        if (exit == true) {
          break;
        }
        // this is brilliant
        if (DateTime.timestamp().difference(startDateTime).inMicroseconds > 500) {
          count = count + 1;
          break;
        }
      }
      field[iter][jiter] = ".";
    }
  }

  print(count);
}

bool outOfBound(int x, int y, Direction currentDirection, int length) {
  switch (currentDirection) {
    case Direction.up:
      if ((y - 1) < 0) {
        return true;
      }
      break;

    case Direction.right:
      if ((x + 1) >= length) {
        return true;
      }
      break;

    case Direction.down:
      if ((y + 1) >= length) {
        return true;
      }
      break;

    case Direction.left:
      if ((x - 1) < 0) {
        return true;
      }
      break;
  }

  return false;
}

enum Direction { up, right, down, left }
