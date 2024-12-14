import 'dart:io';

Future<void> main(List<String> arguments) async {
  File file = File('./input');
  File output = File('./output');
  await output.writeAsString("");

  Map<String, bool> brain = {};
  List<List<String>> field = [];
  await file
      .readAsLines()
      .then((lines) => lines.forEach((l) => field.add(l.split(''))));

  print(field);
  int x = 0;
  int y = 0;
  for (int iter = 0; iter < field.length; iter++) {
    for (int jiter = 0; jiter < field.length; jiter++) {
      if (field[iter][jiter] == "^") {
        x = jiter;
        y = iter;
      }
    }
  }

  Direction currentDirection = Direction.up;
  print('$x, $y');
  brain["$y-$x"] = true;
  field[y][x] = "X";
  while (!outOfBound(x, y, currentDirection, field.length)) {
    print(currentDirection);
    print(y.toString() + x.toString());
    switch (currentDirection) {
      case Direction.up:
        if (field[y - 1][x] == "#") {
          currentDirection = Direction.right;
        } else {
          y = y - 1;
          brain["$y-$x"] = true;
        }

      case Direction.right:
        if (field[y][x + 1] == "#") {
          currentDirection = Direction.down;
        } else {
          x = x + 1;
          brain["$y-$x"] = true;
        }

      case Direction.down:
        if (field[y + 1][x] == "#") {
          currentDirection = Direction.left;
        } else {
          y = y + 1;
          brain["$y-$x"] = true;
        }

      case Direction.left:
        if (field[y][x - 1] == "#") {
          currentDirection = Direction.up;
        } else {
          x = x - 1;
          brain["$y-$x"] = true;
        }
    }
    field[y][x] = "X";
  }

  for (var value in field) {
    print(value);
    output.writeAsStringSync("${value.join('')}\n", mode: FileMode.append);
  }
  print(brain.length);
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
