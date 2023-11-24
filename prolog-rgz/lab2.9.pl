% Предикат для чтения файла в список строк
read_file_to_lines(FileName, Lines) :-
    open(FileName, read, Stream),
    read_lines(Stream, Lines),
    close(Stream).

read_lines(Stream, Lines) :-
    read_line_to_string(Stream, Line),
    Line \= end_of_file,
    !,
    read_lines(Stream, RestLines),
    Lines = [Line | RestLines].
read_lines(_, []).

% Предикат для подсчета гласных в слове
vowel_count(Word, Count) :-
    string_lower(Word, LowerWord),
    string_chars(LowerWord, Chars),
    include(is_vowel, Chars, Vowels),
    length(Vowels, Count).

is_vowel(Char) :-
    member(Char, ['a', 'e', 'i', 'o', 'u']).

% Измененный предикат для выбора всех слов с наибольшим количеством гласных
words_with_most_vowels(Lines, Words) :-
    maplist(lines_with_most_vowels, Lines, Words).

lines_with_most_vowels(Line, Words) :-
    split_string(Line, " ", "", SplitLine),
    maplist(vowel_count, SplitLine, Counts),
    max_list(Counts, Max),
    findall(Word, (member(Word, SplitLine), vowel_count(Word, Max)), Words).

% Измененный предикат для записи списков слов в файл
write_lines_to_file(FileName, Lines) :-
    open(FileName, write, Stream),
    maplist(write_line(Stream), Lines),
    close(Stream).

write_line(Stream, Words) :-
    atomic_list_concat(Words, ' ', Line),
    writeln(Stream, Line).

% Основной предикат для выполнения задачи
process_files(InputFile, OutputFile) :-
    read_file_to_lines(InputFile, Lines),
    words_with_most_vowels(Lines, WordsList),
    write_lines_to_file(OutputFile, WordsList).


% process_files('/home/alexeynaumov/prolog/input.txt','/home/alexeynaumov/prolog/output.txt').