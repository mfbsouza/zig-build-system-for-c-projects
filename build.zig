const std = @import("std");
const zcc = @import("compile_commands");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // --- configure the project executable ---
    const exe = b.addExecutable(.{
        .name = "my_project_name",
        .target = target,
        .optimize = optimize,
    });

    // add linking dependencies
    exe.linkLibCpp();

    // add include paths and source files to the executable
    exe.addIncludePath(b.path("src/mylib/"));
    exe.addCSourceFiles(.{
        .files = &.{
            "src/app/main.cpp",
            "src/mylib/mylib.cpp",
        },
    });

    // project artifact
    b.installArtifact(exe);
    const exe_step = b.step("my_project_name", "Build my_project_name");
    const install_exe = b.addInstallArtifact(exe, .{});
    exe_step.dependOn(&install_exe.step);

    // --- configure the test executable ---
    const tests = b.addExecutable(.{
        .name = "my_project_name_tests",
        .target = target,
        .optimize = optimize,
    });

    // fetch google test source
    const googletest_dep = b.dependency("googletest", .{
        .target = target,
        .optimize = optimize,
    });

    // add linking dependencies
    tests.linkLibCpp();
    tests.linkLibrary(googletest_dep.artifact("gtest"));
    tests.linkLibrary(googletest_dep.artifact("gtest_main"));

    // add include paths and source files to the executable
    tests.addIncludePath(b.path("src/mylib/"));
    tests.addCSourceFiles(.{
        .files = &.{
            "src/mylib/mylib.cpp",
            "tests/mylib_tests.cpp",
        },
    });

    // test artifact
    b.installArtifact(tests);
    const tests_step = b.step("my_project_name_tests", "Build my_project_name");
    const install_tests = b.addInstallArtifact(tests, .{});
    tests_step.dependOn(&install_tests.step);

    // --- step for generating compile commands ---
    var targets = std.ArrayList(*std.Build.Step.Compile).init(b.allocator);
    targets.append(exe) catch @panic("OOM");
    targets.append(tests) catch @panic("OOM");
    zcc.createStep(b, "cdb", targets.toOwnedSlice() catch @panic("OOM"));
}
