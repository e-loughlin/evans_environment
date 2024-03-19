
import random
import numpy as np
import argparse


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--epochs', '-e', dest="num_epochs", type=str, required=True,
                        help='Number of epochs (generations) for the evolutionary algorithm.')

    parser.add_argument('--mut-prob', '-m', dest="mutation_prob", type=str, required=False, default=0.2,
                        help='Mutation probability for any given parameter of an object, per epoch.')

    parser.add_argument('--cross-prob', '-c', dest="crossoer_prob", type=str, required=False, default=0.2,
                        help='Crossover probability for any two objects, per epoch.')

    parser.add_argument('--pop-size', '-e', dest="num_epochs", type=str, required=True,
                        help='Crossover probability for any two objects, per epoch.')

    return parser.parse_args()


class Knapsack:
    def __init__(self, capacity):
        self.capacity = capacity
        self.gems = []
        self.weight = 0

    def add_gem(self, gem):
        if self.weight + gem.weight > self.capacity:
            return False

        else:
            self.gems.append(gem)
            self.weight += gem.weight
            return True


class Gem:
    def __init__(self, value, weight):
        self.weight = weight
        self.value = value

    def __str__(self):
        return (f"Gem: Weight: {self.weight}, Value: {self.value}")


def generate_random_gems(count, val_range, weight_range):
    gems = []
    for i in range(count):
        val = random.randrange(val_range[0], val_range[1])
        wgt = random.randrange(weight_range[0], weight_range[1])
        gem = Gem(val, wgt)
        gems.append(gem)
    return gems


def main():
    print("Knapsack Evolutionary Algorithm")

    gems = generate_random_gems(1000, (1, 50), (1, 50))
    for g in gems:
        print(g)

    # TODO:
    # - Compute fitness, apply probability of selection based on fitness, then reselect population based on that


if __name__ == "__main__":
    main()
