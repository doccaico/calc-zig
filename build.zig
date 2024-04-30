const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const calc_c_upstream = b.dependency("calc-c", .{});

    const lib = b.addStaticLibrary(.{
        .name = "calc",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    b.installArtifact(lib);

    lib.addIncludePath(calc_c_upstream.path("include"));
    lib.installHeadersDirectory(calc_c_upstream.path("include/calc-c"), "calc-c", .{
        .include_extensions = &.{".h"},
    });
    lib.addCSourceFiles(.{
        .root = calc_c_upstream.path("src"),
        .files = &.{
            "calc-c.c",
        },
        .flags = &.{},
    });
}
