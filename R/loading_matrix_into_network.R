

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