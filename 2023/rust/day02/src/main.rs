use std::fs::File;
use std::io::Read;

fn main() {
    let mut file = File::open("./example.txt").unwrap();

    let mut input = String::new();
    file.read_to_string(&mut input).unwrap();

    println!("{}", part_one(&input));
    println!("{}", part_two(&input));
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
        .map(|line| {
            let mut rgb: [u32; 3] = [1, 1, 1];
            line.split_once(":")
                .unwrap()
                .1
                .split([';', ','])
                .for_each(|s| {
                    let t = s.trim().split_once(' ').unwrap();
                    let (v, c) = (t.0.parse::<u32>().unwrap(), t.1.chars().nth(0).unwrap());

                    match (v, c) {
                        (v, 'r') => {
                            if v > rgb[0] {
                                rgb[0] = v
                            }
                        }
                        (v, 'g') => {
                            if v > rgb[1] {
                                rgb[1] = v
                            }
                        }
                        (v, 'b') => {
                            if v > rgb[2] {
                                rgb[2] = v
                            }
                        }
                        _ => (),
                    };
                });
            rgb.iter().product::<u32>()
        })
        .sum::<u32>()
}
