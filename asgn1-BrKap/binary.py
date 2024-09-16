# Implements operations on binary numbers.
# CSC 225, Assignment 1
# Given code, Winter '23


from unittest.case import _AssertRaisesContext


def add(addend_a, addend_b):
    """
    Add two 8-bit, two's complement binary numbers; ignore carries/overflows.
    TODO: Implement this function. Do *not* convert the numbers to decimal.

    :param addend_a: A bitstring representing the first number
    :param addend_b: A bitstring representing the second number
    :return: A bitstring representing the sum
    """
    result = ""
    carry = False
    # ("00000011", "00000010"), "00000101"

    for x in reversed(range(8)):
        a = addend_a[x]
        b = addend_b[x]
        if not carry:
            if (a == "0" and b == "0"):
                result = "0" + result
                carry = False
            elif ((a == "1" and b == "0") or (a == "0" and b == "1")):
                result = "1"  + result
                carry = False
            else:
                result = "0" + result
                carry = True
        else:
            if (a == "0" and b == "0"):
                result = "1" + result
                carry = False
            elif ((a == "1" and b == "0") or (a == "0" and b == "1")):
                result = "0" + result
                carry = True
            else:
                result = "1" + result
                carry = True
    return result


def negate(number):
    """
    Negate an 8-bit, two's complement binary number.
    TODO: Implement this function. Do *not* convert the number to decimal.

    :param number: A bitstring representing the number to negate
    :return: A bistring representing the negated number
    """
    result = ""
    for x in range(8):
        a = number[x]

        if (a == "0"):
            result+="1"
        else:
            result+="0"
    result = add(result, "00000001")
    return result


def subtract(minuend, subtrahend):
    """
    Subtract one 8-bit, two's complement binary number from another.
    TODO: Implement this function. Do *not* convert the numbers to decimal.

    :param minuend: A bitstring representing the number from which to subtract
    :param subtrahend: A bitstring representing the number to subtract
    :return: A bitstring representing the difference
    """
    a = minuend
    b = subtrahend
    b = negate(b)
    result = add(a, b)
    return result


def binary_to_decimal(number):
    """
    Convert an 8-bit, two's complement binary number to decimal.
    TODO: Implement this function.

    :param number: A bitstring representing the number to convert
    :return: An integer, the converted number
    """
    a = number
    counter = 0

    ## test for if the number is negative
    if number == "11111111":
        return -128
    
    if a[0] == '1':
        counter = -128
        b = negate("00000001") ## adding 1 to -128 until we reach "00000000"
        while a != "10000000":
            a = add(a, b)
            counter += 1
    else:
        b = "11111111" ## doing the opposite with adding -1
        while a != "00000000":
            a = add(a, b)
            counter+=1
    return counter



def decimal_to_binary(number):
    """
    Convert a decimal number to 8-bit, two's complement binary.
    TODO: Implement this function.

    :param number: An integer, the number to convert
    :return: A bitstring representing the converted number
    :raise OverflowError: If the number cannot be represented with 8 bits
    """
    if number > 127 or number < -128:
        msg = "Value cannot overflow"
        raise OverflowError(msg)
    a = number
    b = "00000001"
    if a < 0:
        result = "11111111"
        while a != 0:
            result = add(result, b)
            a += 1
        result = add(negate(result), negate(b))
    else:
        result = "00000000"
        while a != 0:
            result = add(result, b)
            a -= 1

    return result
