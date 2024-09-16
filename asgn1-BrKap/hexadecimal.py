# Implements operations on hexadecimal numbers.
# CSC 225, Assignment 1
# Given code, Winter '23

zero = "0000"
one = "0001"
two = "0010"
three = "0011"
four = "0100"
five = "0101"
six = "0110"
seven = "0111"
eight = "1000"
nine = "1001"
hexA = "1010"
hexB = "1011"
hexC = "1100"
hexD = "1101"
hexE = "1110"
hexF = "1111"

def binary_to_hex(number):
    """
    Convert a 16-bit binary number to 4-digit hexadecimal.
    TODO: Implement this function.

    :param number: A bitstring representing the number to convert
    :return: A 4-digit hexadecimal string, the converted number
    """
    a = number[0:4]
    b = number[4:8]
    c = number[8:12]
    d = number[12:16]
    
    binArr = [a, b, c, d] 
    result = "0x"
    for bin in binArr:
        if bin == zero:
            result+="0"
        elif bin == one:
            result+="1"
        elif bin == two:
            result+="2"
        elif bin == three:
            result+="3"
        elif bin == four:
            result+="4"
        elif bin == five:
            result+="5" 
        elif bin == six:
            result+="6"  
        elif bin == seven:
            result+="7"
        elif bin == eight:
            result+="8"
        elif bin == nine:
            result+="9"
        elif bin == hexA:
            result+="A"
        elif bin == hexB:
            result+="B"
        elif bin == hexC:
            result+="C"
        elif bin == hexD:
            result+="D"
        elif bin == hexE:
            result+="E"
        elif bin == hexF:
            result+="F"
        else:
            print("somehow something went wrong")
    return result


def hex_to_binary(number):
    """
    Convert a 4-digit hexadecimal number to 16-bit binary.
    TODO: Implement this function.

    :param number: A 4-digit hexadecimal string, the number to convert
    :return: A bitstring representing the converted number
    """
    a = number[2]
    b = number[3]
    c = number[4]
    d = number[5]
    hexArr = [a, b, c , d]
    result = ""
    for hex in hexArr:
        if hex == "0":
            result+="0000"
        elif hex == "1":
            result+="0001"
        elif hex == "2":
            result+="0010"
        elif hex == "3":
            result+="0011"
        elif hex == "4":
            result+="0100"
        elif hex == "5":
            result+="0101"
        elif hex == "6":
            result+="0110"
        elif hex == "7":
            result+="0111"
        elif hex == "8":
            result+="1000"
        elif hex == "9":
            result+="1001"
        elif hex == "A":
            result+="1010"
        elif hex == "B":
            result+="1011"
        elif hex == "C":
            result+="1100"
        elif hex == "D":
            result+="1101"
        elif hex == "E":
            result+="1110"
        elif hex == "F":
            result+="1111"
        else:
            print("somehow something went wrong")

    return result
        
    pass
