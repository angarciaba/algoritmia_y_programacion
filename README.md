The main objective is to give a first "algorithmics and programming" course, employing the procedural paradigm, using a subset of the Ruby language.

The course was offered by the EISC, at Universidad del Valle, Colombia.

Ruby was choosen because of its very simple, clean and coherent syntaxis.

Topics include all the basics (variables, operators, loops, conditionals and functions). Data types are integers, floating points, strings, 1D-arrays and 2D-arrays.

All object oriented syntaxis will be excluded, with some unavoidable exception as Array#length. No iterators, no classes, no mixins, no metaprogramming.

The subset of Ruby keywords will be: def, end, while, for, in, if, elsif, else, true, false. It also be included all arithmetic, relational and logical operators, asignement operator and interpolation operator inside strings.

IO will be made by p, print, puts and gets.chomp.to_i, gets.chomp.to_f and gets.chomp.to_s (for pursuing uniformity).

A tool named pasos.rb is going to be developed here to execute step by step the student ruby program, and showing local variables, for enhancing student comprehension of the algoritms involved.

And there is an additional topic: graphical user interfaces. This is a very demanding problem for this kind of course because all reasonable GUI frameworks nowadays are object oriented. To solve this problem, another tool (named integracionQt.rb) is being developed here to allow novice programmers to use a procedural only interface. This tool will translate this student interface to the very known OO-GUI, Qt4.

Finally, a clarification note: hey guys, I like OO programming as much as the best. And I love Ruby and the Ruby way. But over many decades of teaching programming, we discover that OO paradigm is not as simple as it must be for the novice. It adds an additional abstraction layer that can be excessive for a first programming course. In this kind of course we need to emphasize conditionals, loops, argument passing to functions, strings and arrays. No more and no less. Furthermore, the language employed must not be an obstacle because an inordinate amount of syntaxis. And Ruby fits these needs very well. Much better than Python (I know many great universities prefer Python but I suppose they have not thought it througthly).

Ángel

