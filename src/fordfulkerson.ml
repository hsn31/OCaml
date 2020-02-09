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


(*Trouver le flot max possible pour incrémenter le path - autrement dit la capacité minimale *)
let rec capamax graph origin acum = function
  | [] -> acum
  | id :: rest -> 
      let lbl = find_arc graph origin id in
        match lbl with
          | Some l -> capamax graph id (min acum l) rest
          | _ -> failwith "Erreur dans le graph (capamax de fordfulkerson.ml)"


(*Appliquer ce flot à l'ensemble du path*)
let rec apply graph flot id1 path = match path with 
  | None -> graph
  | Some [] -> graph
  | Some (id::rest) ->  
   
    let new_graph1 = add_arc graph id1 id (-flot) in 
    let new_graph2 = add_arc new_graph1 id id1 flot in

    apply new_graph2 flot id (Some q) 
    
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
            let val = find_path graph (List.append list [id]) id id2 in
               if val = None then loop rest else val

  in

  loop (out_arcs graph id1)

  (* A Vérifier *)
let get_inflow gr idend =
  let rec sum_arc  = function
  |[] -> 0
  |(_,lbl)::b -> lbl + sum_arc b
  in 
  let my_arc = out_arcs gr idend in sum_arc my_arc
  ;;

(* Corps de  ALgorithme de Ford_Fulkerson *)

(*Le plus simple est de créer une fonction intermédiaire permettant de 1- Trouver la capacité max, 2- de mettre à jour les flots *)
let iter graph id1 path =
  (*capamax graph origin acum path *)
  let flot = capamax graph id1 max path in
  apply graph flot id1 path
  ;;


(*fordfulkerson revient ainsi à appeler plusieurs fois iter *)
let rec ford_fulkerson graph id1 id2= 

    match find_path graph [] id1 id2 with 
    |None -> Printf.printf "Flow max du graphe : %d \n%!" (get_inflow graphe2 id2); graphe2
    |Some x -> ford_fulkerson (iter graph id1 x) id1 id2
    ;;