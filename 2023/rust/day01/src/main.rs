use std::fs::File;
use std::io::Read;

fn main() {
    let mut file = File::open("./input.txt").unwrap();

    let mut input = String::new();
    file.read_to_string(&mut input).unwrap();

    println!("{}", part_one(&input));
    println!("{}", part_two(&input));
}

fn part_one(input: &String) -> u32 {
    input
        .lines()
        .map(|line| {
            let left = line
                .chars()
                .find(|c| c.is_ascii_digit())
                .unwrap()
                .to_digit(10)
                .unwrap();
            let right = line
                .chars()
                .rfind(|c| c.is_ascii_digit())
                .unwrap()
                .to_digit(10)
                .unwrap();
            left * 10 + right
        })
        .sum::<u32>()
}

const NUMBERS: [&str; 9] = [
    "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
];

fn part_two(input: &String) -> u32 {
    input
        .lines()
        .map(|line| find_left(line) * 10 + find_right(line))
        .sum::<u32>()
}

fn find_left(line: &str) -> u32 {
    for (i, character) in line.chars().enumerate() {
        if character.is_ascii_digit() {
            return character.to_digit(10).unwrap();
        }
        for (j, number) in NUMBERS.iter().enumerate() {
            if line[i..].starts_with(number) {
                return (j + 1) as u32;
            }
        }
    }
    return 0;
}

fn find_right(line: &str) -> u32 {
    for (i, character) in line.chars().rev().enumerate() {
        if character.is_ascii_digit() {
            return character.to_digit(10).unwrap();
        }
        for (j, number) in NUMBERS.iter().enumerate() {
            if line[..line.len() - i].ends_with(number) {
                return (j + 1) as u32;
            }
        }
    }
    return 0;
}
