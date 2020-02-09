open Graph

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



