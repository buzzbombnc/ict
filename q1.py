# Coding test Question number 1: Write a program that does: loop through [1..100], if a number is divisible by 3, print 'fizz', divisible by 5 print 'buzz', divisible by 3 & 5, print 'fizzbuzz'
#
# Ken Treadway - ktreadway@ktreadway.com

def check_number(n):
    """Checks integer 'n' and returns an empty string, unless:
       When divisible by 3, return 'fizz'.
       When divisible by 5, return 'buzz'.
       When divisible by 3 and 5, return 'fizzbuzz'."""
    assert type(n) == int, "'n' must be an integer."
    
    out = ''
    if (n % 3 == 0):
        # Check for %5 case too.
        if (n % 5 == 0):
            out = 'fizzbuzz'
        else:
            out = 'fizz'
    elif (n % 5 == 0):
        out = 'buzz'
    return out

# (x)range is zero-based, but we want 1-100.
for i in xrange(1,101):
    print "%d: %s" % (i, check_number(i))
