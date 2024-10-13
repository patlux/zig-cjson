const std = @import("std");

const c = @cImport({
    @cInclude("cJSON.h");
});

pub fn main() !void {
    const value = c.cJSON_Parse(
        "{ \"name\": \"Patrick\" }",
    );
    defer std.c.free(value);
    const name = c.cJSON_GetObjectItemCaseSensitive(
        value,
        "name",
    );
    defer std.c.free(name);
    if (c.cJSON_IsString(name) == 1) {
        const str: [:0]u8 = std.mem.span(name.*.valuestring);
        std.debug.print(
            "value = {s}, len = {d}\n",
            .{
                str,
                str.len,
            },
        );
    }
}
