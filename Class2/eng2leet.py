import pandas as pd
import random

# get "leet" characters from wikipedia
raw = pd.read_html('https://en.wikipedia.org/wiki/Leet')

# make a dictionary with english letters as keys, and leet characters as values.
# I have just chosen the first option for the leet characters, but there are many more
keys = list(raw[0])
values = list(raw[0].iloc[0])
values = [x.split(' ') for x in values]
values = [x[0] for x in values]
leet_dict = {keys[x]: values[x] for x in range(len(keys))}

# define a function that takes a string and a number of characters to replace as input
# the function returns the string with N characters replaced with leet characters
def eng2leet(word, num_mod):
    if num_mod > len(word):
        print('Your word is not that long. Choose fewer letters to replace!')
    else:
        temp = [*word]
        chars = random.sample(list(word), num_mod)
        for s, letter in enumerate(temp):
            for char in chars:
                if letter == char:
                     temp[s] = leet_dict[char]
        return(''.join(temp))
    
# usage:
#eng2leet('VINE', 0)
#eng2leet('VINE', 1)
#eng2leet('VINE', 2)