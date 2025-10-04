// Lesson 10: Compile-Time Pi
// Compute Pi at compile time using the Chudnovsky algorithm

const std = @import("std");
const math = std.math;

// Chudnovsky algorithm constants
const C: f64 = 426880.0 * @sqrt(10005.0);
const DIGITS: usize = 15; // Number of decimal digits (f64 precision limit)
const ITERATIONS: usize = 3; // Iterations for convergence

// Factorial function
fn factorial(n: usize) f64 {
    if (n == 0 or n == 1) return 1.0;
    var result: f64 = 1.0;
    for (1..(n + 1)) |i| {
        result *= @floatFromInt(i);
    }
    return result;
}

// Compute Pi using the Chudnovsky algorithm
fn computePi() f64 {
    var sum: f64 = 0.0;
    for (0..ITERATIONS) |k| {
        const k_f64 = @as(f64, @floatFromInt(k));
        const numerator = factorial(6 * k) * (13591409.0 + 545140134.0 * k_f64);
        const denominator = factorial(3 * k) * math.pow(f64, factorial(k), 3.0) * math.pow(f64, -640320.0, 3.0 * k_f64);
        const term = numerator / denominator;
        sum += term;
    }
    return C / sum;
}

pub fn main() void {
    // Compute pi at compile time
    const pi = comptime computePi();

    std.debug.print("=== Compile-Time Pi Computation ===\n", .{});
    std.debug.print("Using the Chudnovsky algorithm\n", .{});
    std.debug.print("Iterations: {d}\n\n", .{ITERATIONS});

    std.debug.print("Computed Pi: {d:.15}\n", .{pi});
    std.debug.print("Math.pi:     {d:.15}\n", .{math.pi});
    std.debug.print("Difference:  {e}\n\n", .{@abs(pi - math.pi)});

    // Show that we can use it in compile-time calculations
    const circle_area = comptime blk: {
        const radius = 5.0;
        break :blk pi * radius * radius;
    };

    std.debug.print("Compile-time calculation:\n", .{});
    std.debug.print("Area of circle with radius 5: {d:.14}\n", .{circle_area});

    // Demonstrate compile-time string generation with pi
    const pi_message = comptime std.fmt.comptimePrint("Pi is approximately {d:.5}", .{pi});
    std.debug.print("\nCompile-time string: {s}\n", .{pi_message});
}
