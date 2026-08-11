# Compiler Design Lab — Experiments 1 to 6

This repository contains the programs for the first six experiments of the **Compiler Design Laboratory** using **FLEX and BISON**.

## Requirements

Install the following tools before running the programs:

* FLEX
* BISON
* GCC
* Linux / WSL / Unix-like environment

### Check Installation

```bash
flex --version
bison --version
gcc --version
```

---

# Experiment 1 — Lexical Analyzer with Symbol Table

## Aim

To develop a lexical analyzer using FLEX to recognize:

* Identifiers
* Constants
* Comments
* Operators

and create a symbol table while recognizing identifiers.

## Files

```text
symtab.l
input.c
```

## Compile

```bash
flex symtab.l
gcc lex.yy.c -o symtab -lfl
```

## Run

```bash
./symtab input.c
```

## Sample Input

```c
int a = 10;

// sum variable

b = a + 5;
```

## Sample Output

```text
Identifier : int
Identifier : a
Operator : =
Constant : 10
Comment : // sum variable
Identifier : b
Operator : =
Identifier : a
Operator : +
Constant : 5

SYMBOL TABLE
S.No    Name
1       int
2       a
3       b
```

## Concept

FLEX scans the input and matches the input against regular expressions. Whenever an identifier is recognized, it is inserted into the symbol table.

---

# Experiment 2 — Lexical Analyzer Using FLEX

## Aim

To implement a lexical analyzer using FLEX that recognizes different tokens in a C program.

The program recognizes:

* Keywords
* Identifiers
* Numbers
* Operators
* Delimiters
* Preprocessor directives
* Header files

## File

```text
lexer.l
```

## Sample Input File

Create `iplex.c`:

```c
#include<stdio.h>

void main()
{
    int x;
    x = 10;
}
```

## Compile

```bash
flex lexer.l
gcc lex.yy.c -o lexer -lfl
```

## Run

```bash
./lexer iplex.c
```

## Sample Output

```text
Preprocessor Directive : #include
Header File : <stdio.h>
Keyword : void
Identifier : main
Delimiter : (
Delimiter : )
Delimiter : {
Keyword : int
Identifier : x
Delimiter : ;
Identifier : x
Operator : =
Number : 10
Delimiter : ;
Delimiter : }
End of file
```

## Concept

The lexical analyzer divides the source program into tokens. Each token is identified using a regular expression defined in the FLEX program.

---

# Experiment 3 — Arithmetic Expression Validation

## Aim

To write a program using FLEX and BISON to recognize a valid arithmetic expression containing:

* `+`
* `-`
* `*`
* `/`
* Parentheses
* Identifiers
* Numbers

## Files

```text
art_expr.l
art_expr.y
```

## Compile

Run the following commands in order:

```bash
flex art_expr.l
bison -d art_expr.y
gcc lex.yy.c art_expr.tab.c -o art_expr -lfl
```

## Run

```bash
./art_expr
```

## Valid Input

```text
a+b*c-d/e
```

## Output

```text
Enter the Expression:
a+b*c-d/e
Valid Expression
```

## Invalid Input

```text
a=b
```

## Output

```text
Enter the Expression:
a=b
Invalid Expression
```

## Concept

FLEX identifies the individual tokens, while BISON checks whether the sequence of tokens follows the grammar of a valid arithmetic expression.

Operator precedence is handled using:

```yacc
%left '+' '-'
%left '*' '/'
%right UMINUS
```

---

# Experiment 4 — Valid Variable Recognition

## Aim

To recognize a valid variable that starts with a letter followed by any number of letters or digits.

### Valid Examples

```text
abc
add
add1
variable123
```

### Invalid Examples

```text
1add
123abc
```

## Files

```text
valvar.l
valvar.y
```

## Compile

```bash
flex valvar.l
bison -d valvar.y
gcc lex.yy.c valvar.tab.c -o valvar -lfl
```

## Run

```bash
./valvar
```

## Test 1

Input:

```text
add
```

Output:

```text
Enter the variable:
add
Valid variable
```

## Test 2

Input:

```text
add1
```

Output:

```text
Enter the variable:
add1
Valid variable
```

## Test 3

Input:

```text
1add
```

Output:

```text
Enter the variable:
1add
Invalid variable
```

## Concept

The grammar requires the first character to be a letter:

```text
variable → var

var → var DIG
     | var LET
     | LET
```

Therefore, a variable cannot begin with a digit.

---

# Experiment 5 — C Control Structure Validation

## Aim

To recognize valid control structure syntax of the C language using FLEX and BISON.

The program handles structures such as:

* `if`
* `if-else`
* `while`
* `for`
* `switch-case`

## Files

```text
control.l
control.y
```

## Compile

```bash
flex control.l
bison -d control.y
gcc lex.yy.c control.tab.c -o control -lfl
```

## Run

```bash
./control
```

## Example 1 — IF

Input:

```c
if (x < 5) { y = 10; }
```

Output:

```text
Enter a C control structure syntax:
Valid control structure syntax.
```

## Example 2 — WHILE

Input:

```c
while (x < 10) { y = 5; }
```

Output:

```text
Enter a C control structure syntax:
Valid control structure syntax.
```

## Example 3 — Invalid Syntax

Input:

```c
if (x < 5
```

Output:

```text
Enter a C control structure syntax:
Invalid control structure syntax.
```

## Concept

FLEX identifies control structure keywords and symbols and passes them as tokens to BISON.

BISON then checks whether those tokens match the grammar for valid C control structures.

---

# Experiment 6 — Calculator Using FLEX and BISON

## Aim

To implement a calculator using FLEX and BISON.

The calculator performs:

* Addition
* Subtraction
* Multiplication
* Division
* Parenthesized expressions
* Unary minus

## Files

```text
cal.l
cal.y
```

## Compile

```bash
flex cal.l
bison -d cal.y
gcc lex.yy.c cal.tab.c -o calc -lfl
```

## Run

```bash
./calc
```

## Example 1

Input:

```text
2+2
```

Output:

```text
Enter the expression:
Answer: 4
```

## Example 2

Input:

```text
10+5*2
```

Output:

```text
Enter the expression:
Answer: 20
```

## Example 3

Input:

```text
(10+5)*2
```

Output:

```text
Enter the expression:
Answer: 30
```

## Example 4

Input:

```text
20/4
```

Output:

```text
Enter the expression:
Answer: 5
```

## Concept

FLEX recognizes numbers and operators. BISON parses the arithmetic expression and evaluates it using semantic actions.

Operator precedence is defined as:

```yacc
%left '+' '-'
%left '*' '/'
%right UMINUS
```

Therefore:

```text
10 + 5 * 2
```

is evaluated as:

```text
10 + (5 * 2)
```

giving:

```text
20
```

---

# Common Compilation Pattern

Experiments 3–6 use both FLEX and BISON.

The general procedure is:

```bash
flex filename.l
bison -d filename.y
gcc lex.yy.c filename.tab.c -o output -lfl
./output
```

For example:

```bash
flex cal.l
bison -d cal.y
gcc lex.yy.c cal.tab.c -o calc -lfl
./calc
```

---

# Experiment Summary

| Experiment | Topic                             | Tools        |
| ---------- | --------------------------------- | ------------ |
| 1          | Lexical Analyzer + Symbol Table   | FLEX         |
| 2          | Lexical Analyzer                  | FLEX         |
| 3          | Arithmetic Expression Recognition | FLEX + BISON |
| 4          | Variable Recognition              | FLEX + BISON |
| 5          | C Control Structure Recognition   | FLEX + BISON |
| 6          | Calculator                        | FLEX + BISON |

---

# Important Viva Points

### What is FLEX?

FLEX is a tool used to generate lexical analyzers. It identifies tokens using regular expressions.

### What is BISON?

BISON is a parser generator used to verify whether a sequence of tokens follows a specified grammar.

### What is `yytext`?

`yytext` contains the text of the token currently matched by FLEX.

### What is `yylex()`?

`yylex()` is the lexical analyzer function generated by FLEX.

### What is `yyparse()`?

`yyparse()` is the parser function generated by BISON.

### What is `yywrap()`?

`yywrap()` is called when FLEX reaches the end of the input. Returning `1` indicates that there is no more input.

### Why use `bison -d`?

The `-d` option generates the BISON header file containing token definitions, such as:

```text
cal.tab.h
```

FLEX includes this header file so that it can return the correct tokens.

### Why use `-lfl`?

`-lfl` links the FLEX library while compiling the generated C program.

---

# Quick Exam Revision

Remember this structure:

```text
FLEX
  ↓
Lexical Analysis
  ↓
Tokens
  ↓
BISON
  ↓
Syntax Analysis
  ↓
Result
```

For a FLEX-only experiment:

```bash
flex file.l
gcc lex.yy.c -o output -lfl
./output
```

For a FLEX + BISON experiment:

```bash
flex file.l
bison -d file.y
gcc lex.yy.c file.tab.c -o output -lfl
./output
```

## Experiments to prioritize

If you have limited preparation time:

1. **Experiment 3 — Arithmetic Expression**
2. **Experiment 4 — Variable Recognition**
3. **Experiment 6 — Calculator**
4. **Experiment 2 — Lexical Analyzer**
5. **Experiment 1 — Symbol Table**
6. **Experiment 5 — Control Structures**

These six experiments cover the main FLEX/BISON patterns used in the first part of the lab manual.
