open Graph

(* path = liste de différents noeuds *)
type path = id list

val find_path : int graph -> id list -> id -> id -> path option

val apply : int graph -> int -> id -> path -> int graph

val capamax :  int graph  -> id -> int -> id list -> int

val get_inflow : int graph -> int -> int

val iter : int -> int graph -> id -> path -> int graph

val ford_fulkerson : int graph -> id -> id -> int graph