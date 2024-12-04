use std::fs::File;
use std::io::Read;

fn main() {
    let mut file = File::open("./input.txt").unwrap();

    let mut input = String::new();
    file.read_to_string(&mut input).unwrap();

    println!("Part one: {}", part_one(&input));
    println!("Part two: {}", part_two(&input));
}

fn part_one(input: &String) -> i32 {
    let mut left: Vec<i32> = vec![];
    let mut right: Vec<i32> = vec![];

    input.lines().for_each(|line| {
        let digits = line.split_once("   ").unwrap();
        left.push(digits.0.parse::<i32>().unwrap());
        right.push(digits.1.parse::<i32>().unwrap());
    });

    left.sort();
    right.sort();

    left.iter()
        .zip(right.iter())
        .map(|(&a, &b)| (a - b).abs())
        .sum()
}

fn part_two(input: &String) -> i32 {
    let mut left: Vec<i32> = vec![];
    let mut right: Vec<i32> = vec![];

    input.lines().for_each(|line| {
        let splits = line.split_once("   ").unwrap();
        left.push(splits.0.parse::<i32>().unwrap());
        right.push(splits.1.parse::<i32>().unwrap());
    });

    left.iter()
        .map(|&l| l * right.iter().filter(|&r| *r == l).count() as i32)
        .sum()
}
