
# Functions to wrap the gmaps functionality -------------------------------


#' Get Metres Distance
#'
#' @description Using an origin-destination data frame, get the driving distance
#'   in metres using the google maps API. Includes a default limiter to 10
#'   queries to prevent accidental use of too many rows.
#'
#'   This querying process is quite slow, with a rate of approx. 5,000 queries
#'   per hour. This is more than adequate for specific journeys, but when
#'   working with the fairly brute force methods in this project is not really
#'   viable. As an example, without some heuristics to narrow down the search,
#'   there are ~19 Million combinations of postcodes which hold active charging
#'   points. While strategies can be introduced to improve the efficiency of
#'   this, by dropping connections which we know are going to be unfeasable, any
#'   professional or high refresh rate application of this will likely need a
#'   'premium' api key, with a higher query frequency.
#'
#' @param orig_dest_df Data.frame/tibble/data.table of origin and destination
#'   points. Postcodes are used in this project, but any legal input to the maps
#'   API will work here
#' @param smol Volume limiter switch, default TRUE
#'
#' @return
#' @export
#'
#' @examples
ejp_get_distance_metres <- function(orig_dest_df, smol = TRUE){
        if(smol){
                used_links <- head(orig_dest_df, 10)
        } else {
                used_links <- orig_dest_df 
        }
        
        gmaps_output <- gmapsdistance(
                origin = used_links$postcode_origin
                , destination = used_links$postcode_destin
                , combinations = "pairwise"
                , mode = "driving"
                , shape = "long"
                , key = maps_key
                )
        status_report <- dplyr::count(gmaps_output$Status, status)
        print(status_report)
        gmaps_output$Distance
}
