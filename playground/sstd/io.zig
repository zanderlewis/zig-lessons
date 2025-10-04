const std = @import("std");
const allocator_module = @import("allocator.zig");
const allocator = allocator_module.allocator;

pub const str = []const u8;

// -- Printing functions --
pub fn print(comptime fmt: []const u8, args: anytype) !void {
    const formatted = try std.fmt.allocPrint(allocator, fmt, args);
    defer allocator.free(formatted);
    try std.fs.File.stdout().writeAll(formatted);
}

pub fn println(comptime fmt: []const u8, args: anytype) !void {
    try print(fmt ++ "\n", args);
}

// -- Input functions --
pub fn input(comptime prompt: str) !str {
    try std.fs.File.stdout().writeAll(prompt);
    const stdin = std.fs.File.stdin();

    // Create a buffer for reading
    var buffer: [1024]u8 = undefined;

    // Read directly from stdin
    var index: usize = 0;
    while (index < buffer.len) {
        var byte: [1]u8 = undefined;
        const bytes_read = try stdin.read(&byte);
        if (bytes_read == 0) break; // EOF
        if (byte[0] == '\n') break; // Newline
        if (byte[0] == '\r') continue; // Skip carriage return
        buffer[index] = byte[0];
        index += 1;
    }

    return try allocator.dupe(u8, buffer[0..index]);
}
