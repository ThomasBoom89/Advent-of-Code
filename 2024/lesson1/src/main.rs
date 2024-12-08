use std::collections::HashMap;
use std::fs;

fn main() {
    a();
    b();
}

fn b() {
    let contents = fs::read_to_string("input").expect("Should have been able to read the file");

    let mut left: Vec<i64> = Vec::new();
    let mut right: Vec<i64> = Vec::new();
    for line in contents.lines() {
        let split: Vec<&str> = line.split("   ").collect();
        left.push(split[0].parse::<i64>().unwrap());
        right.push(split[1].parse::<i64>().unwrap());
    }

    left.sort();
    right.sort();

    let mut mäppie_die_karte: HashMap<i64, i64> = HashMap::new();
    for value in &right {
        if mäppie_die_karte.contains_key(value) {
            mäppie_die_karte.insert(*value, mäppie_die_karte.get(value).unwrap() + 1);
        } else {
            mäppie_die_karte.insert(*value, 1);
        }
    }

    let mut sum: i64 = 0;
    for index in 0..left.len() {
        sum += left[index] * mäppie_die_karte.get(&left[index]).unwrap_or(&0);
    }

    println!("{:?}", sum);
}

fn a() {
    let contents = fs::read_to_string("input").expect("Should have been able to read the file");

    let mut left: Vec<i64> = Vec::new();
    let mut right: Vec<i64> = Vec::new();
    for line in contents.lines() {
        let split: Vec<&str> = line.split("   ").collect();
        left.push(split[0].parse::<i64>().unwrap());
        right.push(split[1].parse::<i64>().unwrap());
    }

    left.sort();
    right.sort();
    let mut sum: i64 = 0;
    for index in 0..left.len() {
        sum = sum + (left[index] - right[index]).abs();
    }

    println!("{:?}", sum);
}
