#### Usage

On terminal

```
$ zig fetch --save=calc-zig https://github.com/doccaico/calc-zig/archive/<HASH>.tar.gz
```

```zig
// build.zig

const calc_zig_dep = b.dependency("calc-zig", .{ .target = target, .optimize = optimize });
exe.linkLibrary(calc_zig_dep.artifact("calc"));

// main.zig

const std = @import("std");

const c = @cImport({
    @cInclude("calc-c/calc-c.h");
});

pub fn main() void {
    std.debug.print("{d}\n", .{c.add(1, 2)});
    std.debug.print("{d}\n", .{c.sub(10, 3)});
    std.debug.print("{s}\n", .{c.CALC_C_VERSION});
}
```
