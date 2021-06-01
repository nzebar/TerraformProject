#####################
## Module Overview ##
#####################

    ## Default Route Table ##
    This module allows you to create a default route table. Use the following example to create a default route table for the VPC:

        manage_default_route_table = true <- Whether or not to create a default route table.
        default_route_table_name = "Default_Route_Table" <- To be merged with tags below
        default_route_table_id = module.VPC_VPC1.vpc_default_route_table_id <- The VPC default route table id to be used
        default_route_table_propagating_vgws = [] <- List of virtual gateways for propogation
        default_route_table_routes = { <- Mapping of map(string) to declare routes
            route_example = {
                DestinationArgumnet = DestinationValue
                TargetArgument = TargetValue
            }
        }

        default_route_table_tags = {
            "Key" = "Value" <- Tags to associate with the default route table
        }

    ## Route_Tables ##
    This module allows you to create a multiple route tables with associated routes inside the single "route_tables" variable.
    Use the following example to 