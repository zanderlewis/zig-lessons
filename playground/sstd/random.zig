const std = @import("std");

// -- Random state (initialized once) --
var rng_state: ?std.Random.DefaultPrng = null;

fn getRng() std.Random {
    if (rng_state == null) {
        var seed: u64 = undefined;
        std.crypto.random.bytes(std.mem.asBytes(&seed));
        rng_state = std.Random.DefaultPrng.init(seed);
    }
    return rng_state.?.random();
}

pub fn randIntRange(min: i32, max: i32) i32 {
    return getRng().intRangeAtMost(i32, min, max);
}

pub fn randFloatRange(min: f64, max: f64) f64 {
    return getRng().float(f64) * (max - min) + min;
}

pub fn randInt() i32 {
    return getRng().intRangeAtMost(i32, 0, 100);
}

pub fn randFloat() f64 {
    return getRng().float(f64); // This is a float between 0.0 and 1.0
}
