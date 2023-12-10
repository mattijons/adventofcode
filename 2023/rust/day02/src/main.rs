use std::fs::File;
use std::io::Read;

fn main() {
    let mut file = File::open("./example.txt").unwrap();

    let mut input = String::new();
    file.read_to_string(&mut input).unwrap();

    // println!("{}", part_one(&input));
    part_two(&input);
    // println!("{}", part_two(&input));
}

fn part_one(input: &String) -> u32 {
    input
        .lines()
        .enumerate()
        .map(|(i, line)| {
            let x = line
                .split_once(':')
                .unwrap()
                .1
                .split([';', ','])
                .map(|s| {
                    let t = s.trim().split_once(' ').unwrap();
                    (t.0.parse::<u32>().unwrap(), t.1.chars().nth(0).unwrap())
                })
                .collect::<Vec<(u32, char)>>()
                .iter()
                .any(|(n, c)| match (n, c) {
                    (_, 'r') => *n > 12,
                    (_, 'g') => *n > 13,
                    (_, 'b') => *n > 14,
                    _ => true,
                });
            match x {
                true => 0,
                false => (i + 1) as u32,
            }
        })
        .sum::<u32>()
}

fn part_two(input: &String) -> u32 {
    input
        .lines()
        .take(1)
        .enumerate()
        .map(|(i, line)| {
            let mut rgb: [u32; 3] = [0, 0, 0];
            let x = line
                .split_once(":")
                .unwrap()
                .1
                .split([';', ','])
                .map(|s| {
                    let t = s.trim().split_once(' ').unwrap();
                    rgb[0] += 1;
                    (t.0.parse::<u32>().unwrap(), t.1.chars().nth(0).unwrap());
                    0
                })
                .collect::<Vec<u32>>();
            println!("{}", rgb[0]);

            x.into_iter().sum::<u32>()
        })
        .sum::<u32>();
    0
}
