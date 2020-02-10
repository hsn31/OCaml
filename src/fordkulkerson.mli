open Graph

(* path = liste de différents noeuds *)
type path = id list
type graphe = int graph

val find_path : graphe -> id list -> id -> id -> path option

val apply : graphe -> int -> id -> path -> graphe

val capamax :  graphe  -> id -> int -> path -> int

val get_max : graphe -> int -> int

val iter : int -> graphe -> id -> path -> graphe

val ford_fulkerson : graphe -> id -> id -> graphe