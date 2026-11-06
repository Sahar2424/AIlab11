:- dynamic letters/1.

letters([a, b, c]).

start :-
    nl,
    writeln('Hi, This is the "Name Game".'),
    writeln('You will be given a set of English letters in which you will add, delete or move to create your name.'),
    game_loop.

game_loop :-
    nl,
    writeln('Choose from the following:'),
    writeln('1- Display the current set of letters'),
    writeln('2- Add a letter'),
    writeln('3- Add a letter at the top'),
    writeln('4- Add a letter at the bottom'),
    writeln('5- Delete a letter'),
    writeln('6- Delete all letters'),
    writeln('7- Exit'),
    write('Enter your choice....'), nl,
    write('|: '),
    read(Choice),
    handle_choice(Choice).

handle_choice(1) :-
    letters(L),
    write('Current set of letters: '), writeln(L),
    game_loop.

handle_choice(2) :-
    write('Enter the letter to add: '),
    read(Letter),
    letters(L),
    append(L, [Letter], NewL),
    retractall(letters(_)),
    assertz(letters(NewL)),
    write('Added '), write(Letter), writeln(' successfully.'),
    game_loop.

handle_choice(3) :-
    write('Enter the letter to add at the top: '),
    read(Letter),
    letters(L),
    NewL = [Letter | L],
    retractall(letters(_)),
    assertz(letters(NewL)),
    write('Added '), write(Letter), writeln(' at the top successfully.'),
    game_loop.

handle_choice(4) :-
    write('Enter the letter to add at the bottom: '),
    read(Letter),
    letters(L),
    append(L, [Letter], NewL),
    retractall(letters(_)),
    assertz(letters(NewL)),
    write('Added '), write(Letter), writeln(' at the bottom successfully.'),
    game_loop.

handle_choice(5) :-
    write('Enter the letter to delete: '),
    read(Letter),
    letters(L),
    (   select(Letter, L, NewL)
    ->  retractall(letters(_)),
        assertz(letters(NewL)),
        write('Deleted '), write(Letter), writeln(' successfully.')
    ;   write('Letter '), write(Letter), writeln(' not found in the set.')
    ),
    game_loop.

handle_choice(6) :-
    retractall(letters(_)),
    assertz(letters([])),
    writeln('All cleared.'),
    game_loop.

handle_choice(7) :-
    writeln('bye').

handle_choice(_) :-
    writeln('Invalid choice'),
    game_loop.
