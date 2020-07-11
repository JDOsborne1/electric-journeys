
# Loading charge point data -----------------------------------------------

#' Load Charge Data
#'
#' @description Function to load the charge points data, making use of the cache
#'   where available. Currently defaults to using the cache all the time for the
#'   poc
#'
#' @param loc parameter to describe the location of the points data, defaults to
#'   null
#'
#' @return
#' @export
#'
#' @examples
ejp_load_charge_data <- function(loc = NULL){
        if(is.null(loc)){
                
        } else {
                stop("Not currently implemented any non cached elements")
        }
}

#' Clean Raw Charge Data
#'
#' @description  Function to clean up the data in the provided charging points
#'   data
#'
#' @param file_loc
#'
#' @return
#' @export
#'
#' @examples
ejp_clean_raw_charge_data <- function(file_loc){
        file_loc %>% 
                readr::read_csv() %>% 
                dplyr::filter(chargeDeviceStatus != "Out of service") %>% 
                dplyr::select(
                        chargeDeviceID
                        , latitude
                        , longitude
                        , postcode
                        , chargeDeviceStatus
                        , access24Hours
                        , connector1Type
                        , connector1RatedOutputKW
                        ) %>% 
                dplyr::distinct(
                        postcode
                        , .keep_all = TRUE
                ) %>% 
                dplyr::filter(postcode != "20:00") %>% 
                dplyr::mutate(
                        postcode = stringr::str_replace_all(postcode, " ", "")
                        , post_len = stringr::str_length(postcode)
                        
                        ) %>% 
                dplyr::filter(post_len >= 5) 
}

#' Expand Charge data
#' 
#' @description  Function which is intended to expand the postcodes for the valid charge points into the full grid of possible connections in the network. 
#'
#' @param charge_data 
#'
#' @return
#' @export
#'
#' @examples
ejp_expand_clean_charge_data <- function(charge_data, smol = TRUE){
        postcodes <- charge_data %>% 
                # Restricting ontly to the postcodes
                dplyr::pull(postcode) 
        
        if(smol){
                used_codes <- postcodes[1:10]
        } else {
                used_codes <- postcodes
        }
        
        combinations(n = length(used_codes), r = 2,  v = used_codes, repeats.allowed = FALSE) %>% 
                `colnames<-`(c("postcode_origin", "postcode_destin")) %>% 
                as_tibble()
}

