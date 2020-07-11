
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
                dplyr::filter(post_len >= 5) %>% 
                # Restricting ontly to the postcodes
                dplyr::select(postcode_origin = postcode) %>% 
                dplyr::mutate(postcode_destin = postcode_origin) %>% 
                tidyr::expand(postcode_destin, postcode_origin) %>% 
                dplyr::filter(postcode_destin != postcode_origin)
}
