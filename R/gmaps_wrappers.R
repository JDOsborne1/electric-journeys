
# Functions to wrap the gmaps functionality -------------------------------


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
