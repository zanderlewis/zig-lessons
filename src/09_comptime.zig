// Lesson 9: Compile-Time Programming
// One of Zig's most powerful features - code that runs at compile time

const std = @import("std");

// Compile-time function - generates code at compile time
fn generateArray(comptime size: usize) [size]i32 {
    var array: [size]i32 = undefined;
    for (&array, 0..) |*elem, i| {
        elem.* = @as(i32, @intCast(i * i));
    }
    return array;
}

// Compile-time type generation
fn Vector(comptime T: type, comptime size: usize) type {
    return struct {
        data: [size]T,

        pub fn init(value: T) @This() {
            return .{ .data = [_]T{value} ** size };
        }

        pub fn sum(self: @This()) T {
            var total: T = 0;
            for (self.data) |item| {
                total += item;
            }
            return total;
        }
    };
}

// Generic function using comptime
fn printType(comptime T: type) void {
    std.debug.print("Type info: {s}\n", .{@typeName(T)});
    std.debug.print("Size: {d} bytes\n", .{@sizeOf(T)});
    std.debug.print("Alignment: {d} bytes\n", .{@alignOf(T)});
}

// Compile-time string manipulation
fn toUpper(comptime str: []const u8) [str.len]u8 {
    var result: [str.len]u8 = undefined;
    for (str, 0..) |c, i| {
        result[i] = if (c >= 'a' and c <= 'z') c - 32 else c;
    }
    return result;
}

pub fn main() void {
    // ===== COMPILE-TIME ARRAYS =====
    std.debug.print("=== Compile-Time Arrays ===\n", .{});

    // This array is generated at compile time!
    const squares = generateArray(10);
    std.debug.print("Squares: ", .{});
    for (squares) |sq| {
        std.debug.print("{d} ", .{sq});
    }
    std.debug.print("\n\n", .{});

    // ===== GENERIC TYPES =====
    std.debug.print("=== Generic Vector Types ===\n", .{});

    const Vec3f = Vector(f32, 3);
    const Vec4i = Vector(i32, 4);

    const v1 = Vec3f.init(2.5);
    const v2 = Vec4i.init(10);

    std.debug.print("Vec3f sum: {d}\n", .{v1.sum()});
    std.debug.print("Vec4i sum: {d}\n", .{v2.sum()});
    std.debug.print("\n", .{});

    // ===== TYPE INSPECTION =====
    std.debug.print("=== Type Information ===\n", .{});
    printType(i32);
    std.debug.print("\n", .{});
    printType(f64);
    std.debug.print("\n", .{});
    printType([10]u8);
    std.debug.print("\n", .{});

    // ===== COMPILE-TIME STRING PROCESSING =====
    std.debug.print("=== Compile-Time Strings ===\n", .{});

    const greeting = "hello, zig!";
    const upper = toUpper(greeting);

    std.debug.print("Original: {s}\n", .{greeting});
    std.debug.print("Upper: {s}\n", .{upper});
    std.debug.print("\n", .{});

    // ===== COMPILE-TIME BLOCKS =====
    const computed_value = comptime blk: {
        var sum: i32 = 0;
        var i: i32 = 1;
        while (i <= 100) : (i += 1) {
            sum += i;
        }
        break :blk sum;
    };

    std.debug.print("Sum of 1..100 (computed at compile time): {d}\n", .{computed_value});

    // This proves it's compile-time: try removing 'comptime' and see the error!
    std.debug.print("\nAll these computations happened at compile time!\n", .{});
    std.debug.print("The binary already contains the results - no runtime overhead!\n", .{});
}
