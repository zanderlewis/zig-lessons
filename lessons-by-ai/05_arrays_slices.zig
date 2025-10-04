// Lesson 5: Arrays and Slices
// Fixed-size arrays and dynamic slices

const std = @import("std");

pub fn main() void {

    // ===== ARRAYS =====
    // Arrays have fixed size known at compile time
    const fixed_array = [5]i32{ 1, 2, 3, 4, 5 };

    // Array with inferred size
    const inferred = [_]i32{ 10, 20, 30 };

    // Array filled with same value
    const zeros = [_]i32{0} ** 10; // 10 zeros

    std.debug.print("Fixed array length: {d}\n", .{fixed_array.len});
    std.debug.print("Zeros array length: {d}\n", .{zeros.len});
    std.debug.print("First element: {d}\n", .{fixed_array[0]});
    std.debug.print("Inferred array: ", .{});
    for (inferred) |val| {
        std.debug.print("{d} ", .{val});
    }
    std.debug.print("\n\n", .{});

    // ===== SLICES =====
    // Slices are pointers to arrays with a length
    const slice: []const i32 = &fixed_array;
    std.debug.print("Slice length: {d}\n", .{slice.len});

    // Slicing an array (subarray)
    const sub_slice = fixed_array[1..4]; // Elements 1, 2, 3
    std.debug.print("Sub-slice [1..4]: ", .{});
    for (sub_slice) |val| {
        std.debug.print("{d} ", .{val});
    }
    std.debug.print("\n\n", .{});

    // ===== MUTABLE ARRAYS =====
    var mutable = [_]i32{ 100, 200, 300 };
    mutable[1] = 250;
    std.debug.print("Modified array: ", .{});
    for (mutable) |val| {
        std.debug.print("{d} ", .{val});
    }
    std.debug.print("\n\n", .{});

    // ===== STRINGS (arrays of u8) =====
    const message: []const u8 = "Zig is awesome!";
    std.debug.print("String: {s}\n", .{message});
    std.debug.print("String length: {d} bytes\n", .{message.len});

    // Multi-line strings
    const multi_line =
        \\This is a multi-line string.
        \\Each line starts with \\
        \\No need for quotes on each line!
    ;
    std.debug.print("\n{s}\n", .{multi_line});
}
