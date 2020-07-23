

#' Generate Network
#'
#' @description Function to generate the network of charge points in
#'   .input_paths, which are within the range of vehicle of maximum charge
#'   distance .limit
#'
#' @param .input_paths
#' @param .limit
#'
#' @return
#' @export
#'
#' @examples
ejp_PurGenerateNetwork <- function(.input_paths, .limit){
        .input_paths %>% 
                filter(Distance <= .limit) %>% 
                as_tbl_graph(directed = FALSE)
}

#' Function to get the shortest path
#'
#' @description function to output the graph object which is the shortest path
#'   from the origin to the destination, when considering the weights encoded in
#'   the graph, in this case the distance in metres.
#'
#' @param .input_graph
#' @param .origin The indicies of the node chosen as the origin
#' @param .destin The indicies of the node chosen as the destination
#'
#' @return
#' @export
#'
#' @examples
ejp_PurGetShortestPath <- function(.input_graph, .origin, .destin){
        node_names <- .input_graph %>%
                activate(nodes) %>%
                pull(name)
        
        from <- which(node_names == .origin)
        to <-  which(node_names == .destin)
        .input_graph %>% 
                morph(to_shortest_path, from = from, to = to, weights = Distance)
}