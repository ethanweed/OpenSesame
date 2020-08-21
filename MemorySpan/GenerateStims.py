import random

nums = [1,2,3,4,5,6,8,9]

for j in range(10):
    n = []
    for i in range(9):
       ns = random.choice(nums)
       n.append(ns)
    print(n)
    
import string

letters = list(string.ascii_lowercase)

for j in range(10):
    n = []
    for i in range(9):
       ns = random.choice(letters)
       n.append(ns)
    print(n)  




