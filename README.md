# Connect 4 in Scheme

Use this [GitHub Classroom link](https://classroom.github.com/a/U3xDWEk-) to create a repo for this project.

**!!! Important !!!** This is an _individual_ assignment.  You _may not_ work in teams.

## Overview

For this assignment you will implement the game [Connect 4](https://kevinshannon.dev/connect4) using the [Kawa](https://www.gnu.org/software/kawa) dialect of Scheme. 

You will be adding two additional features:
1. The size of the board will be configurable.
2. The run length needed to win will be configurable.  (So, I guess the game is really "Connect X").

I placed a sample solution on EOS at `/home/kurmasz/public/CIS343/c4demo`.  Your board and workflow need not be identical to mine.  However, I will be using automated "system tests", so your input and output needs to formatted carefully.  In addition, your implementation **must** follow a handful of rules, so **_Be sure to read the Details section below_**!

## Objectives

This assignment has two main objectives
1. Provide experience writing code in a functional language.
2. Provide a means of comparing functional programming (Scheme) to an imperative language (C)

In particular, think about the following as you write your code:
1. What aspects of this program are easier to write in Scheme?
2. What aspects of this program are easier to write in C?

## Details

This project uses the same interface rules as [the C version](https://github.com/kurmasz-assignments/cis343-connect4-c).  Review them if necessary.

### Implementation Requirements

1. As with the C version of the assignment, you may only have one function / block of code that detects "x in a row".  In other words, *don't repeat yourself*.

2. Use a pure functional style.  In particular, **!! You may not mutate any objects !!** (even though Scheme lets you do this on occasion). For example, when you "update" the game board, you must build a new game board that is a copy of the old board with the new token added.

### Hints

2. The included `connect4.scm` file includes some functions you may find helpful.  You are not required to use them.
3. Nesting functions will reduce the number of parameters you end up passing.

### Code Quality

Your code must follow standard design principles.  For example, be sure to
   1. Use comments 
   2. Divide your code into appropriately-sized functions and files
   3. Make sure your code is neat, well-organized, and well-organized

## Testing / Test Driven Development

You must use a Test Driven Development (TDD) workflow.  If done well, your system tests from the C version of Connect 4 should also work for this project.

## Submission

When your initial tests are complete, check in your code with "[Check Tests]" in the commit message.

When your project is complete (has a complete set of tests, has a working game, passes my automated tests, and is well-formatted and well-documented), 
check in your code with "[Grade Me]" in the commit message.

**Important**: Just because your code passes the GitHub tests, does _not_ mean it meets all the requirements. The GitHub tests do not, for example, check the user interface.  They also don't check the completeness of your unit tests or the quality of your code.

## Academic Honesty

One key purpose of the GitHub classroom setup is to automatically verify that submitted code is bug-free.  Attempting to subvert this system and generate a "false positive" (for example, by modifying files such as the Makefile) is a serious violation of Academic Honesty and could result in a failing grade in the course.

Attempting to reverse engineer the sample solution through de-compiling or other means is a serious violation of Academic Honesty and could result in a failing grade in the course.  Similarly, writing tests is an important part of the software development process. The automated tests are a part of this project's "solution".  Attempting to access the specific test cases through means included, but not limited to, de-compiling and print statements is a serious violation of Academic Honesty and could result in a failing grade in the course.

Hiding and/or obfuscating GitHub activity through means such as rebasing, squashing, or outright deleting test runs is a serious violation of Academic Honesty and could result in a failing grade in the course.



