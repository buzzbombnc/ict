# Coding test question number 2: Write a program to reverse a string "abcdef" --> "fedcba".
#
# Ken Treadway - ktreadway@ktreadway.com

import sys

def string_reverse(s):
    """Takes the string 's' and returns the reversed string."""
    assert type(s) == str, "'s' must be a string."

    # Take the string, convert it a list, reverse, and join it as a string.
    return ''.join(reversed(list(s)))

# Allow an input from the command line, but have a sane default.
if len(sys.argv) == 2:
    s = sys.argv[1]
else:
    s = 'abcdef'

print string_reverse(s)
