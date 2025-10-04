// Lesson 6: Structs
// Custom data types and methods

const std = @import("std");

// Define a struct
const Person = struct {
    name: []const u8,
    age: u32,
    email: []const u8,

    // Method (function that takes self)
    pub fn introduce(self: Person) void {
        std.debug.print("Hi! I'm {s}, {d} years old. Email: {s}\n", .{
            self.name,
            self.age,
            self.email,
        });
    }

    // Method that modifies the struct (takes pointer)
    pub fn haveBirthday(self: *Person) void {
        self.age += 1;
        std.debug.print("{s} is now {d} years old!\n", .{ self.name, self.age });
    }

    // Associated function (doesn't take self)
    pub fn create(name: []const u8, age: u32) Person {
        return Person{
            .name = name,
            .age = age,
            .email = "unknown@example.com",
        };
    }
};

// Generic struct
fn Point(comptime T: type) type {
    return struct {
        x: T,
        y: T,

        pub fn distance(self: @This()) f64 {
            // Convert to f64, handling both int and float types
            const x_f: f64 = switch (@typeInfo(T)) {
                .int => @floatFromInt(self.x),
                .float => @floatCast(self.x),
                else => @compileError("Point requires numeric type"),
            };
            const y_f: f64 = switch (@typeInfo(T)) {
                .int => @floatFromInt(self.y),
                .float => @floatCast(self.y),
                else => @compileError("Point requires numeric type"),
            };
            return @sqrt(x_f * x_f + y_f * y_f);
        }
    };
}

pub fn main() void {
    // Create a struct instance
    const person1 = Person{
        .name = "Alice",
        .age = 30,
        .email = "alice@example.com",
    };

    person1.introduce();

    // Create using associated function
    var person2 = Person.create("Bob", 25);
    person2.introduce();

    // Modify through method
    person2.haveBirthday();

    std.debug.print("\n", .{});

    // Generic structs
    const point_i32 = Point(i32){ .x = 3, .y = 4 };
    const point_f32 = Point(f32){ .x = 3.0, .y = 4.0 };

    std.debug.print("Integer point distance: {d:.2}\n", .{point_i32.distance()});
    std.debug.print("Float point distance: {d:.2}\n", .{point_f32.distance()});

    // Anonymous structs
    const config = .{
        .width = 1920,
        .height = 1080,
        .fullscreen = true,
    };
    std.debug.print("\nConfig: {d}x{d}, fullscreen: {}\n", .{
        config.width,
        config.height,
        config.fullscreen,
    });
}
