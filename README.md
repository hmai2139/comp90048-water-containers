# comp90048-water-containers
Prolog program to solve a water pouring puzzle.

## Puzzle description
You have two containers, one able to hold 5 litres and the other able to hold 3 litres. Your goal is to get exactly 4 litres of water into the 5 litre container.

You have a well with an unlimited supply of water. For each turn, you are permitted to do one of the following:

1. Completely empty one container, putting the water back in the well.
2. Completely fill one container from the well.
3. Pour water from one container to the other just until the source container is empty or the receiving container is full.

In the last case, the original container is left with what it originally had less whatever unfilled space the receiving container originally had.

All containers begin empty.

Write a Prolog predicate containers(Moves) such that Moves is a list of actions to take in order to obtain the desired state. Each action on the list is of one of the following forms:

1. fill(To), where To is the capacity of the container to fill from the well.
2. empty(From), where From is the capacity of the container to empty.
3. pour(From,To) where From is capacity of the container to pour from andTo is the capacity of the container to pour into.

## Running the program (Prolog required).
1. Get SWI-Prolog from https://www.swi-prolog.org/.
2. Run containers/1 to obtain all lists of steps to solve the puzzle: ```containers(Moves).```
3. Run containers/2 to obtain the steps and states of containers after each step: ```containers(Moves, History).```
