// Lesson 1: Hello, World!
// This is your first Zig program. It demonstrates:
// - How to import the standard library
// - The main function entry point
// - Basic output to stdout

const std = @import("std");

pub fn main() void {
    // debug.print prints to stderr and is great for learning
    // It doesn't require error handling with 'try'
    std.debug.print("Hello, Zig! Welcome to systems programming.\n", .{});

    // You can format output with different specifiers
    std.debug.print("Zig is fast, safe, and simple!\n", .{});
}
