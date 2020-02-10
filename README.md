Ocaml project on Ford-Fulkerson, INSA Toulouse, 4IR, 2019-2020, S1. 

How to test if it works ? :
 - ./ftest.native graphs/graph1 0 5 graphs/ff_graph1 puis dot -Tsvg graphs/ff_graph1 > graphs/ff_graph1.svg
 - ./ftest.native graphs/graph2 0 3 graphs/ff_graph2 puis dot -Tsvg graphs/ff_graph2 > graphs/ff_graph2.svg
 - To generate an image from a dot file, you can use : dot -Tsvg your-dot-file > some-output-file.svg


A makefile also provides basic automation :
 - `make` to compile. This creates an ftest.native executable
 - `make format` to indent the entire project

