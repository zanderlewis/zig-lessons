// Lesson 2: Variables and Types
// Zig has strong static typing and explicit mutability

const std = @import("std");

pub fn main() void {
    // Immutable variables use 'const'
    const age: i32 = 17;
    const name: []const u8 = "Zander"; // string literal

    // Mutable variables use 'var'
    var score: u32 = 100;
    score += 50; // Can modify mutable variables

    // Type inference - Zig can infer types
    const pi = 3.14159; // inferred as comptime_float
    const is_learning = true; // inferred as bool

    // Different integer types
    const tiny: i8 = 127; // 8-bit signed integer
    const big: u64 = 1_000_000; // 64-bit unsigned integer (underscores for readability)

    std.debug.print("Name: {s}\n", .{name});
    std.debug.print("Age: {d}\n", .{age});
    std.debug.print("Score: {d}\n", .{score});
    std.debug.print("Pi: {d:.5}\n", .{pi});
    std.debug.print("Learning: {}\n", .{is_learning});
    std.debug.print("Tiny: {d}, Big: {d}\n", .{ tiny, big });
}
