const std = @import("std");
const sstd = @import("./sstd.zig");

const println = sstd.println;
const input = sstd.input;

pub fn main() !void {
    defer sstd.deinit();

    const num = sstd.randIntRange(1, 100);
    try println("Guess a number between 1 and 100!", .{});
    var guess: i32 = 0;
    var user_input: sstd.str = "";

    var attempts: i32 = 0;

    while (guess != num) {
        user_input = try input("Your guess: ");
        guess = try sstd.strToInt(user_input);

        if (guess < num) {
            try println("The number '{d}' is too low!", .{guess});
            attempts += 1;
        } else if (guess > num) {
            try println("The number '{d}' is too high!", .{guess});
            attempts += 1;
        } else {
            try println("Correct! '{d}' is the number! You guessed it in {d} attempts.", .{ guess, attempts + 1 });
        }
    }
}
