open Graph
open Tools
open Printf

(*
* Déroulé de l'Algorithme
* 
* Trouver un chemin qui augmente le flot max.(0(E))
* Trouver sur le chemin concerné le flot max (compute the bottleneck capacity : calculer la capacité du goulot d'étranglement)
* Mettre à jour les labels des arcs concernés + le flot max
* 
* Opération à répéter tant qu'il y a des chemins disponibles (à partir de la source, et qu'il reste de la capacité)
* Attention label négatif impossible
*
* Une fois l'algo terminé, calculer le flot max comme la somme des labels entrants - sortants de l'ID final
* 
* 
*)

type path = id list
type graphe = int graph

(*Trouver le flot max possible pour incrémenter le path - autrement dit la capacité minimale *)
let rec capamax graph origin acum = function
  | [] -> acum
  | id :: rest -> 

    let lbl = find_arc graph origin id in
    match lbl with
      | None -> 0
      | Some l -> capamax graph id (min acum l) rest



(*Appliquer ce flot à l'ensemble du path*)
let rec apply graph flot id1 path = 
  match path with 
    | [] -> graph
    | id::rest ->  

      let new_graph1 = add_arc graph id1 id (-flot) in 
      let new_graph2 = add_arc new_graph1 id id1 flot in

      apply new_graph2 flot id (rest) 

;;


(* graph   := explicite
   list    := liste des noeuds déjà utilisé
   id1  := noeud départ
   id2  := noeud arrivé*)

let rec find_path graph list id1 id2 = 

  (*On utilise une fonction auxiliaire loop *)
  let rec loop l = 

    match l with 
    | [] -> None
    | (id , lab) :: rest -> 
      if lab = 0 then loop rest

      else if id == id2 then Some (List.append list [id])  

      else if List.exists (fun i -> i = id) list then loop rest 

      else 
        let v = find_path graph (List.append list [id]) id id2 in
        if v = None then loop rest else v

  in

  loop (out_arcs graph id1)


let get_max graph id =
  let rec sum_arc  = function
    |[] -> 0
    |(_,lbl)::rest -> lbl + sum_arc rest
  in 
  let my_arc = out_arcs graph id in sum_arc my_arc
;;

(* Corps de  ALgorithme de Ford_Fulkerson *)

(*Le plus simple est de créer une fonction intermédiaire permettant de 1- Trouver la capacité max, 2- de mettre à jour les flots *)
(*12 pour iter  *)

let iter graph12 id1 path12 =
  (*capamax graph origin acum path *)

  (* # Int32.max_int;;
- : int32 = 2147483647l *)
  let _ = Printf.printf "Ford_Fulkerson iter \n%!" in
  let f = capamax graph12 id1 max_int path12 in
  
  apply graph12 f id1 path12
;;


(*fordfulkerson revient ainsi à appeler plusieurs fois iter *)
let rec ford_fulkerson graph id1 id2= 

  let _ = Printf.printf "Ford_Fulkerson \n%!" in

  match find_path graph [] id1 id2 with 
  |None -> Printf.printf "Flow max du graphe : %d \n%!" (get_max graph id2); graph
  |Some x -> ford_fulkerson (iter graph id1 x) id1 id2 ;

;;