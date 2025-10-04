// Lesson 8: Enums and Unions
// Enumerations and tagged unions for type-safe variants

const std = @import("std");

// Simple enum
const Color = enum {
    red,
    green,
    blue,
    yellow,

    pub fn toString(self: Color) []const u8 {
        return switch (self) {
            .red => "Red",
            .green => "Green",
            .blue => "Blue",
            .yellow => "Yellow",
        };
    }
};

// Enum with values
const HttpStatus = enum(u16) {
    ok = 200,
    created = 201,
    bad_request = 400,
    not_found = 404,
    server_error = 500,
};

// Tagged union (union with an enum tag)
const Result = union(enum) {
    success: i32,
    error_msg: []const u8,
    empty: void,

    pub fn isSuccess(self: Result) bool {
        return switch (self) {
            .success => true,
            else => false,
        };
    }
};

// More complex tagged union
const Shape = union(enum) {
    circle: struct { radius: f32 },
    rectangle: struct { width: f32, height: f32 },
    triangle: struct { base: f32, height: f32 },

    pub fn area(self: Shape) f32 {
        return switch (self) {
            .circle => |c| std.math.pi * c.radius * c.radius,
            .rectangle => |r| r.width * r.height,
            .triangle => |t| 0.5 * t.base * t.height,
        };
    }
};

pub fn main() void {
    // ===== ENUMS =====
    std.debug.print("=== Enums ===\n", .{});

    const favorite = Color.blue;
    std.debug.print("Favorite color: {s}\n", .{favorite.toString()});

    const status = HttpStatus.ok;
    std.debug.print("HTTP Status: {d}\n", .{@intFromEnum(status)});

    // Switch on enum
    const color = Color.red;
    const rgb = switch (color) {
        .red => "FF0000",
        .green => "00FF00",
        .blue => "0000FF",
        .yellow => "FFFF00",
    };
    std.debug.print("RGB for {s}: #{s}\n\n", .{ color.toString(), rgb });

    // ===== TAGGED UNIONS =====
    std.debug.print("=== Tagged Unions ===\n", .{});

    const success_result = Result{ .success = 42 };
    const error_result = Result{ .error_msg = "Something went wrong!" };
    const empty_result = Result{ .empty = {} };

    printResult(success_result);
    printResult(error_result);
    printResult(empty_result);

    std.debug.print("\n=== Shape Areas ===\n", .{});

    const circle = Shape{ .circle = .{ .radius = 5.0 } };
    const rectangle = Shape{ .rectangle = .{ .width = 4.0, .height = 6.0 } };
    const triangle = Shape{ .triangle = .{ .base = 8.0, .height = 3.0 } };

    std.debug.print("Circle area: {d:.2}\n", .{circle.area()});
    std.debug.print("Rectangle area: {d:.2}\n", .{rectangle.area()});
    std.debug.print("Triangle area: {d:.2}\n", .{triangle.area()});
}

fn printResult(result: Result) void {
    switch (result) {
        .success => |value| {
            std.debug.print("Success! Value: {d}\n", .{value});
        },
        .error_msg => |msg| {
            std.debug.print("Error: {s}\n", .{msg});
        },
        .empty => {
            std.debug.print("Empty result\n", .{});
        },
    }
}
