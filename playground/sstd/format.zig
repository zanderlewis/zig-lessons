const std = @import("std");

pub const str = []const u8;

// -- Formatting functions --
pub fn strToInt(s: str) !i32 {
    return std.fmt.parseInt(i32, s, 10);
}
