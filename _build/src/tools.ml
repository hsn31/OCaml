open Graph
open Printf

(* assert false is of type ∀α.α, so the type-checker is happy. *)

(* returns a new graph having the same nodes than gr, but no arc. (code : one line)*)
(* n_fold gr f acu    &    new_node gr id*)
let clone_nodes gr = 
  n_fold gr new_node empty_graph;;


(* maps all arcs of gr by function f. (⩽3 lines)*)
let gmap gr f = (*assert false*)

  let f1 gr2 id1 id2 label =
    (*new_arc gr id1 id2 lbl   => on remplace label=f label*)
    new_arc gr2 id1 id2 (f label)
  in 
  e_fold gr f1 (clone_nodes gr) 
  
  ;;


(*adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created.*)
let add_arc graph id1 id2 n = match find_arc graph id1 id2 with
  (*L'arc n'existe pas, alors on le crée avec la valeur n*)
  | None -> new_arc graph id1 id2 n

(* sinon on utilise quand meme new_arc (If an arc already exists between id1 and id2, its label is replaced by lbl. ) mais avec le label lbl+n*)
| Some lbl ->  new_arc graph id1 id2 (lbl + n) 
