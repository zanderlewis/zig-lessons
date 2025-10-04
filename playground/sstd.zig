const std = @import("std");

// Module imports
const allocator_module = @import("sstd/allocator.zig");
const random_module = @import("sstd/random.zig");
const io_module = @import("sstd/io.zig");
const format_module = @import("sstd/format.zig");

// Re-export types
pub const str = io_module.str;

// Re-export allocator functions
pub const deinit = allocator_module.deinit;

// Re-export random functions
pub const randIntRange = random_module.randIntRange;
pub const randFloatRange = random_module.randFloatRange;
pub const randInt = random_module.randInt;
pub const randFloat = random_module.randFloat;

// Re-export IO functions
pub const print = io_module.print;
pub const println = io_module.println;
pub const input = io_module.input;

// Re-export format functions
pub const strToInt = format_module.strToInt;
