// Lesson 3: Control Flow
// if, while, for, and switch statements

const std = @import("std");

pub fn main() void {
    // ===== IF STATEMENTS =====
    const temperature = 25;

    if (temperature > 30) {
        std.debug.print("It's hot outside!\n", .{});
    } else if (temperature > 20) {
        std.debug.print("Nice weather!\n", .{});
    } else {
        std.debug.print("It's cold!\n", .{});
    }

    // If as an expression (returns a value)
    const weather = if (temperature > 25) "hot" else "comfortable";
    std.debug.print("Weather is: {s}\n\n", .{weather});

    // ===== WHILE LOOPS =====
    std.debug.print("While loop: ", .{});
    var i: u32 = 0;
    while (i < 5) : (i += 1) {
        std.debug.print("{d} ", .{i});
    }
    std.debug.print("\n\n", .{});

    // ===== FOR LOOPS =====
    std.debug.print("For loop over array: ", .{});
    const numbers = [_]i32{ 10, 20, 30, 40, 50 };
    for (numbers) |num| {
        std.debug.print("{d} ", .{num});
    }
    std.debug.print("\n", .{});

    // For loop with index
    std.debug.print("For loop with index: ", .{});
    for (numbers, 0..) |num, idx| {
        std.debug.print("[{d}]={d} ", .{ idx, num });
    }
    std.debug.print("\n\n", .{});

    // ===== SWITCH STATEMENTS =====
    const day = 3;
    const day_name = switch (day) {
        1 => "Monday",
        2 => "Tuesday",
        3 => "Wednesday",
        4 => "Thursday",
        5 => "Friday",
        6, 7 => "Weekend", // Multiple cases
        else => "Invalid day",
    };
    std.debug.print("Day {d} is: {s}\n", .{ day, day_name });
}
