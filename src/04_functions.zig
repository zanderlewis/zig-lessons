// Lesson 4: Functions
// Function definition, parameters, return values, and error handling

const std = @import("std");

// Simple function with no return value
fn greet(name: []const u8) void {
    std.debug.print("Hello, {s}!\n", .{name});
}

// Function with return value
fn add(a: i32, b: i32) i32 {
    return a + b;
}

// Function with multiple return values (using structs)
fn divmod(numerator: i32, denominator: i32) struct { quotient: i32, remainder: i32 } {
    return .{
        .quotient = @divTrunc(numerator, denominator),
        .remainder = @rem(numerator, denominator),
    };
}

// Function that can return an error
fn divide(a: f32, b: f32) !f32 {
    if (b == 0) {
        return error.DivisionByZero;
    }
    return a / b;
}

// Function with generic type (comptime parameter)
fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

pub fn main() void {
    // Call simple function
    greet("Zig Learner");

    // Function with return value
    const sum = add(10, 20);
    std.debug.print("10 + 20 = {d}\n", .{sum});

    // Multiple return values
    const result = divmod(17, 5);
    std.debug.print("17 / 5 = {d} remainder {d}\n", .{ result.quotient, result.remainder });

    // Error handling with try
    const division = divide(10.0, 2.0) catch unreachable;
    std.debug.print("10.0 / 2.0 = {d}\n", .{division});

    // Error handling with catch
    const safe_div = divide(10.0, 0.0) catch |err| blk: {
        std.debug.print("Error occurred: {}\n", .{err});
        break :blk 0.0;
    };
    std.debug.print("Safe division result: {d}\n", .{safe_div});

    // Generic function
    const max_int = max(i32, 42, 100);
    const max_float = max(f64, 3.14, 2.71);
    std.debug.print("Max int: {d}, Max float: {d}\n", .{ max_int, max_float });
}
