# Coding test question number 3: Write a program that can parse an integer array and verify that it is in social security number format.
#    SSN number format is [3 digits - 2 digits - 4 digits] Ex: 123-45-5678
#
# Ken Treadway - ktreadway@ktreadway.com

import sys
import re

# This regex allows for dashes or no dashes, but the numbers must be correct.
SSN_RE=re.compile(r'^\d{3}-?\d{2}-?\d{4}$', re.I)

def valid_ssn(s):
    """Takes the string 's' and returns a boolean value if the string matches the SSN_RE regex."""
    assert type(s) == str, "'s' must be a string."

    # RegexObjects return MatchObjects, but we want a boolean.
    if SSN_RE.match(s):
        return True
    else:
        return False

# Allow an input from the command line, but have a sane default.
if len(sys.argv) == 2:
    ssn = sys.argv[1]
else:
    ssn = '123-45-5678'

if valid_ssn(ssn):
    print "%s is a valid SSN." % ssn
else:
    print "%s is not a valid SSN." % ssn
