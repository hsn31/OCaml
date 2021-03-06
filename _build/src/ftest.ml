open Fordfulkerson
open Tools
open Gfile



(*  
Extrait cours LeBotlan
ocamlc -c graph.ml gfile.ml
ocamlc -c graph.mli graph.ml gfile.mli gfile.ml
ocamlc -o ftest graph.cmo gfile.cmo ftest.ml
./ftest


*)
let () =


  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  (* Rewrite the graph that has been read. *)
  (*let () = write_file outfile graph in *)

  let _ = Printf.printf "ftest à l'intérieur \n%!" in

  (* Test de l'algroithme de FordFulkerson *)
  let graph1 = gmap graph int_of_string in

  let fordfulkerson = ford_fulkerson graph1 source sink in 

  let gstring = gmap fordfulkerson string_of_int in

  let () = write_file outfile gstring ; 
    export outfile gstring 
  in

  ()

