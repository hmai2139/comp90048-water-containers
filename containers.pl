/* COMP90048 S1, 2021 Workshop 4 (Week 5).
** Author: Hoang Viet Mai, 813361, <vietm@student.unimelb.edu.au>.
** Purpose: Solve the water containers problem.
*/

/* Problem: You have two containers, one able to hold 5 litres and the other
** able to hold 3 litres. Your goal is to get exactly 4 litres of water 
** into the 5 litre container. 
*/

:- ensure_loaded(library(clpfd)).

% Containers and their capacities.
capacity(3, small).
capacity(5, big).

% Desired states of a given container.
desired(4, big).

% Valid states.
state(Small, Big) :-
    between(0, 3, Small),
    between(0, 5, Big).

% fill(To), where To is the capacity of the container to fill from the well.
fill(To) :-
    capacity(To, _).

% empty(From), where From is the capacity of the container to empty
empty(From) :-
    capacity(From, _).

% pour(From,To) where From is capacity of the container to pour from and 
% To is the capacity of the container to pour into
pour(From, To) :-
    capacity(From, _),
    capacity(To, _).

% Computes the effect of each of the possible moves. 
% This predicate takes the initial state, final state, 
% and an action (one of fill(To)/empty(From)/pour(From,To) as parameters,
% where this particular move turns the initial state into the next state. 
% For example, a movement of pour(Small,Big) from small to big turns
% an initial state of (small: 2, big: 1) into the next state (small: 0, big: 3).

% Fills the small container.
effect(state(S0, B0), fill(To), state(To, B0)) :-
    S0 #< To,
    capacity(To, small).

% Fills the big container.
effect(state(S0, B0), fill(To), state(S0, To)) :-
    B0 #< To,
    capacity(To, big). 

% Empties the small container.
effect(state(S0, B0), empty(From), state(0, B0)) :-
    S0 #> 0,
    capacity(From, small).

% Empties the big container.
effect(state(S0, B0), empty(From), state(S0, 0)) :-
    B0 #> 0,
    capacity(From, big).

% Pour from the small container to the big container.
effect(state(S0, B0), pour(From, To), state(S1, B1)) :-
    S0 #> 0,
    Unfilled #= To - B0,
    Transfer #= min(S0, Unfilled),
    S1 #= S0 - Transfer,
    B1 #= B0 + Transfer,
    capacity(From, small),
    capacity(To, big).

% Pour from the big container to the small container.
effect(state(S0, B0), pour(From, To), state(S1, B1)) :-
    B0 #> 0,
    Unfilled #= To - S0,
    Transfer #= min(B0, Unfilled),
    S1 #= S0 + Transfer,
    B1 #= B0 - Transfer,
    capacity(From, big),
    capacity(To, small).

% Goal reaches when there are four litres of water in the big container.
% Reverse the lists of moves and history to obtain the correct order,
% as new entries are added at the front of each list (to avoid using `append`).
containers(MovesRev, Moves, HistoryRev, History, state(_, Desired)) :-
    desired(Desired, big),
    reverse(Moves, MovesRev),
    reverse(History, HistoryRev).

% Moves and their corresponding effects.
containers(Moves, MoveA, History, HistoryA, CurrentState) :-
    effect(CurrentState, Move, NextState),
    \+ member(NextState, HistoryA),
    containers(Moves, [Move|MoveA], History, [NextState|HistoryA], NextState).

containers(Moves, History) :-
    containers(Moves, [], History, [state(0,0)], state(0,0)).


% Same as the predicates above, except these do not show state history.
containers(MovesRev, Moves, _, state(_, 4)) :-
    reverse(Moves, MovesRev).

containers(Moves, MoveA, History, CurrentState) :-
    effect(CurrentState, Move, NextState),
    \+ member(NextState, History),
    containers(Moves, [Move|MoveA], [NextState|History], NextState).

containers(Moves) :-
    containers(Moves, [], [state(0,0)], state(0,0)).
