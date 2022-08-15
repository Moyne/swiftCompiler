                PARSER AND SEMANTICS TO DO LIST:
            {The ticked ones are already done(kinda)}
- [x] for in loop
- [x] while conditions
- [x] if conditions
- [x] arrays
- - add full support for them as function parameters
- [x] inout declaration for functions
- [ ] *generics*
- [ ] *optionals*
- [ ] ***semantic analyzer***
- [ ] *classes*


After a while I figured out that the only way to have the ability to use multidimensional arrays as function parameters is to have a single pointer(ex. i32* not i32***) as the parameter type and together with that parameter add also x-1 parameters that represent the size of the x-1 dimension, not x because the higher level dimension is useless for calculus.
After this load once and gep easily, not only gep because gep doesn't understand ** as I discovered.

Also I need to refactor Value class and put all of the prints into a single append function to simplify stuff.

Also maybe add a GLOBALDEC non terminal so we can directly avoid global instructions.