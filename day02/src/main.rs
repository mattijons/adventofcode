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
    let mut num_safe = 0;

    input.lines().for_each(|line| {
        let numbers = line
            .split_whitespace()
            .map(|n| n.parse::<i32>().unwrap())
            .collect::<Vec<i32>>();

        if check_safety(&numbers).is_ok() {
            num_safe += 1;
        };
    });

    num_safe
}

fn part_two(input: &String) -> i32 {
    let mut num_safe = 0;

    input.lines().for_each(|line| {
        let numbers = line
            .split_whitespace()
            .map(|n| n.parse::<i32>().unwrap())
            .collect::<Vec<i32>>();

        match check_safety(&numbers) {
            Ok(()) => num_safe += 1,
            Err(()) => {
                for (j, _) in numbers.iter().enumerate() {
                    let filtered = numbers
                        .iter()
                        .enumerate()
                        .filter_map(|(i, &v)| if i != j { Some(v) } else { None })
                        .collect::<Vec<i32>>();

                    if check_safety(&filtered).is_ok() {
                        num_safe += 1;
                        break;
                    }
                }
            }
        }
    });

    num_safe
}

fn check_safety(numbers: &[i32]) -> Result<(), ()> {
    let signum = (numbers[0] - numbers[1]).signum();
    numbers.windows(2).try_for_each(|n| {
        let diff = n[0] - n[1];
        if diff.signum() != signum {
            Err(())
        } else if diff.abs().lt(&1) {
            Err(())
        } else if diff.abs().gt(&3) {
            Err(())
        } else {
            Ok(())
        }
    })
}
