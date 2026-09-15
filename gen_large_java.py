#!/usr/bin/env python3
"""Generate a large Java source file (~10MB+) filled with valid Java code."""

OUT = "LargeTest.java"
TARGET_BYTES = 10 * 1024 * 1024  # 10 MB

HEADER = """\
/**
 * LargeTest - a generated test file.
 * This file is auto-generated and contains a large number of methods
 * to exercise tooling with big source files.
 */
public class LargeTest {

    public static void main(String[] args) {
        long total = 0;
        for (int i = 0; i < 64; i++) {
            total += compute0(i, i * 2);
        }
        System.out.println("result = " + total);
    }
"""

LOOP_BODY = [
    "            result += i * 3 - 1;",
    "            result ^= i << 2;",
    "            result -= i % 7;",
    "            result = result * 31 + 17;",
    "            result ^= result >>> 5;",
    "            result += a * i - b;",
]


def method_body(idx):
    lines = ["    public static long compute%d(long a, long b) {" % idx,
             "        long result = a + b;"]
    for _ in range(20):
        lines.append("        for (int i = 0; i < 64; i++) {")
        lines.extend(LOOP_BODY)
        lines.append("        }")
    lines.append("        return result;")
    lines.append("    }")
    return "\n".join(lines)


def main():
    parts = [HEADER]
    size = len(HEADER)
    idx = 0
    while size < TARGET_BYTES:
        m = method_body(idx)
        parts.append("\n" + m)
        size += len(m) + 1
        idx += 1
    parts.append("\n}\n")
    with open(OUT, "w") as f:
        f.write("\n".join(parts))
    print("wrote %s: %d bytes, %d methods" % (OUT, size, idx))


if __name__ == "__main__":
    main()
