// Lesson 7: Memory Management
// Allocators, pointers, and manual memory management

const std = @import("std");

pub fn main() !void {
    // ===== ALLOCATORS =====
    // Zig requires explicit allocators - no hidden memory allocation
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit(); // Clean up at end of scope

    const allocator = gpa.allocator();

    std.debug.print("=== Memory Allocation ===\n", .{});

    // Allocate a single item
    const single = try allocator.create(i32);
    defer allocator.destroy(single); // Don't forget to free!
    single.* = 42;
    std.debug.print("Allocated single value: {d}\n", .{single.*});

    // Allocate an array/slice
    const numbers = try allocator.alloc(i32, 5);
    defer allocator.free(numbers); // Free the slice

    for (numbers, 0..) |*num, i| {
        num.* = @as(i32, @intCast(i * 10));
    }

    std.debug.print("Allocated array: ", .{});
    for (numbers) |num| {
        std.debug.print("{d} ", .{num});
    }
    std.debug.print("\n\n", .{});

    // ===== ARRAYLIST (DYNAMIC ARRAY) =====
    std.debug.print("=== ArrayList ===\n", .{});
    var list: std.ArrayList(i32) = .{ .items = &.{}, .capacity = 0 };
    defer list.deinit(allocator); // ArrayList manages its own memory

    try list.append(allocator, 10);
    try list.append(allocator, 20);
    try list.append(allocator, 30);
    try list.appendSlice(allocator, &[_]i32{ 40, 50 });

    std.debug.print("ArrayList: ", .{});
    for (list.items) |item| {
        std.debug.print("{d} ", .{item});
    }
    std.debug.print("\n", .{});

    const popped = list.pop() orelse 0;
    std.debug.print("Popped: {d}\n", .{popped});
    std.debug.print("After pop: ", .{});
    for (list.items) |item| {
        std.debug.print("{d} ", .{item});
    }
    std.debug.print("\n\n", .{});

    // ===== POINTERS =====
    std.debug.print("=== Pointers ===\n", .{});
    var value: i32 = 100;
    const ptr: *i32 = &value; // Single-item pointer

    std.debug.print("Value: {d}\n", .{value});
    std.debug.print("Pointer value: {d}\n", .{ptr.*});

    ptr.* = 200; // Modify through pointer
    std.debug.print("Modified value: {d}\n", .{value});

    // ===== ARENA ALLOCATOR =====
    std.debug.print("\n=== Arena Allocator ===\n", .{});
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit(); // Frees ALL allocations at once

    const arena_allocator = arena.allocator();

    // Allocate multiple things without worrying about individual frees
    const data1 = try arena_allocator.alloc(i32, 10);
    const data2 = try arena_allocator.alloc(i32, 20);
    const data3 = try arena_allocator.alloc(i32, 30);

    std.debug.print("Arena allocated arrays: {d}, {d}, {d} elements\n", .{
        data1.len,
        data2.len,
        data3.len,
    });
    std.debug.print("All will be freed together when arena.deinit() is called!\n", .{});
}
