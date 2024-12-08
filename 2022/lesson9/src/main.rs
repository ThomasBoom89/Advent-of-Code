use std::collections::HashMap;
use std::fs;

#[derive(Clone, Copy)]
struct Position {
    x: i64,
    y: i64,
}

fn main() {
    lesson_a();
    lesson_b();
}

fn lesson_b() {
    let separator: &str = "_";
    let snake_element: Position = Position { x: 0, y: 0 };
    let mut snake: [Position; 10] = [snake_element; 10];
    let mut visited_coordinates: HashMap<String, bool> = HashMap::new();
    insert_visited_coordinates(separator, &mut snake[9], &mut visited_coordinates);
    println!("Lesson B");
    let contents = fs::read_to_string("input.txt")
        .expect("Should have been able to read the file");

    for line in contents.lines()
    {
        if line == "" {
            break;
        }
        let line_splitted = line.split_once(" ").expect("could not split line");
        let mut position_offset = Position { x: 0, y: 0 };
        if line_splitted.0 == "R" {
            position_offset.x = 1;
        } else if line_splitted.0 == "L" {
            position_offset.x = -1;
        } else if line_splitted.0 == "D" {
            position_offset.y = -1;
        } else {
            position_offset.y = 1;
        }
        for _ in 1..=line_splitted.1.parse::<i64>().unwrap() {
            snake[0].x += position_offset.x;
            snake[0].y += position_offset.y;
            for i in 1..=9 {
                if is_touching(&snake[i - 1], &snake[i]) {
                    break;
                }
                if snake[i - 1].x > snake[i].x {
                    snake[i].x += 1;
                } else if snake[i - 1].x < snake[i].x {
                    snake[i].x -= 1;
                }
                if snake[i - 1].y > snake[i].y {
                    snake[i].y += 1;
                } else if snake[i - 1].y < snake[i].y {
                    snake[i].y -= 1;
                }
            }


            insert_visited_coordinates(separator, &mut snake[9], &mut visited_coordinates);
        }
    }
    println!("{}", visited_coordinates.len())
}

fn lesson_a() {
    let separator: &str = "_";
    let mut tail: Position = Position { x: 0, y: 0 };
    let mut head: Position = Position { x: 0, y: 0 };
    let mut visited_coordinates: HashMap<String, bool> = HashMap::new();
    insert_visited_coordinates(separator, &mut tail, &mut visited_coordinates);
    println!("Lesson A");
    let contents = fs::read_to_string("input.txt")
        .expect("Should have been able to read the file");

    for line in contents.lines()
    {
        if line == "" {
            break;
        }
        let line_splitted = line.split_once(" ").expect("could not split line");
        if line_splitted.0 == "R" {
            for _ in 1..=line_splitted.1.parse::<i64>().unwrap() {
                head.x += 1;
                if is_touching(&head, &tail) {
                    continue;
                }
                tail.x += 1;
                tail.y = head.y;
                insert_visited_coordinates(separator, &mut tail, &mut visited_coordinates);
            }
        } else if line_splitted.0 == "L" {
            for _ in 1..=line_splitted.1.parse::<i64>().unwrap() {
                head.x -= 1;
                if is_touching(&head, &tail) {
                    continue;
                }
                tail.x -= 1;
                tail.y = head.y;
                insert_visited_coordinates(separator, &mut tail, &mut visited_coordinates);
            }
        } else if line_splitted.0 == "D" {
            for _ in 1..=line_splitted.1.parse::<i64>().unwrap() {
                head.y -= 1;
                if is_touching(&head, &tail) {
                    continue;
                }
                tail.y -= 1;
                tail.x = head.x;
                insert_visited_coordinates(separator, &mut tail, &mut visited_coordinates);
            }
        } else {
            for _ in 1..=line_splitted.1.parse::<i64>().unwrap() {
                head.y += 1;
                if is_touching(&head, &tail) {
                    continue;
                }
                tail.y += 1;
                tail.x = head.x;
                insert_visited_coordinates(separator, &mut tail, &mut visited_coordinates);
            }
        }
    }

    println!("{}", visited_coordinates.len())
}

fn is_touching(head: &Position, tail: &Position) -> bool {
    if (head.x - tail.x).abs() > 1 || (head.y - tail.y).abs() > 1 {
        return false;
    }

    return true;
}

fn insert_visited_coordinates(separator: &str, tail: &mut Position, visited_coordinates: &mut HashMap<String, bool>) {
    let key: String = [tail.x.to_string(), tail.y.to_string()].join(separator);
    visited_coordinates.insert(key, true);
}
