

import random

def generate_random_string(words, numbers):
    # Extracting two characters from each word
    word_substrings = [word[:2] for word in words]

    # Selecting 5 random two-character strings from numbers list
    number_substrings = random.sample(numbers, 5)

    # Combining both lists
    combined = word_substrings + number_substrings

    # Shuffling the combined list for randomness
    random.shuffle(combined)

    # Concatenating all elements to form the final string
    return ''.join(combined)


words = [
    "denkers",
    "rebecca",
    "adriaan",
    "fitzgerald",
    "ryan",
    "vanauken",
    "francisxavier",
    "helenaprudence",
    "shapley",
    "padgetbrook",
    "oxford",
    "cosen",
    "chenango"
]
numbers = ["08","19","78","11","22","77","09","08","10","10","04","03","12","19"]

random_string = generate_random_string(words, numbers)
print(random_string)





pwd = "VanFiry!78ox08"