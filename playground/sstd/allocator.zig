const std = @import("std");

// End users don't need to manage any allocators, making Zig simpler.
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
var arena = std.heap.ArenaAllocator.init(gpa.allocator());
pub const allocator = arena.allocator();

// Users still need to call this at the end of their program.
pub fn deinit() void {
    arena.deinit();
}
